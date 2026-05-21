import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/results_out_player_card.dart';
import 'widgets/round_results_headline.dart';
import 'widgets/round_results_player_row.dart';
import 'widgets/round_results_secret_word_reveal.dart';
import 'widgets/round_results_stat_section.dart';

class RoundResultsScreen extends StatelessWidget {
  const RoundResultsScreen({
    required this.players,
    required this.round,
    required this.result,
    this.totalRoundCount,
    this.language = SupportedLanguage.en,
    this.onContinue,
    this.onGuess,
    this.onBack,
    super.key,
  });

  final List<Player> players;
  final RoundState round;
  final RoundResult result;
  final int? totalRoundCount;
  final SupportedLanguage language;
  final VoidCallback? onContinue;
  final VoidCallback? onGuess;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final outPlayer = _playerById(players, result.outPlayerId);
    final secretWord = round.secretWord.value.valueFor(language);
    final primaryAction = result.wasOutFoundByMajority
        ? _continueLabel(l10n)
        : l10n.guessWord;
    final outcomeMessage = result.wasOutFoundByMajority
        ? l10n.roundResultsMajorityFound
        : l10n.roundResultsMajorityEscaped;

    return BrutalistScreenTheme.wrap(
      context,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            unawaited(confirmExitGameOnBack(context, onBack: onBack));
          }
        },
        child: Scaffold(
          appBar: OtlBrutalistDiscoveryAppBar(
            onBack: () => confirmExitGameOnBack(context, onBack: onBack),
            showSettings: false,
          ),
          body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundResultsHeadline(
                      accentLabel: l10n.roundResultsHeadlineAccent,
                      mainLabel: l10n.roundResultsHeadlineMain,
                      outcomeMessage: outcomeMessage,
                      success: result.wasOutFoundByMajority,
                    ),
                    const SizedBox(height: 24),
                    ResultsOutPlayerCard(
                      outPlayer: outPlayer,
                      label: l10n.roundResultsOutPlayerLabel,
                    ),
                    if (result.wasOutFoundByMajority) ...[
                      const SizedBox(height: 24),
                      RoundResultsSecretWordReveal(
                        label: l10n.resultsSecretWordWas,
                        secretWord: secretWord,
                      ),
                    ],
                    const SizedBox(height: 24),
                    RoundResultsStatSection(
                      title: l10n.roundResultsVoteTotals,
                      children: [
                        for (var index = 0; index < players.length; index += 1)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: index < players.length - 1 ? 16 : 0,
                            ),
                            child: RoundResultsPlayerRow(
                              player: players[index],
                              index: index,
                              value: l10n.roundResultsVoteCount(
                                result.voteCounts[players[index].id] ?? 0,
                              ),
                              highlight:
                                  players[index].id == result.outPlayerId,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    RoundResultsStatSection(
                      title: l10n.roundResultsRoundPoints,
                      children: [
                        for (var index = 0; index < players.length; index += 1)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: index < players.length - 1 ? 16 : 0,
                            ),
                            child: RoundResultsPlayerRow(
                              player: players[index],
                              index: index,
                              value: l10n.roundResultsPointsGain(
                                _pointsFor(players[index].id),
                              ),
                              highlight: _pointsFor(players[index].id) > 0,
                              valueColor: _pointsFor(players[index].id) > 0
                                  ? BrutalistColors.lime
                                  : BrutalistColors.sectionLabel,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    OtlBrutalistPillButton(
                      label: primaryAction,
                      icon: result.wasOutFoundByMajority
                          ? Icons.arrow_forward
                          : Icons.record_voice_over_outlined,
                      backgroundColor: BrutalistColors.lime,
                      foregroundColor: BrutalistColors.limeText,
                      borderRadius: 0,
                      onPressed: result.wasOutFoundByMajority
                          ? onContinue
                          : onGuess ?? () => context.push(AppRoutes.gameGuess),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  String _continueLabel(AppLocalizations l10n) {
    final roundCount = totalRoundCount;
    if (roundCount == null) {
      return l10n.roundResultsContinue;
    }
    if (round.roundNumber >= roundCount) {
      return l10n.roundResultsViewFinalScore;
    }
    return l10n.roundResultsGoToRound(round.roundNumber + 1);
  }

  int _pointsFor(String playerId) {
    return result.scoreEvents
        .where((event) => event.playerId == playerId)
        .fold(0, (sum, event) => sum + event.points);
  }
}

Player _playerById(List<Player> players, String playerId) {
  return players.firstWhere((player) => player.id == playerId);
}
