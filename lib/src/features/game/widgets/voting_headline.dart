import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class VotingHeadline extends StatelessWidget {
  const VotingHeadline({required this.l10n, super.key});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              OtlShadowedText(
                text: l10n.votingHeadlineWhoIs,
                style: DisplayTypography.rubikVotingHeadlineAccent(
                  color: BrutalistColors.playerCardGreen,
                ),
                shadowOffset: const Offset(4, 4),
              ),
              OtlShadowedText(
                text: l10n.votingHeadlineOutOf,
                style: DisplayTypography.rubikVotingHeadlineMain(
                  color: Colors.white,
                ),
                shadowOffset: const Offset(2, 2),
              ),
              OtlShadowedText(
                text: l10n.votingHeadlineTheLoop,
                style: DisplayTypography.rubikVotingHeadlineMain(
                  color: Colors.white,
                ),
                shadowOffset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${l10n.votingSubtitleLine1} ${l10n.votingSubtitleLine2} '
          '${l10n.votingSubtitleLine3}',
          style: DisplayTypography.plusJakartaVotingSubtitle(
            color: BrutalistColors.sectionLabel,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
