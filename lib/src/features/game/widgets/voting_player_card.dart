import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../shared/sound/sound_effects_scope.dart';
import '../../../theme/theme.dart';

class VotingPlayerCard extends StatelessWidget {
  const VotingPlayerCard({
    required this.player,
    required this.index,
    required this.voteLabel,
    required this.onVote,
    this.selected = false,
    super.key,
  });
  final Player player;
  final int index;
  final String voteLabel;
  final VoidCallback? onVote;
  final bool selected;
  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: Material(
      color: BrutalistColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected ? BrutalistColors.lime : BrutalistColors.headerBorder,
          width: selected ? 2 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: otlTap(context, onVote),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              PlayerAvatar(
                name: player.name,
                seed: player.avatarSeed,
                size: 40,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  player.name,
                  style: DisplayTypography.plusJakartaVotingPlayerName(
                    color: BrutalistColors.cardText,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected
                    ? BrutalistColors.lime
                    : BrutalistColors.sectionLabel,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
