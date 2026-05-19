import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/theme.dart';

class MatchSetupHeader extends StatelessWidget {
  const MatchSetupHeader({required this.l10n, super.key});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.matchSetupTitleLine1,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        Text(
          l10n.matchSetupTitleLine2,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: const Offset(4, 4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.playerCardYellow,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    l10n.matchSetupRulesBadge,
                    key: const Key('match_setup_rules_badge'),
                    style: DisplayTypography.spaceGroteskMeta(
                      color: BrutalistColors.limeText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
