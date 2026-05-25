import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../theme/theme.dart';
import 'voting_avatar.dart';

/// Highlights who is active on this device (pass-and-play).
class ActivePlayerBanner extends StatelessWidget {
  const ActivePlayerBanner({
    required this.player,
    required this.statusLabel,
    this.avatarColor = BrutalistColors.headerBorder,
    super.key,
  });

  final Player player;
  final String statusLabel;
  final Color avatarColor;

  static const _shadowDx = 6.0;
  static const _shadowDy = 6.0;

  @override
  Widget build(BuildContext context) {
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
              color: BrutalistColors.votingCardSelfBackground,
              border: Border.all(color: BrutalistColors.headerBorder, width: 4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  VotingAvatar(
                    name: player.name,
                    seed: player.avatarSeed,
                    backgroundColor: avatarColor,
                    dimmed: false,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusLabel,
                          style: DisplayTypography.spaceGroteskVotingSelfHint(
                            color: BrutalistColors.cardText,
                          ).copyWith(
                            fontSize: 12,
                            height: 18 / 12,
                            color: BrutalistColors.cardText.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          player.name,
                          style: DisplayTypography.plusJakartaVotingPlayerName(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
