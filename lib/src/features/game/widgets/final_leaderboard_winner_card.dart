import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class FinalLeaderboardWinnerCard extends StatelessWidget {
  const FinalLeaderboardWinnerCard({
    required this.winner,
    required this.winsLabel,
    required this.mastermindLabel,
    super.key,
  });

  final Player winner;
  final String winsLabel;
  final String mastermindLabel;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.lime,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: -8,
            top: -8,
            child: Opacity(
              opacity: 0.35,
              child: Icon(
                Icons.star,
                color: BrutalistColors.resultsWinnerStar,
                size: 48,
              ),
            ),
          ),
          const Positioned(
            right: -8,
            bottom: -16,
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.emoji_events,
                color: BrutalistColors.playerCardYellow,
                size: 56,
              ),
            ),
          ),
          Padding(
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
                        color: BrutalistColors.playerCardPink,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: PlayerAvatar(
                        name: winner.name,
                        seed: winner.avatarSeed,
                        size: 88,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  winsLabel,
                  style: DisplayTypography.rubikResultsWinnerTitle(
                    color: BrutalistColors.limeText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
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
                      mastermindLabel,
                      style: DisplayTypography.spaceGroteskResultsBadge(
                        color: BrutalistColors.lime,
                      ),
                    ),
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
