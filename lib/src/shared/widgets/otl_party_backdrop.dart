import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Subtle dotted party background used on discovery and hero screens.
class OtlPartyBackdrop extends StatelessWidget {
  const OtlPartyBackdrop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: _DotGridPainter()),
        child,
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderDefault.withValues(alpha: 0.35);
    const spacing = 24.0;
    const radius = 1.5;

    for (var x = spacing / 2; x < size.width; x += spacing) {
      for (var y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
