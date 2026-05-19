import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class ResultsOutPlayerCard extends StatelessWidget {
  const ResultsOutPlayerCard({
    required this.outPlayer,
    required this.label,
    super.key,
  });

  final Player outPlayer;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.playerCardPink,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: BrutalistColors.cardBackground,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: BrutalistColors.resultsOutPlayerName,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: PlayerAvatar(
                    name: outPlayer.name,
                    seed: outPlayer.avatarSeed,
                    size: 88,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                child: Text(
                  label,
                  style: DisplayTypography.spaceGroteskResultsBadge(
                    color: BrutalistColors.lime,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              outPlayer.name,
              style: DisplayTypography.rubikResultsWinnerTitle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
