import 'package:flutter/material.dart';

class MeshBackground extends StatelessWidget {
  final Widget child;

  const MeshBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF), // Pure White
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF), // Pure white
            Color(0xFFF8F9FA), // Very soft grey/white
            Color(0xFFF0F4F8), // Softest icy white
            Color(0xFFFFFFFF), // Pure white
          ],
          stops: [0.0, 0.4, 0.8, 1.0],
        ),
      ),
      child: child,
    );
  }
}
