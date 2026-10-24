import 'package:flutter/material.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../shared/widgets/otl_brutalist_surface.dart';
import '../../../shared/sound/sound_effects_scope.dart';
import '../../../theme/theme.dart';

class OtlPlayerTile extends StatelessWidget {
  const OtlPlayerTile({
    required this.name,
    required this.avatarSeed,
    required this.backgroundColor,
    required this.onRemove,
    required this.removeTooltip,
    super.key,
  });
  final String name;
  final String avatarSeed;
  final Color backgroundColor;
  final VoidCallback onRemove;
  final String removeTooltip;
  @override
  Widget build(BuildContext context) => OtlBrutalistSurface(
    backgroundColor: BrutalistColors.cardBackground,
    shadowOffset: 0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: [
        PlayerAvatar(name: name, seed: avatarSeed, size: 40),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            name,
            style: DisplayTypography.rubikPlayerCardName(
              color: BrutalistColors.cardText,
            ),
          ),
        ),
        IconButton(
          onPressed: otlTap(context, onRemove),
          tooltip: removeTooltip,
          icon: const Icon(
            Icons.close,
            color: BrutalistColors.sectionLabel,
            size: 20,
          ),
        ),
      ],
    ),
  );
}

Color playerCardColorForIndex(int index) => BrutalistColors.cardBackground;
