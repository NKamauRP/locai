import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';

class AboutDataPage extends StatelessWidget {
  const AboutDataPage({super.key});

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
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: EtherealSpacing.marginPage, right: EtherealSpacing.marginPage, bottom: 110),
              children: [
                const SizedBox(height: 16),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("About Lumina", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: EtherealColors.onSurface)),
                      const SizedBox(height: 8),
                      Text("Version 4.2.0 • Quantum Flux Architecture", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: Stack(
                              children: [
                                const Positioned(left: 0, child: CircleAvatar(radius: 15, backgroundColor: Colors.teal)),
                                const Positioned(left: 15, child: CircleAvatar(radius: 15, backgroundColor: Colors.black87)),
                                Positioned(left: 30, child: CircleAvatar(radius: 15, backgroundColor: Colors.blue.shade100)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text("Built by Neural Synthesis Team", style: EtherealText.bodyMd.copyWith(color: EtherealColors.primary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(EtherealRadii.full),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Privacy Policy", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text("Last updated Oct 2023", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                        ],
                      ),
                      const Icon(Icons.chevron_right, color: EtherealColors.primary, size: 28),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.storage, color: EtherealColors.primary, size: 28),
                            const SizedBox(height: 24),
                            const Text("Data Export", style: EtherealText.bodyMd),
                            const SizedBox(height: 4),
                            Text("Download .json", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(EtherealRadii.xl),
                          border: Border.all(color: Colors.red.shade100, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.delete_sweep, color: Colors.red.shade700, size: 28),
                            const SizedBox(height: 24),
                            Text("Clear Cache", style: EtherealText.bodyMd.copyWith(color: Colors.red.shade700)),
                            const SizedBox(height: 4),
                            Text("1.2 GB stored", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GlassCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: EtherealColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                                child: const Icon(Icons.insert_chart, color: EtherealColors.primary, size: 20),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Usage Diagnostics", style: EtherealText.bodyMd),
                                  Text("Share anonymous data", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                                ],
                              ),
                            ],
                          ),
                          Switch(value: true, onChanged: (v) {}, activeColor: EtherealColors.primary),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.deepOrange.withOpacity(0.1), shape: BoxShape.circle),
                                child: const Icon(Icons.sync, color: Colors.deepOrange, size: 20),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Cloud Sync", style: EtherealText.bodyMd),
                                  Text("Encrypted backup", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                                ],
                              ),
                            ],
                          ),
                          Switch(value: false, onChanged: (v) {}),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    "Build: LMN-2024-X9\n\nLumina AI is an experimental interface\nexploring the boundaries of ethereal UI\ndesign and fluid interactivity.",
                    textAlign: TextAlign.center,
                    style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant, height: 1.5),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
