import 'dart:isolate';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';
import '../services/permission_manager.dart';
import '../services/model_service.dart';

class ModelGalleryPage extends StatefulWidget {
  const ModelGalleryPage({super.key});

  @override
  State<ModelGalleryPage> createState() => _ModelGalleryPageState();
}

class _ModelGalleryPageState extends State<ModelGalleryPage> {
  final ReceivePort _port = ReceivePort();
  Map<String, bool> _downloadedModels = {};

  @override
  void initState() {
    super.initState();
    _checkDownloadedModels();

    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      // int progress = data[2];

      if (status == 3) {
        // Complete
        _checkDownloadedModels();
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> _checkDownloadedModels() async {
    final models = [
      "Llama 3 8B",
      "Phi-4 mini",
      "Gemma4 e2b",
      "Qwen 3.5 2b",
      "Qwen 3.5 0.8b",
      "Phi-3 mini",
    ];
    for (var name in models) {
      _downloadedModels[name] = await ModelService.isModelDownloaded(
        "$name.gguf",
      );
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _port.close();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName(
      'downloader_send_port',
    );
    send?.send([id, status, progress]);
  }

  Future<void> _startDownload(String name, String url) async {
    if (_downloadedModels[name] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$name is already downloaded")));
      return;
    }

    // Request comprehensive storage permissions
    final hasPermission = await PermissionManager.requestStoragePermission();

    if (!hasPermission) {
      // Try to open settings if permission was permanently denied
      final openedSettings = await PermissionManager.openSettingsIfNeeded();

      if (!openedSettings) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Storage permission is required to download models. Please enable it in app settings.",
              ),
              duration: Duration(seconds: 5),
            ),
          );
        }
      }
      return;
    }

    final savedDir = await ModelService.localPath;

    await FlutterDownloader.enqueue(
      url: url,
      headers: {},
      savedDir: savedDir,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
      fileName: "$name.gguf",
    );
  }

  Future<void> _deleteModel(String name) async {
    await ModelService.deleteModel("$name.gguf");
    await _checkDownloadedModels();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$name deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MeshBackground(
      child: Column(
        children: [
          FloatingNavBar(
            title: 'Lumina AI',
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, size: 24),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: EtherealColors.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 18,
                  color: EtherealColors.primary,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(
                left: EtherealSpacing.marginPage,
                right: EtherealSpacing.marginPage,
                bottom: 110,
              ),
              children: [
                const SizedBox(height: 16),
                const Text("Model Gallery", style: EtherealText.h1),
                const SizedBox(height: 8),
                Text(
                  "Manage your local intelligence. Seamlessly download and toggle optimized AI models.",
                  style: EtherealText.bodyMd.copyWith(
                    color: EtherealColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LOCAL STORAGE",
                          style: EtherealText.labelMd.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "71%",
                          style: EtherealText.labelMd.copyWith(
                            color: EtherealColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.71,
                        backgroundColor: Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          EtherealColors.primary,
                        ),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "14.2 GB used of 20 GB",
                      style: EtherealText.labelMd.copyWith(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _ModelCard(
                  name: "Llama 3 8B Chat Instruct",
                  description:
                      "Foundation model optimized for conversational depth.",
                  tag: "Chat",
                  size: "4.5 GB",
                  isActive: _downloadedModels["Llama 3 8B"] ?? false,
                  hasDownload: !(_downloadedModels["Llama 3 8B"] ?? false),
                  hasDelete: _downloadedModels["Llama 3 8B"] ?? false,
                  onDownload: () => _startDownload(
                    "Llama 3 8B",
                    "https://huggingface.co/Qwen/Qwen2-Coder-1.5-8B-Instruct-GGUF/resolve/main/qwen2-coder-1.5-8b-instruct-q6_k.gguf",
                  ),
                  onDelete: () => _deleteModel("Llama 3 8B"),
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Phi-4 mini reasoning Q6",
                  description:
                      "Lightweight model designed for advanced reasoning tasks.",
                  tag: "Reasoning",
                  size: "2.1 GB",
                  isActive: _downloadedModels["Phi-4 mini"] ?? false,
                  hasDownload: !(_downloadedModels["Phi-4 mini"] ?? false),
                  hasDelete: _downloadedModels["Phi-4 mini"] ?? false,
                  onDownload: () => _startDownload(
                    "Phi-4 mini",
                    "https://huggingface.co/lmstudio-community/Phi-4-mini-reasoning-GGUF/resolve/main/Phi-4-mini-reasoning-Q6_K.gguf",
                  ),
                  onDelete: () => _deleteModel("Phi-4 mini"),
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Gemma4 e2b Q6k",
                  description: "Multimodal capability with high efficiency.",
                  tag: "Multimodal",
                  size: "3.8 GB",
                  isActive: _downloadedModels["Gemma4 e2b"] ?? false,
                  hasDownload: !(_downloadedModels["Gemma4 e2b"] ?? false),
                  hasDelete: _downloadedModels["Gemma4 e2b"] ?? false,
                  hasSettings: true,
                  onDownload: () => _startDownload(
                    "Gemma4 e2b",
                    "https://huggingface.co/lmstudio-community/gemma-4-E2B-it-GGUF/resolve/main/gemma-4-E2B-it-Q6_K.gguf",
                  ),
                  onDelete: () => _deleteModel("Gemma4 e2b"),
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Qwen 3.5 2b Q6_K",
                  description:
                      "Optimized for complex logic and mathematical solving.",
                  tag: "Logic Expert",
                  size: "2.0 GB",
                  isActive: _downloadedModels["Qwen 3.5 2b"] ?? false,
                  hasDownload: !(_downloadedModels["Qwen 3.5 2b"] ?? false),
                  hasDelete: _downloadedModels["Qwen 3.5 2b"] ?? false,
                  onDownload: () => _startDownload(
                    "Qwen 3.5 2b",
                    "https://huggingface.co/lmstudio-community/Qwen3.5-2B-GGUF/resolve/main/Qwen3.5-2B-Q6_K.gguf",
                  ),
                  onDelete: () => _deleteModel("Qwen 3.5 2b"),
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Qwen 3.5 0.8b Q6_K",
                  description: "Ultra-efficient model for edge devices.",
                  tag: "Efficiency",
                  size: "0.8 GB",
                  isActive: _downloadedModels["Qwen 3.5 0.8b"] ?? false,
                  hasDownload: !(_downloadedModels["Qwen 3.5 0.8b"] ?? false),
                  hasDelete: _downloadedModels["Qwen 3.5 0.8b"] ?? false,
                  onDownload: () => _startDownload(
                    "Qwen 3.5 0.8b",
                    "https://huggingface.co/lmstudio-community/Qwen3.5-0.8B-GGUF/resolve/main/Qwen3.5-0.8B-Q6_K.gguf",
                  ),
                  onDelete: () => _deleteModel("Qwen 3.5 0.8b"),
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "phi-3-mini-4k-instruct-q4",
                  description: "High throughput instruction-tuned model.",
                  tag: "Speed",
                  size: "1.8 GB",
                  isActive: _downloadedModels["Phi-3 mini"] ?? false,
                  hasDownload: !(_downloadedModels["Phi-3 mini"] ?? false),
                  hasDelete: _downloadedModels["Phi-3 mini"] ?? false,
                  onDownload: () => _startDownload(
                    "Phi-3 mini",
                    "https://huggingface.co/lmstudio-community/phi-3-mini-4k-instruct-q4/resolve/main/phi-3-mini-4k-instruct-q4_0.gguf",
                  ),
                  onDelete: () => _deleteModel("Phi-3 mini"),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: EtherealColors.primary,
                    borderRadius: BorderRadius.circular(EtherealRadii.xl),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.cloud_sync,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Auto-Update",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Keep your local models updated with the latest weights automatically.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: EtherealColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              EtherealRadii.full,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Enable Auto-Sync",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  final String name;
  final String description;
  final String tag;
  final String size;
  final bool isActive;
  final bool hasSettings;
  final bool hasDelete;
  final bool hasDownload;
  final bool hasFilter;
  final Color? tagColor;
  final Color? tagTextColor;
  final String? downloadUrl;
  final VoidCallback? onDownload;
  final VoidCallback? onDelete;

  const _ModelCard({
    required this.name,
    required this.description,
    required this.tag,
    required this.size,
    required this.isActive,
    this.hasSettings = false,
    this.hasDelete = false,
    this.hasDownload = false,
    this.hasFilter = false,
    this.tagColor,
    this.tagTextColor,
    this.downloadUrl,
    this.onDownload,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? EtherealColors.statusActive
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isActive ? "Downloaded" : "Available",
                    style: EtherealText.labelMd.copyWith(
                      color: isActive
                          ? EtherealColors.statusActive
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (hasSettings)
                    const Icon(Icons.settings, size: 18, color: Colors.black87),
                  if (hasSettings && hasDelete) const SizedBox(width: 12),
                  if (hasDelete)
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  if (hasFilter)
                    const Icon(Icons.tune, size: 18, color: Colors.black87),
                  if (hasDownload)
                    GestureDetector(
                      onTap: onDownload,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: EtherealColors.primary,
                          borderRadius: BorderRadius.circular(
                            EtherealRadii.full,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.download,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Download",
                              style: EtherealText.labelMd.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(name, style: EtherealText.h2),
          const SizedBox(height: 4),
          Text(
            description,
            style: EtherealText.bodyMd.copyWith(
              color: EtherealColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: tagColor ?? EtherealColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(EtherealRadii.full),
                ),
                child: Text(
                  tag,
                  style: EtherealText.labelMd.copyWith(
                    color: tagTextColor ?? EtherealColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                size,
                style: EtherealText.labelMd.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
