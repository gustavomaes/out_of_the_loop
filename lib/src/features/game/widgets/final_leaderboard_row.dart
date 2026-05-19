import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../theme/theme.dart';
import 'final_leaderboard_avatar.dart';

class FinalLeaderboardRow extends StatelessWidget {
  const FinalLeaderboardRow({
    required this.rank,
    required this.player,
    required this.isOutPlayer,
    super.key,
  });

  final int rank;
  final Player player;
  final bool isOutPlayer;

  @override
  Widget build(BuildContext context) {
    final isFirst = rank == 1;
    final rankColor = isFirst
        ? BrutalistColors.playerCardYellow
        : BrutalistColors.sectionLabel;
    final nameColor = isOutPlayer
        ? BrutalistColors.resultsOutPlayerName
        : BrutalistColors.cardText;
    final scoreColor = isFirst
        ? BrutalistColors.lime
        : isOutPlayer
        ? BrutalistColors.sectionLabel
        : BrutalistColors.cardText;

    return Opacity(
      opacity: isOutPlayer && !isFirst ? 0.75 : 1,
      child: OtlBrutalistShadowCard(
        color: BrutalistColors.cardBackground,
        borderRadius: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Text(
                  '$rank',
                  style: DisplayTypography.rubikResultsRank(
                    color: rankColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FinalLeaderboardAvatar(
                rank: rank,
                name: player.name,
                seed: player.avatarSeed,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  player.name,
                  style: DisplayTypography.rubikResultsPlayerName(
                    color: nameColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${player.totalScore}',
                style: DisplayTypography.rubikResultsScore(
                  color: scoreColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
