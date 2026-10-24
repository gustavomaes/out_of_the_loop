import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class SpeakUpPrompt extends StatelessWidget {
  const SpeakUpPrompt({
    required this.title,
    required this.line1,
    required this.line2,
    super.key,
  });
  final String title;
  final String line1;
  final String line2;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: DisplayTypography.spaceGroteskSectionLabel(
            color: BrutalistColors.cardText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          line1,
          style: DisplayTypography.plusJakartaSecretRevealBody(
            color: BrutalistColors.sectionLabel,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          line2,
          style: DisplayTypography.plusJakartaSecretRevealBody(
            color: BrutalistColors.sectionLabel,
          ),
        ),
      ],
    ),
  );
}
