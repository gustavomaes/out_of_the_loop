import 'package:flutter/material.dart';

/// Bundled Twemoji artwork avoids platform color-font rendering failures.
/// These images are decorative; the adjacent localized text names the control.
class ClassicEmojiLabel extends StatelessWidget {
  const ClassicEmojiLabel({
    super.key,
    required this.emoji,
    required this.label,
    this.style,
  });

  final String emoji;
  final String label;
  final TextStyle? style;

  static String assetFor(String emoji) {
    final code = emoji.runes
        .where((rune) => rune != 0xfe0f)
        .map((rune) => rune.toRadixString(16))
        .join('-');
    return 'assets/emoji/$code.png';
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style.merge(style);
    final size = MediaQuery.textScalerOf(
      context,
    ).scale(textStyle.fontSize ?? 14);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetFor(emoji),
          width: size,
          height: size,
          excludeFromSemantics: true,
        ),
        const SizedBox(width: 8),
        Flexible(child: Text(label, style: style)),
      ],
    );
  }
}
