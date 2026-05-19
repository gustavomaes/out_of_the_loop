import 'package:flutter/material.dart';

import '../home_screen.dart';

/// Two-line brand title for the home hero.
class HomeTitleLines extends StatelessWidget {
  const HomeTitleLines({required this.style, super.key});

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          HomeBrand.lineOne,
          style: style,
          textAlign: TextAlign.center,
        ),
        Text(
          HomeBrand.lineTwo,
          style: style,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
