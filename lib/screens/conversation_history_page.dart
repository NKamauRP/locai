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
            child: ListView(
              padding: const EdgeInsets.only(left: EtherealSpacing.marginPage, right: EtherealSpacing.marginPage, bottom: 110),
              children: [
                const SizedBox(height: 16),
                const Text("Conversation History", style: EtherealText.h1),
                const SizedBox(height: 8),
                Text("Review and manage your previous interactions with Lumina.", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                const SizedBox(height: 24),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ACTIVE SESSION", style: EtherealText.labelMd.copyWith(color: EtherealColors.primary, fontWeight: FontWeight.bold)),
                          Text("2 mins ago", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text("Quantum Computing\nPrinciples", style: EtherealText.h2),
                      const SizedBox(height: 8),
                      Text("\"Can you explain the difference between a qubit and a classical bit in terms of...\"", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: EtherealColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(EtherealRadii.full)),
                            child: const Row(
                              children: [
                                Icon(Icons.auto_awesome, size: 12, color: EtherealColors.primary),
                                SizedBox(width: 4),
                                Icon(Icons.hub, size: 12, color: EtherealColors.primary),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text("Model: Lumina Ultra 4.0", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurface)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _HistoryListItem(icon: Icons.palette_outlined, title: "Design System Guidelines", preview: "Refining the ethereal glassmorphism...", time: "YESTERDAY"),
                const SizedBox(height: 16),
                _HistoryListItem(icon: Icons.code, title: "React Tailwind Config", preview: "Optimization strategies for large grids...", time: "OCT 24", isOrange: true),
                const SizedBox(height: 16),
                _HistoryListItem(icon: Icons.edit_note, title: "Marketing Copy Drafts", preview: "Campaign slogans for Lumina launch...", time: "OCT 22"),
                const SizedBox(height: 16),
                _HistoryListItem(icon: Icons.search, title: "Research: Space Exploration", preview: "Data points for Mars colonization...", time: "OCT 20", isGray: true),
                const SizedBox(height: 24),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(EtherealRadii.xl),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [const Color(0xFF1E3A5F), const Color(0xFF0F1C2E)],
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Activity Insights", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("You had 42 conversations this week.", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
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

class _HistoryListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String preview;
  final String time;
  final bool isOrange;
  final bool isGray;

  const _HistoryListItem({required this.icon, required this.title, required this.preview, required this.time, this.isOrange = false, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    Color bgColor = EtherealColors.primary.withOpacity(0.1);
    Color iconColor = EtherealColors.primary;
    if (isOrange) {
      bgColor = Colors.deepOrange.withOpacity(0.1);
      iconColor = Colors.deepOrange;
    } else if (isGray) {
      bgColor = Colors.grey.withOpacity(0.2);
      iconColor = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(EtherealRadii.full),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: EtherealText.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                    Text(time, style: EtherealText.labelMd.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(preview, style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
