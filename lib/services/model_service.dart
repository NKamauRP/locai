import 'dart:io';
import 'dart:isolate';
import 'dart:async';
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
  /// Currently simulates AI inference - replace with actual llama_cpp_dart implementation when available
  static Future<ReceivePort> runInference(
    String modelName,
    String prompt,
    Function(dynamic) onToken,
  ) async {
    final receivePort = ReceivePort();

    try {
      // Spawn isolate for simulated inference (replace with llama_cpp_dart when API is stable)
      await Isolate.spawn(_simulatedInferenceIsolate, {
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

  static void _simulatedInferenceIsolate(Map<String, dynamic> args) async {
    final SendPort sendPort = args['sendPort'];
    final String modelName = args['modelName'];
    final String prompt = args['prompt'];

    try {
      // Simulate AI inference with model-specific responses
      // Replace this with actual llama_cpp_dart implementation when available

      final modelResponses = {
        'Llama 3 8B': [
          'Hello! I\'m Llama 3 8B,',
          ' a large language model',
          ' designed to assist with',
          ' various tasks.',
          ' How can I help you today?',
        ],
        'Phi-4 mini': [
          'Greetings from Phi-4 mini.',
          ' I\'m an efficient AI model',
          ' optimized for speed and',
          ' accuracy.',
          ' What would you like to know?',
        ],
        'Gemma4 e2b': [
          'Hi there! Gemma4 e2b here,',
          ' ready to assist with',
          ' your questions and',
          ' creative tasks.',
          ' What\'s on your mind?',
        ],
        'Qwen 3.5 2b': [
          'Hello! I\'m Qwen 3.5 2b,',
          ' a versatile language model',
          ' built for understanding',
          ' and generating human-like text.',
          ' How may I assist you?',
        ],
        'Qwen 3.5 0.8b': [
          'Greetings! Qwen 3.5 0.8b at your service.',
          ' I\'m designed to be helpful',
          ' and informative.',
          ' What can I do for you?',
        ],
        'Phi-3 mini': [
          'Hi! Phi-3 mini here.',
          ' I\'m a compact yet capable',
          ' AI model ready to help.',
          ' What would you like to discuss?',
        ],
      };

      final responses =
          modelResponses[modelName] ??
          [
            'Hello from $modelName.',
            ' This is a simulated response.',
            ' The actual AI inference will be',
            ' implemented once the llama_cpp_dart',
            ' API is properly configured.',
          ];

      // Simulate streaming tokens with delays
      for (int i = 0; i < responses.length; i++) {
        await Future.delayed(Duration(milliseconds: 200));
        try {
          sendPort.send(responses[i]);
        } catch (e) {
          // Isolate might be closed, ignore
          break;
        }
      }

      // Signal end of stream
      try {
        sendPort.send(null);
      } catch (e) {
        // Isolate might be closed, ignore
      }
    } catch (e) {
      try {
        sendPort.send('Error: $e');
        sendPort.send(null);
      } catch (e) {
        // Isolate might be closed, ignore
      }
    }
  }
}
