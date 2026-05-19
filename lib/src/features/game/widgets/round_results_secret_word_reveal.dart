import 'package:flutter/material.dart';

import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../theme/theme.dart';

class RoundResultsSecretWordReveal extends StatelessWidget {
  const RoundResultsSecretWordReveal({
    required this.label,
    required this.secretWord,
    super.key,
  });

  final String label;
  final String secretWord;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.homeSecondaryButton,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              label,
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
          ],
        ),
      ),
    );
  }
}
