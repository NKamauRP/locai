import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';

class ModelGalleryPage extends StatelessWidget {
  const ModelGalleryPage({super.key});

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
              padding: const EdgeInsets.only(left: EtherealSpacing.marginPage, right: EtherealSpacing.marginPage, bottom: 110),
              children: [
                const SizedBox(height: 16),
                const Text("Model Gallery", style: EtherealText.h1),
                const SizedBox(height: 8),
                Text("Manage your local intelligence. Seamlessly download and toggle optimized AI models.", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("LOCAL STORAGE", style: EtherealText.labelMd.copyWith(fontWeight: FontWeight.bold, fontSize: 10)),
                        Text("71%", style: EtherealText.labelMd.copyWith(color: EtherealColors.primary, fontWeight: FontWeight.bold, fontSize: 10)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.71,
                        backgroundColor: Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(EtherealColors.primary),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("14.2 GB used of 20 GB", style: EtherealText.labelMd.copyWith(fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 24),
                _ModelCard(
                  name: "Gemini 4 e2b",
                  description: "7B Parameters • Multimodal capability with high efficiency.",
                  tag: "Reasoning",
                  size: "3.8 GB",
                  isActive: true,
                  hasSettings: true,
                  hasDelete: true,
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Qwen 2.5",
                  description: "Optimized for complex reasoning and mathematical solving.",
                  tag: "Logic Expert",
                  size: "5.2 GB",
                  isActive: true,
                  hasSettings: true,
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Phi-4",
                  description: "Lightweight model designed for mobile and edge execution.",
                  tag: "Efficiency",
                  size: "2.1 GB",
                  isActive: false,
                  hasDownload: true,
                  tagColor: Colors.grey.shade200,
                  tagTextColor: Colors.black87,
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Llama 3.1",
                  description: "Versatile foundation model for conversational depth.",
                  tag: "Creative",
                  size: "4.5 GB",
                  isActive: true,
                  hasFilter: true,
                  tagColor: Colors.deepOrange.shade50,
                  tagTextColor: Colors.deepOrange,
                ),
                const SizedBox(height: 16),
                _ModelCard(
                  name: "Mistral Nemo",
                  description: "Performance-oriented 12B model for high throughput tasks.",
                  tag: "Speed",
                  size: "8.3 GB",
                  isActive: false,
                  hasDownload: true,
                  tagColor: Colors.grey.shade200,
                  tagTextColor: Colors.black87,
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
                      const Icon(Icons.cloud_sync, color: Colors.white, size: 32),
                      const SizedBox(height: 16),
                      const Text("Auto-Update", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Keep your local models updated with the latest weights automatically.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: EtherealColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EtherealRadii.full)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          elevation: 0,
                        ),
                        child: const Text("Enable Auto-Sync", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? EtherealColors.statusActive : Colors.grey.shade400),
                  ),
                  const SizedBox(width: 8),
                  Text(isActive ? "Active" : "Available", style: EtherealText.labelMd.copyWith(color: isActive ? EtherealColors.statusActive : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
              Row(
                children: [
                  if (hasSettings) const Icon(Icons.settings, size: 18, color: Colors.black87),
                  if (hasSettings && hasDelete) const SizedBox(width: 12),
                  if (hasDelete) const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                  if (hasFilter) const Icon(Icons.tune, size: 18, color: Colors.black87),
                  if (hasDownload)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: EtherealColors.primary, borderRadius: BorderRadius.circular(EtherealRadii.full)),
                      child: Row(
                        children: [
                          const Icon(Icons.download, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text("Download", style: EtherealText.labelMd.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(name, style: EtherealText.h2),
          const SizedBox(height: 4),
          Text(description, style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: tagColor ?? EtherealColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(EtherealRadii.full)),
                child: Text(tag, style: EtherealText.labelMd.copyWith(color: tagTextColor ?? EtherealColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Text(size, style: EtherealText.labelMd.copyWith(color: Colors.grey.shade600, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
