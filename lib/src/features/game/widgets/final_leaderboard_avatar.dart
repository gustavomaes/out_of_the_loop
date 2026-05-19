import 'package:flutter/material.dart';

import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class FinalLeaderboardAvatar extends StatelessWidget {
  const FinalLeaderboardAvatar({
    required this.rank,
    required this.name,
    required this.seed,
    super.key,
  });

  final int rank;
  final String name;
  final String seed;

  @override
  Widget build(BuildContext context) {
    final frameColor = switch (rank) {
      1 => BrutalistColors.playerCountBadgeBackground,
      2 => BrutalistColors.playerCardYellow,
      _ => BrutalistColors.headerBorder,
    };
    final fillColor = switch (rank) {
      1 => BrutalistColors.lime,
      2 => BrutalistColors.playerCardYellow,
      _ => BrutalistColors.headerBorder,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: frameColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: fillColor,
            shape: BoxShape.circle,
          ),
          child: PlayerAvatar(name: name, seed: seed, size: 36),
        ),
      ),
    );
  }
}
