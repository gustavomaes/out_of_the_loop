import 'package:flutter/material.dart';

/// Stacked foreground + offset shadow text used on game headlines.
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
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: shadowOffset,
          child: Text(
            text,
            style: style.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Text(text, style: style, textAlign: TextAlign.center),
      ],
    );
  }
}
