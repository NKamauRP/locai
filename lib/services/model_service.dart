import 'dart:io';
import 'dart:isolate';
import 'package:llama_cpp_dart/llama_cpp_dart.dart';
import 'package:path_provider/path_provider.dart';

class ModelService {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final modelDir = Directory('${directory.path}/models');
    if (!await modelDir.exists()) {
      await modelDir.create(recursive: true);
    }
    return modelDir.path;
  }

  static Future<File> getModelFile(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  static Future<bool> isModelDownloaded(String fileName) async {
    try {
      final file = await getModelFile(fileName);
      return await file.exists();
    } catch (e) {
      print('Error checking model: $e');
      return false;
    }
  }

  static Future<void> deleteModel(String fileName) async {
    try {
      final file = await getModelFile(fileName);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting model: $e');
      rethrow;
    }
  }

  /// Runs the model engine in a separate isolate to avoid blocking the main UI thread.
  /// Uses llama.cpp for actual AI inference with GGUF models
  static Future<ReceivePort> runInference(
    String modelName,
    String prompt,
    Function(dynamic) onToken,
  ) async {
    final receivePort = ReceivePort();

    try {
      // Spawn isolate for llama.cpp inference
      await Isolate.spawn(_llamaInferenceIsolate, {
        'sendPort': receivePort.sendPort,
        'modelName': modelName,
        'prompt': prompt,
      });

      receivePort.listen((message) {
        onToken(message);
      });

      return receivePort;
    } catch (e) {
      receivePort.close();
      print('Error running inference: $e');
      rethrow;
    }
  }

  static void _llamaInferenceIsolate(Map<String, dynamic> args) async {
    final SendPort sendPort = args['sendPort'];
    final String modelName = args['modelName'];
    final String prompt = args['prompt'];

    try {
      // Get model path
      final directory = await getApplicationDocumentsDirectory();
      final modelPath = '${directory.path}/models/$modelName.gguf';

      // Check if model exists
      final modelFile = File(modelPath);
      if (!await modelFile.exists()) {
        sendPort.send('Error: Model file not found: $modelPath');
        sendPort.send(null); // Signal end
        return;
      }

      // Initialize llama.cpp
      final llama = LlamaCpp();

      // Load model with optimized settings for mobile
      final model = await llama.loadModel(
        path: modelPath,
        params: ModelParams(
          nCtx: 512, // Context window - smaller for mobile
          nBatch: 32, // Batch size
          nThreads: 4, // Use 4 threads (adjust based on device)
          nGpuLayers: 0, // No GPU layers for mobile compatibility
        ),
      );

      // Create context
      final context = await llama.newContext(
        model: model,
        params: ContextParams(nCtx: 512, nBatch: 32, nThreads: 4),
      );

      // Create completion with streaming
      final completer = Completer<String>();
      String fullResponse = '';

      await llama.completion(
        context: context,
        params: CompletionParams(
          prompt: prompt,
          nPredict: 100, // Generate up to 100 tokens
          temperature: 0.8, // Creativity level
          topK: 40, // Top-k sampling
          topP: 0.9, // Top-p sampling
          repeatPenalty: 1.1, // Repetition penalty
          stream: true, // Enable streaming
        ),
        onToken: (token) {
          // Send each token as it arrives
          sendPort.send(token.text);
          fullResponse += token.text;
        },
      );

      // Signal completion
      sendPort.send(null);

      // Cleanup
      await llama.freeContext(context: context);
      await llama.freeModel(model: model);
    } catch (e) {
      sendPort.send('Error during inference: $e');
      sendPort.send(null);
    }
  }
}
