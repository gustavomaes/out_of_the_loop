import 'package:flutter/material.dart';

import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../shared/widgets/otl_shadowed_text.dart';
import '../../../theme/theme.dart';

class GuessHeadline extends StatelessWidget {
  const GuessHeadline({
    required this.accentLabel,
    required this.mainLabel,
    required this.playerTurnLabel,
    required this.instructionLines,
    super.key,
  });

  final String accentLabel;
  final String mainLabel;
  final String playerTurnLabel;
  final List<String> instructionLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              OtlShadowedText(
                text: accentLabel,
                style: DisplayTypography.rubikVotingHeadlineAccent(
                  color: BrutalistColors.playerCardGreen,
                ),
                shadowOffset: const Offset(4, 4),
              ),
              OtlShadowedText(
                text: mainLabel,
                style: DisplayTypography.rubikVotingHeadlineMain(
                  color: Colors.white,
                ),
                shadowOffset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          playerTurnLabel,
          style: DisplayTypography.rubikSpeakUpTitle(
            color: BrutalistColors.resultsOutPlayerName,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        OtlBrutalistShadowCard(
          color: BrutalistColors.homeSecondaryButton,
          borderRadius: 32,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                for (final line in instructionLines)
                  Text(
                    line,
                    style: DisplayTypography.plusJakartaVotingSubtitle(
                      color: BrutalistColors.sectionLabel,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
