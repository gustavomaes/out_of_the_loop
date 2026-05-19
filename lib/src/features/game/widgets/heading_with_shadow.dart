import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class HeadingWithShadow extends StatelessWidget {
  const HeadingWithShadow({required this.line1, required this.line2, super.key});

  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    final style = DisplayTypography.rubikSecretRevealHeading(
      color: Colors.white,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(2, 2),
          child: Column(
            children: [
              Text(
                line1,
                style: style.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                line2,
                style: style.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(line1, style: style, textAlign: TextAlign.center),
            Text(line2, style: style, textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}
