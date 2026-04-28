import 'dart:ui';
import 'dart:isolate';
import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../services/model_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? _selectedModel;
  final List<String> _availableModels = [];
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  ReceivePort? _inferencePort;
  bool _isGenerating = false;
  String _currentResponse = '';

  @override
  void initState() {
    super.initState();
    _loadAvailableModels();
  }

  @override
  void dispose() {
    _textController.dispose();
    _inferencePort?.close();
    super.dispose();
  }

  Future<void> _loadAvailableModels() async {
    final models = [
      "Llama 3 8B",
      "Phi-4 mini",
      "Gemma4 e2b",
      "Qwen 3.5 2b",
      "Qwen 3.5 0.8b",
      "Phi-3 mini",
    ];
    for (var name in models) {
      if (await ModelService.isModelDownloaded("$name.gguf")) {
        _availableModels.add(name);
      }
    }
    if (_availableModels.isNotEmpty) {
      _selectedModel = _availableModels.first;
    }
    if (mounted) setState(() {});
  }

  void _handleModelChange(String? newModel) {
    if (newModel == _selectedModel) return;
    setState(() {
      _selectedModel = newModel;
      _messages.clear(); // Switch to a new chat
    });
  }

  void _handleSend() async {
    if (_textController.text.trim().isEmpty ||
        _selectedModel == null ||
        _isGenerating)
      return;

    final userMessage = _textController.text.trim();
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
      _textController.clear();
      _isGenerating = true;
      _currentResponse = '';
      _messages.add(
        ChatMessage(text: '', isUser: false),
      ); // Placeholder for AI response
    });

    try {
      // Start inference with the selected model
      _inferencePort = await ModelService.runInference(
        _selectedModel!,
        userMessage,
        _onInferenceToken,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          // Replace placeholder with error message
          _messages.last = ChatMessage(
            text: 'Error: Failed to start inference. $e',
            isUser: false,
          );
        });
      }
    }
  }

  void _onInferenceToken(dynamic token) {
    if (!mounted) return;

    if (token == null) {
      // Inference completed
      setState(() {
        _isGenerating = false;
      });
      _inferencePort?.close();
      _inferencePort = null;
    } else if (token is String) {
      if (token.startsWith('Error:')) {
        // Handle error
        setState(() {
          _isGenerating = false;
          _messages.last = ChatMessage(text: token, isUser: false);
        });
        _inferencePort?.close();
        _inferencePort = null;
      } else {
        // Append token to current response
        setState(() {
          _currentResponse += token;
          _messages.last = ChatMessage(text: _currentResponse, isUser: false);
        });
      }
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
              if (_availableModels.isNotEmpty)
                DropdownButton<String>(
                  value: _selectedModel,
                  items: _availableModels.map((model) {
                    return DropdownMenuItem(
                      value: model,
                      child: Text(
                        model,
                        style: EtherealText.labelMd.copyWith(
                          color: EtherealColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: _handleModelChange,
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: EtherealColors.primary,
                    size: 18,
                  ),
                  dropdownColor: Colors.white.withOpacity(0.9),
                ),
              const SizedBox(width: 8),
            ],
          ),
          Expanded(
            child: _messages.isEmpty
                ? const _WelcomeMessage()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: EtherealSpacing.marginPage,
                      vertical: 24,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return ChatMessageBubble(
                        isUser: msg.isUser,
                        text: msg.text,
                      );
                    },
                  ),
          ),
          _ChatInputField(
            controller: _textController,
            onSend: _handleSend,
            isGenerating: _isGenerating,
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              "AI generated content may contain errors. Verify information\nfrom a professional.",
              textAlign: TextAlign.center,
              style: EtherealText.labelMd.copyWith(
                color: EtherealColors.onSurfaceVariant.withOpacity(0.6),
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(EtherealRadii.xl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(EtherealRadii.xl),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: EtherealColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: EtherealColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Good morning, Lumina User",
                  style: EtherealText.bodyMd,
                ),
                const SizedBox(height: 8),
                Text(
                  "How can I assist your creative process\ntoday?",
                  textAlign: TextAlign.center,
                  style: EtherealText.bodyMd.copyWith(
                    color: EtherealColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isGenerating;

  const _ChatInputField({
    required this.controller,
    required this.onSend,
    required this.isGenerating,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: EtherealSpacing.marginPage,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(EtherealRadii.xl),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(EtherealRadii.xl),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: EtherealColors.onSurfaceVariant.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        color: EtherealColors.onSurfaceVariant.withOpacity(0.8),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: 4,
                      minLines: 1,
                      style: EtherealText.bodyMd,
                      decoration: InputDecoration(
                        hintText: "Ask anything or attach an image...",
                        hintStyle: EtherealText.bodyMd.copyWith(
                          color: EtherealColors.onSurfaceVariant.withOpacity(
                            0.6,
                          ),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: EtherealColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: EtherealColors.primaryContainer,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: isGenerating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                        onPressed: isGenerating ? null : onSend,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final bool isUser;
  final String? text;
  final Widget? attachment;

  const ChatMessageBubble({
    super.key,
    required this.isUser,
    this.text,
    this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        margin: const EdgeInsets.only(bottom: 24),
        child: isUser ? _buildUserBubble(context) : _buildAiBubble(context),
      ),
    );
  }

  Widget _buildUserBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: EtherealColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(EtherealRadii.xl),
          topRight: Radius.circular(EtherealRadii.xl),
          bottomLeft: Radius.circular(EtherealRadii.xl),
          bottomRight: Radius.circular(EtherealRadii.sm),
        ),
      ),
      child: Text(
        text ?? "",
        style: EtherealText.bodyMd.copyWith(color: Colors.white, height: 1.5),
      ),
    );
  }

  Widget _buildAiBubble(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(EtherealRadii.xl),
        topRight: Radius.circular(EtherealRadii.xl),
        bottomRight: Radius.circular(EtherealRadii.xl),
        bottomLeft: Radius.circular(EtherealRadii.sm),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
          ),
          child: Text(
            text ?? "",
            style: EtherealText.bodyMd.copyWith(height: 1.5),
          ),
        ),
      ),
    );
  }
}
