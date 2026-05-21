import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_discovery_app_bar.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../theme/theme.dart';
import 'widgets/final_leaderboard_reveal_section.dart';
import 'widgets/final_leaderboard_row.dart';
import 'widgets/final_leaderboard_winner_card.dart';

class FinalLeaderboardScreen extends StatelessWidget {
  const FinalLeaderboardScreen({
    required this.players,
    this.secretWord,
    this.outPlayer,
    this.language = SupportedLanguage.en,
    this.onNewMatch,
    this.onBackHome,
    super.key,
  });

  final List<Player> players;
  final SecretWord? secretWord;
  final Player? outPlayer;
  final SupportedLanguage language;
  final VoidCallback? onNewMatch;
  final VoidCallback? onBackHome;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ranking = _sortedRanking(players);
    final winner = ranking.firstOrNull;
    final secretWordLabel = secretWord?.value.valueFor(language);
    final outPlayerId = outPlayer?.id;

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: const OtlBrutalistDiscoveryAppBar(
          showBack: false,
          showSettings: false,
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (winner != null) ...[
                      FinalLeaderboardWinnerCard(
                        winner: winner,
                        winsLabel: l10n.resultsWinnerWins(winner.name),
                        mastermindLabel: l10n.resultsTheMastermind,
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (secretWordLabel != null && secretWordLabel.isNotEmpty)
                      FinalLeaderboardRevealSection(
                        secretWordLabel: l10n.resultsSecretWordWas,
                        secretWord: secretWordLabel,
                        outPlayerLabel: outPlayer == null
                            ? null
                            : l10n.resultsOutPlayerWas(outPlayer!.name),
                      ),
                    if (secretWordLabel != null && secretWordLabel.isNotEmpty)
                      const SizedBox(height: 24),
                    Text(
                      l10n.resultsLeaderboard,
                      style: DisplayTypography.spaceGroteskResultsSectionLabel(
                        color: BrutalistColors.sectionLabel,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (var index = 0; index < ranking.length; index += 1)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: index < ranking.length - 1 ? 12 : 0,
                        ),
                        child: FinalLeaderboardRow(
                          rank: index + 1,
                          player: ranking[index],
                          isOutPlayer: ranking[index].id == outPlayerId,
                        ),
                      ),
                    const SizedBox(height: 24),
                    OtlBrutalistPillButton(
                      label: l10n.playAgain,
                      icon: Icons.refresh,
                      backgroundColor: BrutalistColors.lime,
                      foregroundColor: BrutalistColors.limeText,
                      onPressed:
                          onNewMatch ??
                          () => context.goDiscoveryTab(AppRoutes.categories),
                    ),
                    const SizedBox(height: 16),
                    OtlBrutalistPillButton(
                      label: l10n.backToHome,
                      icon: Icons.home_outlined,
                      backgroundColor: BrutalistColors.cardBackground,
                      foregroundColor: BrutalistColors.cardText,
                      onPressed:
                          onBackHome ??
                          () => context.goDiscoveryTab(AppRoutes.home),
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

  static List<Player> _sortedRanking(List<Player> players) {
    final ranking = [...players]
      ..sort((left, right) {
        final scoreCompare = right.totalScore.compareTo(left.totalScore);
        return scoreCompare == 0
            ? left.name.compareTo(right.name)
            : scoreCompare;
      });
    return ranking;
  }
}
