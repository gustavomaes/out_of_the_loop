import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../theme/theme.dart';
import 'voting_action_button.dart';
import 'voting_avatar.dart';

class VotingPlayerCard extends StatelessWidget {
  const VotingPlayerCard({
    required this.player,
    required this.index,
    required this.isSelf,
    required this.voteLabel,
    required this.youLabel,
    required this.cannotVoteSelfLabel,
    required this.onVote,
    super.key,
  });

  final Player player;
  final int index;
  final bool isSelf;
  final String voteLabel;
  final String youLabel;
  final String cannotVoteSelfLabel;
  final VoidCallback? onVote;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    final avatarColor = isSelf
        ? BrutalistColors.headerBorder
        : votingAvatarColorForIndex(index);

    return Opacity(
      opacity: isSelf ? 0.8 : 1,
      child: Padding(
        padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!isSelf)
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
                color: isSelf
                    ? BrutalistColors.votingCardSelfBackground
                    : BrutalistColors.cardBackground,
                border: Border.all(
                  color: isSelf ? BrutalistColors.headerBorder : Colors.black,
                  width: 4,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    VotingAvatar(
                      name: player.name,
                      seed: player.avatarSeed,
                      backgroundColor: avatarColor,
                      dimmed: isSelf,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSelf ? youLabel : player.name,
                            style: DisplayTypography.plusJakartaVotingPlayerName(
                              color: isSelf
                                  ? BrutalistColors.sectionLabel
                                  : Colors.white,
                            ),
                          ),
                          if (isSelf) ...[
                            const SizedBox(height: 2),
                            Text(
                              cannotVoteSelfLabel,
                              style: DisplayTypography.spaceGroteskVotingSelfHint(
                                color: BrutalistColors.cardText,
                              ).copyWith(
                                color: BrutalistColors.cardText.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    VotingActionButton(
                      label: voteLabel,
                      enabled: !isSelf && onVote != null,
                      onPressed: onVote,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
