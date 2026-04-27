import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';

class SoftwareRequirementsPage extends StatelessWidget {
  const SoftwareRequirementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: MeshBackground(
        child: Column(
          children: [
            FloatingNavBar(
              title: 'Lumina AI',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => Navigator.pop(context),
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
                  const SizedBox(height: 16),
                  const Text("Software Needs", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: EtherealColors.onSurface)),
                  const SizedBox(height: 8),
                  Text("Configure your local environment by matching model capabilities with your hardware potential.", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant, height: 1.5)),
                  const SizedBox(height: 24),
                  _buildRequirementCard(
                    context: context,
                    icon: Icons.bolt,
                    title: "Small",
                    tag: "EFFICIENCY",
                    description: "Ideal for mobile devices and lightweight tasks like text summarization.",
                    ram: "4GB - 8GB",
                    storage: "~3.5 GB",
                    model: "Llama-3-3B",
                  ),
                  const SizedBox(height: 16),
                  _buildRequirementCard(
                    context: context,
                    icon: Icons.auto_awesome,
                    title: "Medium",
                    tag: "RECOMMENDED",
                    description: "The sweet spot for coding assistants and complex logical reasoning.",
                    ram: "16GB - 32GB",
                    storage: "~12 GB",
                    model: "Mistral-7B-v0.3",
                    isRecommended: true,
                  ),
                  const SizedBox(height: 16),
                  _buildRequirementCard(
                    context: context,
                    icon: Icons.layers,
                    title: "Large",
                    tag: "ENTERPRISE",
                    tagColor: Colors.deepOrange,
                    description: "Maximum creative output and multi-lingual expertise. Requires GPU.",
                    ram: "64GB+ (VRAM)",
                    storage: "40GB+",
                    model: "Llama-3-70B",
                    modelColor: Colors.deepOrange,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 140,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(EtherealRadii.xl),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey.shade400, Colors.grey.shade300],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Inference Speed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(height: 4),
                        Text("Local execution speed depends on your tokens-per-second (t/s) capability, largely determined by memory bandwidth.", style: TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.8), height: 1.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.memory, color: Colors.indigo),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("NPU Acceleration", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text("Supported on Apple M-series and modern Snapdragon chips.", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.shield, color: Colors.blueGrey),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Privacy First", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text("No data leaves your local RAM during inference cycles.", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String tag,
    required String description,
    required String ram,
    required String storage,
    required String model,
    bool isRecommended = false,
    Color tagColor = EtherealColors.primary,
    Color modelColor = EtherealColors.primary,
  }) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isRecommended ? EtherealColors.primary : tagColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: isRecommended ? Colors.white : tagColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(EtherealRadii.full),
                ),
                child: Row(
                  children: [
                    if (isRecommended) ...[
                      Icon(Icons.circle, size: 6, color: tagColor),
                      const SizedBox(width: 4),
                    ],
                    Text(tag, style: EtherealText.labelMd.copyWith(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(description, style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant, height: 1.5)),
          const SizedBox(height: 16),
          const Divider(color: Colors.black12),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("RAM", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
              Text(ram, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Storage", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
              Text(storage, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Model", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
              Text(model, style: TextStyle(fontWeight: FontWeight.bold, color: modelColor)),
            ],
          ),
          if (isRecommended) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: EtherealColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EtherealRadii.full)),
                ),
                child: const Text("Deploy Instance", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
