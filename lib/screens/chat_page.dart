import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
                child: Icon(Icons.person, size: 18, color: EtherealColors.primary),
              ),
              const SizedBox(width: 8),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: EtherealSpacing.marginPage),
              children: [
                const SizedBox(height: 24),
                const _WelcomeMessage(),
                const SizedBox(height: 24),
                const _AiMessage(
                  text: "I've analyzed your request for the \"Ethereal Glass\" design system. The core concept revolves around optical density and light refraction rather than traditional shadows. Should we explore the color palette or the component library first?",
                ),
                const SizedBox(height: 24),
                const _UserMessage(
                  text: "Let's start with the component library. I want to see how a \"Glass Card\" looks with a nested image and a status indicator.",
                ),
                const SizedBox(height: 24),
                const _AiImageMessage(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "LUMINA AI • 10:26 AM",
                    style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant.withOpacity(0.6), fontSize: 10),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    "AI generated content may contain errors. Verify information\nfrom a professional.",
                    textAlign: TextAlign.center,
                    style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant.withOpacity(0.6), fontSize: 10),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const _ChatInputField(),
        ],
      ),
    );
  }
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
              border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
              borderRadius: BorderRadius.circular(EtherealRadii.xl),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: EtherealColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.auto_awesome, color: EtherealColors.primary),
                ),
                const SizedBox(height: 16),
                const Text("Good morning, Lumina User", style: EtherealText.bodyMd),
                const SizedBox(height: 8),
                Text(
                  "How can I assist your creative process\ntoday?",
                  textAlign: TextAlign.center,
                  style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AiMessage extends StatelessWidget {
  final String text;
  const _AiMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(EtherealRadii.xl),
          topRight: Radius.circular(EtherealRadii.xl),
          bottomRight: Radius.circular(EtherealRadii.xl),
          bottomLeft: Radius.circular(EtherealRadii.sm),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(EtherealRadii.xl),
                topRight: Radius.circular(EtherealRadii.xl),
                bottomRight: Radius.circular(EtherealRadii.xl),
                bottomLeft: Radius.circular(EtherealRadii.sm),
              ),
            ),
            child: Text(text, style: EtherealText.bodyMd.copyWith(height: 1.5)),
          ),
        ),
      ),
    );
  }
}

class _AiImageMessage extends StatelessWidget {
  const _AiImageMessage();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(EtherealRadii.xl),
          topRight: Radius.circular(EtherealRadii.xl),
          bottomRight: Radius.circular(EtherealRadii.xl),
          bottomLeft: Radius.circular(EtherealRadii.sm),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              border: Border.all(color: EtherealColors.primary.withOpacity(0.5), width: 1), // Blue border
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(EtherealRadii.xl),
                topRight: Radius.circular(EtherealRadii.xl),
                bottomRight: Radius.circular(EtherealRadii.xl),
                bottomLeft: Radius.circular(EtherealRadii.sm),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Absolutely. Here is a conceptual render of a Glass Card element. Notice the inner white border that catches light and the ambient glow.", style: EtherealText.bodyMd.copyWith(height: 1.5)),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(EtherealRadii.md),
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade300, Colors.grey.shade100],
                        ),
                      ),
                      // Placeholder for image
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(EtherealRadii.full),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: EtherealColors.statusActive, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            Text("ACTIVE STATE", style: EtherealText.labelMd.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text("This uses a 20px blur with 40% opacity. Does this align with your vision for the serenity aesthetic?", style: EtherealText.bodyMd.copyWith(height: 1.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserMessage extends StatelessWidget {
  final String text;
  const _UserMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: EtherealColors.primary,
          boxShadow: [
            BoxShadow(
              color: EtherealColors.primaryContainer,
              blurRadius: 15,
              spreadRadius: -2,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(EtherealRadii.xl),
            topRight: Radius.circular(EtherealRadii.xl),
            bottomLeft: Radius.circular(EtherealRadii.xl),
            bottomRight: Radius.circular(EtherealRadii.sm),
          ),
        ),
        child: Text(text, style: EtherealText.bodyMd.copyWith(color: EtherealColors.onPrimary, height: 1.5)),
      ),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  const _ChatInputField();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: EtherealSpacing.marginPage, right: EtherealSpacing.marginPage, bottom: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(EtherealRadii.full),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(EtherealRadii.full),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: EtherealColors.onSurfaceVariant.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: EtherealColors.onSurfaceVariant.withOpacity(0.8), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      style: EtherealText.bodyMd,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant.withOpacity(0.6)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
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
                      icon: const Icon(Icons.send_rounded, color: EtherealColors.onPrimary, size: 20),
                      onPressed: () {},
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
