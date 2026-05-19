import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/brutalist_theme.dart';

/// Figma home screen background with faint decorative icons.
class OtlHomeBackdrop extends StatelessWidget {
  const OtlHomeBackdrop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: BrutalistColors.screenBackground,
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                Color(0xFF333348),
                BrutalistColors.screenBackground,
              ],
              stops: [0.04, 0.04],
            ),
          ),
        ),
        const _DecorativeIcons(),
        child,
      ],
    );
  }
}

class _DecorativeIcons extends StatelessWidget {
  const _DecorativeIcons();

  static const _iconColor = Color(0xFF333348);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return Stack(
              children: [
                _placedIcon(
                  left: width * 0.02,
                  top: height * 0.08,
                  size: 75,
                  rotation: 0.21,
                  icon: Icons.search,
                ),
                _placedIcon(
                  left: width * 0.35,
                  top: height * 0.06,
                  size: 67,
                  rotation: -0.21,
                  icon: Icons.help_outline,
                ),
                _placedIcon(
                  left: width * 0.58,
                  top: height * 0.05,
                  size: 90,
                  rotation: 0.79,
                  icon: Icons.search,
                ),
                _placedIcon(
                  left: width * 0.05,
                  top: height * 0.72,
                  size: 75,
                  rotation: -0.79,
                  icon: Icons.help_outline,
                ),
                _placedIcon(
                  left: width * 0.48,
                  top: height * 0.7,
                  size: 112,
                  rotation: 0.21,
                  icon: Icons.search,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _placedIcon({
    required double left,
    required double top,
    required double size,
    required double rotation,
    required IconData icon,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotation * math.pi,
        child: Icon(icon, size: size, color: _iconColor),
      ),
    );
  }
}
