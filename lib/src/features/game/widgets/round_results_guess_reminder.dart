import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'question_card_dashed_border.dart';

/// Shown when the out player was not found — reminds the group not to spoil the guess.
class RoundResultsGuessReminder extends StatelessWidget {
  const RoundResultsGuessReminder({
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
    return Padding(
      padding: const EdgeInsets.only(right: 6, bottom: 6),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(6, 6),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: ColoredBox(
                    color: BrutalistColors.votingCardSelfBackground,
                  ),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: QuestionCardDashedBorderPainter(
                      color: BrutalistColors.playerCardPink,
                      strokeWidth: 4,
                      radius: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.volume_off_rounded,
                          color: BrutalistColors.playerCardPink,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: DisplayTypography.rubikSpeakUpTitle(
                                color: BrutalistColors.playerCardPink,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              line1,
                              style: DisplayTypography.plusJakartaSecretRevealBody(
                                color: Colors.white,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
