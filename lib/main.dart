import 'dart:ui';
import 'package:flutter/material.dart';
import 'screens/chat_page.dart';
import 'screens/conversation_history_page.dart';
import 'screens/model_gallery_page.dart';
import 'screens/about_data_page.dart';
import 'screens/profile_support_page.dart';
import 'screens/software_requirements_page.dart';
import 'screens/security_settings_page.dart';
import 'theme/design_system.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: EtherealText.fontFamily,
        scaffoldBackgroundColor: EtherealColors.surface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: EtherealColors.primary,
          primary: EtherealColors.primary,
          surface: EtherealColors.surface,
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ChatPage(),
    const ConversationHistoryPage(),
    const ModelGalleryPage(),
    const AboutDataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Required for floating bottom nav to overlap body
      drawer: Drawer(
        backgroundColor: EtherealColors.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: EtherealColors.primary,
              ),
              child: Text('Lumina AI', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile & Support'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileSupportPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.memory),
              title: const Text('Software Requirements'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SoftwareRequirementsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Security & Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SecuritySettingsPage()));
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(EtherealSpacing.marginPage),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(EtherealRadii.xl),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: EtherealColors.glassBase.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(EtherealRadii.xl),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: EtherealColors.primary,
                  unselectedItemColor: EtherealColors.onSurfaceVariant,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
                    BottomNavigationBarItem(icon: Icon(Icons.history), activeIcon: Icon(Icons.history_toggle_off), label: 'History'),
                    BottomNavigationBarItem(icon: Icon(Icons.hub_outlined), activeIcon: Icon(Icons.hub), label: 'Models'),
                    BottomNavigationBarItem(icon: Icon(Icons.info_outline), activeIcon: Icon(Icons.info), label: 'About'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
