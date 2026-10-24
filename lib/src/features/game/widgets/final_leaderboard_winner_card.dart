import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class FinalLeaderboardWinnerCard extends StatelessWidget {
  const FinalLeaderboardWinnerCard({
    required this.winner,
    required this.winsLabel,
    required this.mastermindLabel,
    super.key,
  });
  final Player winner;
  final String winsLabel;
  final String mastermindLabel;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    decoration: BoxDecoration(
      color: BrutalistColors.cardBackground,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: BrutalistColors.lime),
    ),
    child: Column(
      children: [
        const Icon(Icons.auto_awesome, color: BrutalistColors.lime, size: 36),
        const SizedBox(height: 20),
        PlayerAvatar(name: winner.name, seed: winner.avatarSeed, size: 80),
        const SizedBox(height: 20),
        Text(
          winsLabel,
          style: DisplayTypography.rubikResultsWinnerTitle(
            color: BrutalistColors.cardText,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          mastermindLabel,
          style: DisplayTypography.spaceGroteskResultsBadge(
            color: BrutalistColors.lime,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
