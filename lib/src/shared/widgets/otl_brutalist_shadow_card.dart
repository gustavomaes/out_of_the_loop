import 'package:flutter/material.dart';
import 'otl_brutalist_surface.dart';

class OtlBrutalistShadowCard extends StatelessWidget {
  const OtlBrutalistShadowCard({
    required this.color,
    required this.child,
    this.borderRadius = 20,
    super.key,
  });
  final Color color;
  final Widget child;
  final double borderRadius;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: OtlBrutalistSurface(
      backgroundColor: color,
      shadowOffset: 0,
      child: child,
    ),
  );
}
