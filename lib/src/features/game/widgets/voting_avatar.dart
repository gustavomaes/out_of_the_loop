import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

Color votingAvatarColorForIndex(int index) {
  const colors = [
    BrutalistColors.lime,
    BrutalistColors.playerCardYellow,
    BrutalistColors.votingAtmosphereAccent,
  ];
  return colors[index % colors.length];
}

class VotingAvatar extends StatelessWidget {
  const VotingAvatar({
    required this.name,
    required this.seed,
    required this.backgroundColor,
    required this.dimmed,
    super.key,
  });

  final String name;
  final String seed;
  final Color backgroundColor;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: dimmed ? BrutalistColors.headerBorder : Colors.black,
          width: 4,
        ),
        boxShadow: dimmed
            ? null
            : const [
                BoxShadow(
                  color: BrutalistColors.votingAvatarInsetShadow,
                  offset: Offset(0, -4),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: PlayerAvatar(name: name, seed: seed, size: 48),
      ),
    );
  }
}
