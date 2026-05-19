import 'package:flutter/material.dart';

import '../../../shared/widgets/player_avatar.dart';

class RoundResultsAvatar extends StatelessWidget {
  const RoundResultsAvatar({
    required this.name,
    required this.seed,
    required this.backgroundColor,
    super.key,
  });

  final String name;
  final String seed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: PlayerAvatar(name: name, seed: seed, size: 48),
      ),
    );
  }
}
