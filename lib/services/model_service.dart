import 'dart:io';
import 'dart:isolate';
import 'dart:math';
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
  /// Currently simulates AI inference - replace with actual llamadart implementation when available
  static Future<ReceivePort> runInference(Function(dynamic) onToken) async {
    final receivePort = ReceivePort();

    try {
      // Spawn isolate for simulated inference (replace with llamadart when dependency is restored)
      await Isolate.spawn(_simulatedInferenceIsolate, receivePort.sendPort);

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

  static void _simulatedInferenceIsolate(SendPort sendPort) {
    // Simulate AI inference with dummy tokens
    // Replace this with actual llamadart implementation when dependency is restored

    final dummyResponses = [
      "Hello",
      "I am",
      "an AI",
      "assistant",
      "helping",
      "with",
      "your",
      "creative",
      "process.",
      "How",
      "can",
      "I",
      "assist",
      "you",
      "today?"
    ];

    // Simulate streaming tokens with delays
    for (int i = 0; i < dummyResponses.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        try {
          sendPort.send(dummyResponses[i]);
        } catch (e) {
          // Isolate might be closed, ignore
        }
      });
    }

    // Close after all tokens are sent
    Future.delayed(Duration(milliseconds: dummyResponses.length * 200 + 500), () {
      try {
        sendPort.send(null); // Signal end of stream
      } catch (e) {
        // Isolate might be closed, ignore
      }
    });
  }
}
