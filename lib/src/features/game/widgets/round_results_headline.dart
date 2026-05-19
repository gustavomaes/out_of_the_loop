import 'package:flutter/material.dart';

import '../../../shared/widgets/otl_shadowed_text.dart';
import '../../../theme/theme.dart';

class RoundResultsHeadline extends StatelessWidget {
  const RoundResultsHeadline({
    required this.accentLabel,
    required this.mainLabel,
    required this.outcomeMessage,
    required this.success,
    super.key,
  });

  final String accentLabel;
  final String mainLabel;
  final String outcomeMessage;
  final bool success;

  @override
  Widget build(BuildContext context) {
    final accentColor = success
        ? BrutalistColors.playerCardGreen
        : BrutalistColors.resultsOutPlayerName;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              OtlShadowedText(
                text: accentLabel,
                style: DisplayTypography.rubikVotingHeadlineAccent(
                  color: accentColor,
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
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            outcomeMessage,
            style: DisplayTypography.plusJakartaVotingSubtitle(
              color: BrutalistColors.sectionLabel,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
