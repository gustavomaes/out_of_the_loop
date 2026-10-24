import 'package:flutter/material.dart';

class OtlShadowedText extends StatelessWidget {
  const OtlShadowedText({
    required this.text,
    required this.style,
    required this.shadowOffset,
    super.key,
  });
  final String text;
  final TextStyle style;
  final Offset shadowOffset;
  @override
  Widget build(BuildContext context) =>
      Text(text, style: style, textAlign: TextAlign.center);
}
