import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../shared/widgets/otl_brutalist_surface.dart';
import '../../../theme/theme.dart';

Color roundResultsAvatarColorForIndex(int index) => BrutalistColors.lime;

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
  @override
  Widget build(BuildContext context) => OtlBrutalistSurface(
    backgroundColor: BrutalistColors.cardBackground,
    shadowOffset: 0,
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        PlayerAvatar(name: player.name, seed: player.avatarSeed, size: 36),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            player.name,
            style: DisplayTypography.plusJakartaVotingPlayerName(
              color: highlight
                  ? BrutalistColors.playerCardPink
                  : BrutalistColors.cardText,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            style: DisplayTypography.rubikTitle(
              color: valueColor ?? BrutalistColors.lime,
              fontSize: 22,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}
