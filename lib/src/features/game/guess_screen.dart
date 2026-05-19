import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_discovery_app_bar.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../theme/theme.dart';
import 'widgets/guess_headline.dart';
import 'widgets/results_out_player_card.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final outPlayer = _playerById(players, round.outPlayerId);

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(onBack: () => context.pop()),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GuessHeadline(
                              accentLabel: l10n.guessHeadlineAccent,
                              mainLabel: l10n.guessHeadlineMain,
                              playerTurnLabel: l10n.guessPlayerTurn(
                                outPlayer.name,
                              ),
                              instructionLines: [
                                l10n.guessInstructionLine1,
                                l10n.guessInstructionLine2,
                                l10n.guessInstructionLine3,
                              ],
                            ),
                            const SizedBox(height: 24),
                            ResultsOutPlayerCard(
                              outPlayer: outPlayer,
                              label: l10n.roundResultsOutPlayerLabel,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    OtlBrutalistPillButton(
                      label: l10n.guessCorrectButton,
                      icon: Icons.check,
                      backgroundColor: BrutalistColors.lime,
                      foregroundColor: BrutalistColors.limeText,
                      borderRadius: 0,
                      onPressed: () => _resolve(true),
                    ),
                    const SizedBox(height: 16),
                    OtlBrutalistPillButton(
                      label: l10n.guessWrongButton,
                      icon: Icons.close,
                      backgroundColor: BrutalistColors.homeSecondaryButton,
                      foregroundColor: BrutalistColors.cardText,
                      borderRadius: 0,
                      onPressed: () => _resolve(false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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

Player _playerById(List<Player> players, String playerId) {
  return players.firstWhere((player) => player.id == playerId);
}
