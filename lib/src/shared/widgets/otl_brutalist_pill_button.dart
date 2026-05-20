import 'package:flutter/material.dart';

import '../sound/sound_effects_scope.dart';
import '../../theme/theme.dart';

/// Figma-aligned neubrutalist pill button for the home screen.
class OtlBrutalistPillButton extends StatelessWidget {
  const OtlBrutalistPillButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    this.borderRadius = 0,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final double borderRadius;

  static const _height = 64.0;
  static const _shadowOffset = 8.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return SizedBox(
      width: double.infinity,
      height: _height + _shadowOffset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: _shadowOffset,
            height: _height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: radius,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: _height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: otlTap(context, onPressed),
                borderRadius: radius,
                child: Ink(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: radius,
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 20, color: foregroundColor),
                      const SizedBox(width: 12),
                      Text(
                        label,
                        style: DisplayTypography.rubikHomeButton(
                          color: foregroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
