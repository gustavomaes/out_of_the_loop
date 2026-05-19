import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/theme.dart';
import 'heading_with_shadow.dart';

class SecretRevealInstructions extends StatelessWidget {
  const SecretRevealInstructions({
    required this.l10n,
    required this.roundNumber,
    required this.playerName,
    super.key,
  });

  final AppLocalizations l10n;
  final int roundNumber;
  final String playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          l10n.secretRevealRound(roundNumber),
          style: DisplayTypography.spaceGroteskRoundLabel(
            color: BrutalistColors.playerCardYellow,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        HeadingWithShadow(
          line1: l10n.secretRevealPassTo,
          line2: l10n.secretRevealPassToPlayer(playerName),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Column(
            children: [
              Text(
                l10n.secretRevealPrivacyLine1,
                style: DisplayTypography.plusJakartaSecretRevealBody(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                l10n.secretRevealPrivacyLine2,
                style: DisplayTypography.plusJakartaSecretRevealBody(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
