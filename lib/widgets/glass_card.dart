import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/design_system.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double padding;
  final double radius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = EtherealSpacing.containerPadding,
    this.radius = EtherealRadii.lg,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: EtherealColors.glassBase.withOpacity(0.4),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
