import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/design_system.dart';

class FloatingNavBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const FloatingNavBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: EtherealSpacing.marginPage,
          vertical: EtherealSpacing.unit * 2,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(EtherealRadii.xl),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: EtherealColors.glassBase.withOpacity(0.6),
                borderRadius: BorderRadius.circular(EtherealRadii.xl),
              ),
              child: Row(
                children: [
                  if (leading != null) leading!,
                  if (leading == null) const SizedBox(width: 48), // balance
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: EtherealText.bodyLg.copyWith(
                        fontWeight: FontWeight.w600,
                        color: EtherealColors.onSurface,
                      ),
                    ),
                  ),
                  if (actions != null)
                    Row(children: actions!)
                  else
                    const SizedBox(width: 48), // balance
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
