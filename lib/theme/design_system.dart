import 'package:flutter/material.dart';

class EtherealColors {
  static const Color surface = Color(0xFFF9F9FE);
  static const Color primary = Color(0xFF0084FF); // Sky blue but visible
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF339CFF);
  static const Color onSurface = Color(0xFF1A1C1F);
  static const Color onSurfaceVariant = Color(0xFF414755);
  static const Color error = Color(0xFFBA1A1A);
  
  static const Color glassBase = Colors.white; // Used with opacities
  static const Color statusActive = Color(0xFF34C759); // Mint green glow
  static const Color statusInactive = Color(0xFFFF3B30); // Rose red glow
}

class EtherealRadii {
  static const double sm = 8.0;
  static const double defaultRadius = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;
  static const double full = 9999.0;
}

class EtherealSpacing {
  static const double unit = 8.0;
  static const double marginPage = 24.0;
  static const double gutter = 16.0;
  static const double containerPadding = 20.0;
}

class EtherealText {
  static const String fontFamily = 'Inter';

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily, fontSize: 32, fontWeight: FontWeight.w700, height: 1.18, letterSpacing: -0.64, color: EtherealColors.onSurface,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w600, height: 1.25, letterSpacing: -0.24, color: EtherealColors.onSurface,
  );
  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w400, height: 1.44, color: EtherealColors.onSurfaceVariant,
  );
  static const TextStyle bodyMd = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, color: EtherealColors.onSurfaceVariant,
  );
  static const TextStyle labelMd = TextStyle(
    fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500, height: 1.42, letterSpacing: 0.14, color: EtherealColors.onSurfaceVariant,
  );
}
