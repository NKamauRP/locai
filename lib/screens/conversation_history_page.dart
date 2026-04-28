import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';

class ConversationHistoryPage extends StatelessWidget {
  const ConversationHistoryPage({super.key});

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
              IconButton(icon: const Icon(Icons.settings_outlined, size: 22), onPressed: () {}),
              const CircleAvatar(
                radius: 14,
                backgroundColor: EtherealColors.primaryContainer,
                child: Icon(Icons.person, size: 18, color: EtherealColors.primary),
              ),
              const SizedBox(width: 8),
            ],
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: EtherealColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.history_toggle_off, color: EtherealColors.primary, size: 48),
                  ),
                  const SizedBox(height: 24),
                  const Text("No History Found", style: EtherealText.h2),
                  const SizedBox(height: 8),
                  Text(
                    "Your conversations are ephemeral and\nnot stored by default.",
                    textAlign: TextAlign.center,
                    style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
