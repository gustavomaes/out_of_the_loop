import 'package:flutter/material.dart';

import '../sound/sound_effects_scope.dart';
import '../../theme/theme.dart';

enum OtlButtonVariant { primary, secondary, outline }

class OtlButton extends StatelessWidget {
  const OtlButton._({
    required this.label,
    required this.onPressed,
    required this.variant,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });

  const OtlButton.primary({
    required String label,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
    bool autofocus = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: OtlButtonVariant.primary,
         focusNode: focusNode,
         autofocus: autofocus,
       );

  const OtlButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
    bool autofocus = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: OtlButtonVariant.secondary,
         focusNode: focusNode,
         autofocus: autofocus,
       );

  const OtlButton.outline({
    required String label,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
    bool autofocus = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: OtlButtonVariant.outline,
         focusNode: focusNode,
         autofocus: autofocus,
       );

  final String label;
  final VoidCallback? onPressed;
  final OtlButtonVariant variant;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      autofocus: autofocus,
      onPressed: otlTap(context, onPressed),
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
        padding: WidgetStatePropertyAll(_padding),
        tapTargetSize: MaterialTapTargetSize.padded,
        textStyle: WidgetStatePropertyAll(_textStyle),
        foregroundColor: WidgetStateProperty.resolveWith(_foregroundColor),
        backgroundColor: WidgetStateProperty.resolveWith(_backgroundColor),
        overlayColor: WidgetStateProperty.resolveWith(_overlayColor),
        side: WidgetStateProperty.resolveWith(_side),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.borderFull),
        ),
        elevation: WidgetStateProperty.resolveWith(_elevation),
        shadowColor: const WidgetStatePropertyAll(AppColors.primaryMain),
      ),
      child: Text(label),
    );
  }

  EdgeInsetsGeometry get _padding => switch (variant) {
    OtlButtonVariant.primary => const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    OtlButtonVariant.secondary ||
    OtlButtonVariant.outline => const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.sm,
    ),
  };

  TextStyle get _textStyle => switch (variant) {
    OtlButtonVariant.primary => AppTypography.buttonPrimary,
    OtlButtonVariant.secondary ||
    OtlButtonVariant.outline => AppTypography.buttonSecondary,
  };

  Color _foregroundColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.textDisabled;
    }
    if (variant == OtlButtonVariant.primary) {
      return AppColors.backgroundPrimary;
    }
    if (variant == OtlButtonVariant.outline) {
      return states.contains(WidgetState.pressed)
          ? AppColors.backgroundPrimary
          : AppColors.primaryMain;
    }
    return AppColors.textPrimary;
  }

  Color _backgroundColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return switch (variant) {
        OtlButtonVariant.primary => AppColors.primaryMain.withValues(
          alpha: 0.5,
        ),
        OtlButtonVariant.secondary => AppColors.backgroundTertiary.withValues(
          alpha: 0.5,
        ),
        OtlButtonVariant.outline => Colors.transparent,
      };
    }
    if (states.contains(WidgetState.pressed)) {
      return switch (variant) {
        OtlButtonVariant.primary => AppColors.primaryDark,
        OtlButtonVariant.secondary => AppColors.secondaryDark.withValues(
          alpha: 0.28,
        ),
        OtlButtonVariant.outline => AppColors.primaryMain,
      };
    }
    if (states.contains(WidgetState.focused)) {
      return switch (variant) {
        OtlButtonVariant.primary => AppColors.primaryLight,
        OtlButtonVariant.secondary => AppColors.overlayMagentaGlow,
        OtlButtonVariant.outline => AppColors.overlayGlow,
      };
    }
    return switch (variant) {
      OtlButtonVariant.primary => AppColors.primaryMain,
      OtlButtonVariant.secondary => AppColors.backgroundTertiary,
      OtlButtonVariant.outline => Colors.transparent,
    };
  }

  Color? _overlayColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed) ||
        states.contains(WidgetState.focused)) {
      return AppColors.overlayGlow;
    }
    return null;
  }

  BorderSide? _side(Set<WidgetState> states) {
    if (variant != OtlButtonVariant.outline &&
        !states.contains(WidgetState.focused)) {
      return BorderSide.none;
    }
    final color = states.contains(WidgetState.disabled)
        ? AppColors.textDisabled
        : states.contains(WidgetState.focused)
        ? AppColors.borderFocus
        : variant == OtlButtonVariant.secondary
        ? AppColors.secondaryMain
        : AppColors.primaryMain;
    return BorderSide(color: color, width: 2);
  }

  double _elevation(Set<WidgetState> states) {
    if (variant != OtlButtonVariant.primary ||
        states.contains(WidgetState.disabled)) {
      return 0;
    }
    return states.contains(WidgetState.pressed) ? 1 : 4;
  }
}
