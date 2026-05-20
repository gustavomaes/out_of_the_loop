import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../theme/theme.dart';
import 'round_results_avatar.dart';

Color roundResultsAvatarColorForIndex(int index) {
  const colors = [
    BrutalistColors.lime,
    BrutalistColors.playerCardYellow,
    BrutalistColors.resultsOutPlayerName,
  ];
  return colors[index % colors.length];
}

class RoundResultsPlayerRow extends StatelessWidget {
  const RoundResultsPlayerRow({
    required this.player,
    required this.index,
    required this.value,
    required this.highlight,
    this.valueColor,
    super.key,
  });

  final Player player;
  final int index;
  final String value;
  final bool highlight;
  final Color? valueColor;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    final nameColor = highlight
        ? BrutalistColors.resultsOutPlayerName
        : Colors.white;
    final resolvedValueColor =
        valueColor ??
        (highlight ? BrutalistColors.lime : BrutalistColors.sectionLabel);
    final avatarColor = highlight
        ? BrutalistColors.resultsOutPlayerName
        : roundResultsAvatarColorForIndex(index);

    return Opacity(
      opacity: highlight ? 1 : 0.95,
      child: Padding(
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
                    RoundResultsAvatar(
                      name: player.name,
                      seed: player.avatarSeed,
                      backgroundColor: avatarColor,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Text(
                        player.name,
                        style: DisplayTypography.plusJakartaVotingPlayerName(
                          color: nameColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      value,
                      style: DisplayTypography.rubikResultsWinnerTitle(
                        color: resolvedValueColor,
                      ),
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
