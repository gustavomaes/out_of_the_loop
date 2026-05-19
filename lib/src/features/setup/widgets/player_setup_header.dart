import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../theme/theme.dart';

class PlayerSetupHeader extends StatelessWidget {
  const PlayerSetupHeader({required this.l10n, super.key});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.playerSetupTitleLine1,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        Text(
          l10n.playerSetupTitleLine2,
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
                  color: BrutalistColors.playerCountBadgeBackground,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    l10n.playerSetupPlayerCountBadge,
                    key: const Key('player_setup_count_badge'),
                    style: DisplayTypography.spaceGroteskMeta(
                      color: BrutalistColors.playerCountBadgeText,
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
