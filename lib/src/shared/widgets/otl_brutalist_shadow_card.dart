import 'package:flutter/material.dart';

/// Neubrutalist card with hard offset shadow that fills the parent width.
class OtlBrutalistShadowCard extends StatelessWidget {
  const OtlBrutalistShadowCard({
    required this.color,
    required this.child,
    this.borderRadius = 48,
    super.key,
  });

  final Color color;
  final Widget child;
  final double borderRadius;

  static const _shadowDx = 4.0;
  static const _shadowDy = 4.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowDx, _shadowDy),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: radius,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: radius,
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
