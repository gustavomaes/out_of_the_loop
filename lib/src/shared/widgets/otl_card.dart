import 'package:flutter/material.dart';

import '../../theme/app_tokens.dart';

class OtlCard extends StatelessWidget {
  const OtlCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.selected = false,
    this.accentColor,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool selected;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final highlight = accentColor ?? AppColors.primaryMain;

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppCurves.defaultCurve,
      padding: padding,
      decoration: BoxDecoration(
        color: selected ? AppColors.overlayGlow : AppColors.backgroundSecondary,
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: selected ? highlight : AppColors.borderDefault,
        ),
        boxShadow: selected ? AppShadows.glow : AppShadows.sm,
      ),
      child: child,
    );
  }
}
