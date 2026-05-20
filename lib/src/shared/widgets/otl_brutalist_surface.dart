import 'package:flutter/material.dart';

import '../sound/sound_effects_scope.dart';

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
  Widget build(BuildContext context) {
    final content = Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(shadowOffset, shadowOffset),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: otlTap(context, onTap), child: content),
    );
  }
}
