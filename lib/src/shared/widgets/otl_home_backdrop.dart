import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class OtlHomeBackdrop extends StatelessWidget {
  const OtlHomeBackdrop({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0.7, -0.5),
        radius: 1.2,
        colors: [Color(0xFF30203E), BrutalistColors.screenBackground],
      ),
    ),
    child: child,
  );
}
