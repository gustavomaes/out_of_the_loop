import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../sound/sound_effects_scope.dart';

/// Rounded Neon surface. The legacy name keeps existing callers compatible.
class OtlBrutalistSurface extends StatelessWidget {
  const OtlBrutalistSurface({
    required this.backgroundColor,
    required this.shadowOffset,
    required this.child,
    this.padding,
    this.height,
    this.onTap,
    super.key,
  });
  final Color backgroundColor;
  final double shadowOffset;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: const BorderSide(color: BrutalistColors.headerBorder),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: otlTap(context, onTap),
      child: Container(height: height, padding: padding, child: child),
    ),
  );
}
