import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'home_title_lines.dart';

/// Figma node `2:16` — lime title with 4×4 black offset shadow.
class HomeHeroTitle extends StatelessWidget {
  const HomeHeroTitle({super.key});

  static const _shadowOffset = Offset(4, 4);
  static const _horizontalPadding = 43.5;

  TextStyle _lineStyle(Color color) =>
      DisplayTypography.rubikHomeTitle(color: color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.translate(
            offset: _shadowOffset,
            child: HomeTitleLines(style: _lineStyle(Colors.black)),
          ),
          HomeTitleLines(style: _lineStyle(BrutalistColors.lime)),
        ],
      ),
    );
  }
}
