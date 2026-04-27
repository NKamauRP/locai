import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';

class ProfileSupportPage extends StatelessWidget {
  const ProfileSupportPage({super.key});

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
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, size: 50, color: Colors.black87),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: EtherealColors.primary, shape: BoxShape.circle),
                              child: const Icon(Icons.edit, size: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text("AI Researcher", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text("Local Instance Active", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.badge, color: EtherealColors.primary, size: 20),
                            const SizedBox(width: 8),
                            const Text("Account Identity", style: EtherealText.h2),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInputLabel("Full Name"),
                        const SizedBox(height: 4),
                        _buildInputField("Alexander Vance"),
                        const SizedBox(height: 16),
                        _buildInputLabel("Username"),
                        const SizedBox(height: 4),
                        _buildInputField("@lex_vance_ai"),
                        const SizedBox(height: 16),
                        _buildInputLabel("Email Address"),
                        const SizedBox(height: 4),
                        _buildInputField("alexander.vance@localai.internal"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.forum, color: EtherealColors.primary, size: 20),
                            const SizedBox(width: 8),
                            const Text("Support & Feedback", style: EtherealText.h2),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInputLabel("Comments or Error Messages"),
                        const SizedBox(height: 4),
                        Container(
                          height: 100,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(EtherealRadii.lg),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                          ),
                          child: const TextField(
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: "Tell us about your experience or report an issue...",
                              hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: EtherealColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EtherealRadii.full)),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.send, size: 16),
                                    SizedBox(width: 8),
                                    Text("Send", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black87,
                                  side: BorderSide(color: Colors.grey.shade300),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EtherealRadii.full)),
                                ),
                                child: const Text("Clear"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GlassCard(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.security, color: EtherealColors.primary, size: 20),
                              const SizedBox(width: 8),
                              const Text("Security", style: EtherealText.bodyMd),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GlassCard(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.system_update_alt, color: EtherealColors.primary, size: 20),
                              const SizedBox(width: 8),
                              const Text("Updates", style: EtherealText.bodyMd),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildInputLabel(String text) {
    return Text(text, style: EtherealText.labelMd.copyWith(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold));
  }

  Widget _buildInputField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(EtherealRadii.sm),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Text(hint, style: EtherealText.bodyMd),
    );
  }
}
