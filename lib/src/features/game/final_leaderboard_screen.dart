import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class FinalLeaderboardScreen extends StatelessWidget {
  const FinalLeaderboardScreen({
    required this.players,
    this.onNewMatch,
    this.onBackHome,
    super.key,
  });

  final List<Player> players;
  final VoidCallback? onNewMatch;
  final VoidCallback? onBackHome;

  @override
  Widget build(BuildContext context) {
    final ranking = [...players]
      ..sort((left, right) {
        final scoreCompare = right.totalScore.compareTo(left.totalScore);
        return scoreCompare == 0
            ? left.name.compareTo(right.name)
            : scoreCompare;
      });
    final winner = ranking.firstOrNull;

    return AppShell(
      routeName: AppRoutes.gameFinal,
      title: 'Final Leaderboard',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('GAME OVER', style: AppTypography.h1),
          const SizedBox(height: AppSpacing.sm),
          if (winner != null)
            Text(
              '${winner.name} wins!',
              style: AppTypography.h2.copyWith(color: AppColors.secondaryMain),
            ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: ListView.separated(
              itemCount: ranking.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final player = ranking[index];
                final isWinner = index == 0;
                return OtlCard(
                  selected: isWinner,
                  child: Row(
                    children: [
                      Text('#${index + 1}', style: AppTypography.emphasis),
                      const SizedBox(width: AppSpacing.md),
                      PlayerAvatar(name: player.name, seed: player.avatarSeed),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          player.name,
                          style: AppTypography.body.copyWith(
                            color: isWinner
                                ? AppColors.secondaryMain
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        '${player.totalScore} pts',
                        style: AppTypography.body.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          OtlButton.primary(
            label: 'NOVA PARTIDA',
            onPressed:
                onNewMatch ??
                () => Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.categories),
          ),
          const SizedBox(height: AppSpacing.md),
          OtlButton.secondary(
            label: 'VOLTAR AO INICIO',
            onPressed:
                onBackHome ??
                () => Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false),
          ),
        ],
      ),
    );
  }
}
