import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class HeadingWithShadow extends StatelessWidget {
  const HeadingWithShadow({
    required this.line1,
    required this.line2,
    super.key,
  });
  final String line1;
  final String line2;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        line1,
        style: DisplayTypography.rubikSecretRevealHeading(
          color: BrutalistColors.cardText,
        ),
      ),
      Text(
        line2,
        style: DisplayTypography.rubikSecretRevealHeading(
          color: BrutalistColors.cardText,
        ),
      ),
    ],
  );
}
