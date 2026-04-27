import 'package:flutter/material.dart';
import '../theme/design_system.dart';
import '../widgets/mesh_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/glass_card.dart';

class SecuritySettingsPage extends StatelessWidget {
  const SecuritySettingsPage({super.key});

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: EtherealColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(EtherealRadii.full)),
                  child: const Text("Secure", style: TextStyle(color: EtherealColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
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
                  const Text("Security Settings", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: EtherealColors.onSurface)),
                  const SizedBox(height: 8),
                  Text("Protect your local instance with advanced encryption and access controls.", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant, height: 1.5)),
                  const SizedBox(height: 24),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.verified_user, color: EtherealColors.primary),
                            Row(
                              children: [
                                const Icon(Icons.circle, size: 8, color: EtherealColors.statusActive),
                                const SizedBox(width: 4),
                                Text("ACTIVE", style: EtherealText.labelMd.copyWith(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 10)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text("Local Vault", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text("Encrypted with AES-256", style: EtherealText.bodyMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(EtherealRadii.xl),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey.shade300, Colors.grey.shade200],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.shield, color: EtherealColors.primary, size: 16),
                        const Spacer(),
                        const Text("Privacy Score", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            value: 0.85,
                            backgroundColor: Colors.black12,
                            valueColor: AlwaysStoppedAnimation<Color>(EtherealColors.primary),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text("ACCESS METHODS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: EtherealColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(EtherealRadii.sm)),
                              child: const Icon(Icons.password, color: EtherealColors.primary),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Master Password", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text("Last changed 2 months ago", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: EtherealColors.primary, foregroundColor: Colors.white, elevation: 0),
                              child: const Text("Change"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text("NEW PASSWORD", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("••••••••••••", style: TextStyle(fontSize: 18, color: Colors.black54, letterSpacing: 4)),
                            Icon(Icons.visibility_off, color: Colors.grey.shade500),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: EtherealColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(EtherealRadii.sm)),
                          child: const Icon(Icons.pin, color: EtherealColors.primary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Quick Access PIN", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Used for local unlocks", style: EtherealText.labelMd.copyWith(color: EtherealColors.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        const Text("Set", style: TextStyle(color: Colors.black54)),
                        const SizedBox(width: 8),
                        Switch(value: true, onChanged: (v) {}, activeColor: EtherealColors.primary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text("ADVANCED", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      children: [
                        _buildAdvancedRow(Icons.phonelink_lock, "Two-Factor Authentication", Icons.chevron_right),
                        const SizedBox(height: 24),
                        _buildAdvancedRow(Icons.fingerprint, "Biometric Unlock", Icons.chevron_right),
                        const SizedBox(height: 24),
                        _buildAdvancedRow(Icons.auto_delete, "Auto-Wipe Data", null, tag: "OFF", tagColor: Colors.red),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: Colors.blueGrey),
                      label: const Text("Sign out of all sessions", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
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

  Widget _buildAdvancedRow(IconData icon, String title, IconData? trailing, {String? tag, Color? tagColor}) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey),
        const SizedBox(width: 16),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
        if (trailing != null) Icon(trailing, color: Colors.grey.shade400),
        if (tag != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(color: tagColor ?? Colors.grey.shade300)),
            child: Text(tag, style: TextStyle(color: tagColor ?? Colors.black54, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}
