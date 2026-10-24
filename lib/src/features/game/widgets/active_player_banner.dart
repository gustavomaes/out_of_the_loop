import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

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
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statusLabel,
                style: DisplayTypography.spaceGroteskMeta(
                  color: BrutalistColors.sectionLabel,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                player.name,
                style: DisplayTypography.rubikTitle(
                  color: BrutalistColors.cardText,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        PlayerAvatar(name: player.name, seed: player.avatarSeed, size: 48),
      ],
    ),
  );
}
