import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class OtlCard extends StatelessWidget {
  const OtlCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.selected = false,
    this.accented = false,
    this.accentColor,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool selected;
  final bool accented;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final highlight = accentColor ?? AppColors.primaryMain;
    final highlighted = selected || accented;

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppCurves.defaultCurve,
      padding: padding,
      decoration: BoxDecoration(
        color: highlighted
            ? Color.alphaBlend(
                AppColors.overlayGlow,
                AppColors.backgroundSecondary,
              )
            : AppColors.backgroundSecondary,
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: highlighted ? highlight : AppColors.borderDefault,
          width: highlighted ? 2 : 1,
        ),
        boxShadow: highlighted ? AppShadows.glow : AppShadows.sm,
      ),
      child: child,
    );
  }
}
