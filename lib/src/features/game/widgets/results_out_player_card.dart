import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../shared/widgets/otl_brutalist_surface.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class ResultsOutPlayerCard extends StatelessWidget {
  const ResultsOutPlayerCard({
    required this.outPlayer,
    required this.label,
    super.key,
  });
  final Player outPlayer;
  final String label;
  @override
  Widget build(BuildContext context) => OtlBrutalistSurface(
    backgroundColor: BrutalistColors.cardBackground,
    shadowOffset: 0,
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        Text(
          label,
          style: DisplayTypography.spaceGroteskResultsBadge(
            color: BrutalistColors.sectionLabel,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        PlayerAvatar(
          name: outPlayer.name,
          seed: outPlayer.avatarSeed,
          size: 72,
        ),
        const SizedBox(height: 16),
        Text(
          outPlayer.name,
          style: DisplayTypography.rubikResultsWinnerTitle(
            color: BrutalistColors.playerCardPink,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
