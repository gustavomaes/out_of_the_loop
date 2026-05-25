import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../theme/theme.dart';
import 'voting_action_button.dart';
import 'voting_avatar.dart';

class VotingPlayerCard extends StatelessWidget {
  const VotingPlayerCard({
    required this.player,
    required this.index,
    required this.voteLabel,
    required this.onVote,
    super.key,
  });

  final Player player;
  final int index;
  final String voteLabel;
  final VoidCallback? onVote;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    final avatarColor = votingAvatarColorForIndex(index);

    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowDx, _shadowDy),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: 4),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.cardBackground,
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  VotingAvatar(
                    name: player.name,
                    seed: player.avatarSeed,
                    backgroundColor: avatarColor,
                    dimmed: false,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      player.name,
                      style: DisplayTypography.plusJakartaVotingPlayerName(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  VotingActionButton(
                    label: voteLabel,
                    enabled: onVote != null,
                    onPressed: onVote,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
