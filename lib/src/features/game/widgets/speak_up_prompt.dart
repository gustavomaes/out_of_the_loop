import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'question_card_dashed_border.dart';

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
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        children: [
          const Positioned.fill(
            child: ColoredBox(color: BrutalistColors.headerBorder),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: QuestionCardDashedBorderPainter(
                color: Colors.black,
                strokeWidth: 4,
                radius: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text(
                  title,
                  style: DisplayTypography.rubikSpeakUpTitle(
                    color: BrutalistColors.lime,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  line1,
                  style: DisplayTypography.plusJakartaSecretRevealBody(
                    color: BrutalistColors.sectionLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  line2,
                  style: DisplayTypography.plusJakartaSecretRevealBody(
                    color: BrutalistColors.sectionLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
