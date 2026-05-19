import 'package:flutter/material.dart';

import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../theme/theme.dart';

class FinalLeaderboardRevealSection extends StatelessWidget {
  const FinalLeaderboardRevealSection({
    required this.secretWordLabel,
    required this.secretWord,
    required this.outPlayerLabel,
    super.key,
  });

  final String secretWordLabel;
  final String secretWord;
  final String? outPlayerLabel;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.homeSecondaryButton,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              secretWordLabel,
              style: DisplayTypography.plusJakartaResultsRevealLabel(
                color: BrutalistColors.sectionLabel,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              secretWord.toUpperCase(),
              style: DisplayTypography.rubikResultsSecretWord(
                color: BrutalistColors.playerCountBadgeBackground,
              ),
              textAlign: TextAlign.center,
            ),
            if (outPlayerLabel != null) ...[
              const SizedBox(height: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.cardBackground,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    outPlayerLabel!,
                    style: DisplayTypography.plusJakartaResultsRevealBody(
                      color: BrutalistColors.cardText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
