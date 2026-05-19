import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class RoundResultsScreen extends StatelessWidget {
  const RoundResultsScreen({
    required this.players,
    required this.round,
    required this.result,
    this.totalRoundCount,
    this.language = SupportedLanguage.ptBr,
    this.onContinue,
    this.onGuess,
    super.key,
  });

  final List<Player> players;
  final RoundState round;
  final RoundResult result;
  final int? totalRoundCount;
  final SupportedLanguage language;
  final VoidCallback? onContinue;
  final VoidCallback? onGuess;

  @override
  Widget build(BuildContext context) {
    final outPlayer = _playerById(players, result.outPlayerId);
    final secretWord = round.secretWord.value.valueFor(language);

    return AppShell(
      routeName: AppRoutes.gameResults,
      title: 'Round Results',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Text('ROUND RESULTS', style: AppTypography.emphasis),
          const SizedBox(height: AppSpacing.sm),
          OtlCard(
            accented: true,
            accentColor: AppColors.secondaryMain,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('The out player was', style: AppTypography.label),
                const SizedBox(height: AppSpacing.xs),
                Text(outPlayer.name, style: AppTypography.h1),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OtlCard(
            selected: result.wasOutFoundByMajority,
            child: Text(
              result.wasOutFoundByMajority
                  ? 'The group found the out player by majority.'
                  : 'The out player escaped the majority vote.',
              style: AppTypography.bodyLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OtlCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SECRET WORD', style: AppTypography.emphasis),
                const SizedBox(height: AppSpacing.xs),
                Text(secretWord, style: AppTypography.h2),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Vote totals', style: AppTypography.h3),
          const SizedBox(height: AppSpacing.sm),
          for (final player in players)
            _ScoreRow(
              label: player.name,
              value: '${result.voteCounts[player.id] ?? 0} votes',
            ),
          const SizedBox(height: AppSpacing.lg),
          Text('Round points', style: AppTypography.h3),
          const SizedBox(height: AppSpacing.sm),
          for (final player in players)
            _ScoreRow(
              label: player.name,
              value: '+${_pointsFor(player.id)}',
              valueColor: _pointsFor(player.id) > 0
                  ? AppColors.success
                  : AppColors.textSecondary,
            ),
          const SizedBox(height: AppSpacing.xl),
          OtlButton.primary(
            label: result.wasOutFoundByMajority
                ? _continueLabel
                : 'GUESS WORD',
            onPressed: result.wasOutFoundByMajority
                ? onContinue
                : onGuess ??
                      () =>
                          Navigator.of(context).pushNamed(AppRoutes.gameGuess),
          ),
          ],
        ),
      ),
    );
  }

  String get _continueLabel {
    final roundCount = totalRoundCount;
    if (roundCount == null) {
      return 'CONTINUE';
    }
    if (round.roundNumber >= roundCount) {
      return 'Ver placar final';
    }
    return 'Ir para rodada ${round.roundNumber + 1}';
  }

  int _pointsFor(String playerId) {
    return result.scoreEvents
        .where((event) => event.playerId == playerId)
        .fold(0, (sum, event) => sum + event.points);
  }
}

class GuessScreen extends StatelessWidget {
  const GuessScreen({
    required this.players,
    required this.round,
    this.onResolved,
    VoteScoringService? scoringService,
    super.key,
  }) : scoringService = scoringService ?? const VoteScoringService();

  final List<Player> players;
  final RoundState round;
  final ValueChanged<RoundResult>? onResolved;
  final VoteScoringService scoringService;

  @override
  Widget build(BuildContext context) {
    final outPlayer = _playerById(players, round.outPlayerId);

    return AppShell(
      routeName: AppRoutes.gameGuess,
      title: 'Guess',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('${outPlayer.name}, guess the word', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.md),
          OtlCard(
            accented: true,
            accentColor: AppColors.secondaryMain,
            child: Text(
              'Say the secret word out loud. The group decides if you got it right.',
              style: AppTypography.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          OtlButton.primary(label: 'ACERTOU', onPressed: () => _resolve(true)),
          const SizedBox(height: AppSpacing.md),
          OtlButton.secondary(label: 'ERROU', onPressed: () => _resolve(false)),
        ],
      ),
    );
  }

  void _resolve(bool guessWasCorrect) {
    onResolved?.call(
      scoringService.calculateRoundResult(
        round: round,
        players: players,
        guessWasCorrect: guessWasCorrect,
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.textSecondary,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: OtlCard(
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(value, style: AppTypography.body.copyWith(color: valueColor)),
          ],
        ),
      ),
    );
  }
}

Player _playerById(List<Player> players, String playerId) {
  return players.firstWhere((player) => player.id == playerId);
}
