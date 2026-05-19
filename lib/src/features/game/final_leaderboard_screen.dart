import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../app/discovery_shell.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_discovery_app_bar.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../shared/widgets/player_avatar.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

class FinalLeaderboardScreen extends StatelessWidget {
  const FinalLeaderboardScreen({
    required this.players,
    this.secretWord,
    this.outPlayer,
    this.language = SupportedLanguage.ptBr,
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
        appBar: OtlBrutalistDiscoveryAppBar(
          onBack:
              onBackHome ?? () => context.goDiscoveryTab(AppRoutes.home),
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
                      _WinnerCard(
                        winner: winner,
                        winsLabel: l10n.resultsWinnerWins(winner.name),
                        mastermindLabel: l10n.resultsTheMastermind,
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (secretWordLabel != null && secretWordLabel.isNotEmpty)
                      _RevealSection(
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
                        child: _LeaderboardRow(
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

class _WinnerCard extends StatelessWidget {
  const _WinnerCard({
    required this.winner,
    required this.winsLabel,
    required this.mastermindLabel,
  });

  final Player winner;
  final String winsLabel;
  final String mastermindLabel;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.lime,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: -8,
            top: -8,
            child: Opacity(
              opacity: 0.35,
              child: Icon(
                Icons.star,
                color: Color(0xFF8FBF00),
                size: 48,
              ),
            ),
          ),
          const Positioned(
            right: -8,
            bottom: -16,
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.emoji_events,
                color: Color(0xFFFFE170),
                size: 56,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: BrutalistColors.cardBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: BrutalistColors.playerCardPink,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: PlayerAvatar(
                        name: winner.name,
                        seed: winner.avatarSeed,
                        size: 88,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  winsLabel,
                  style: DisplayTypography.rubikResultsWinnerTitle(
                    color: BrutalistColors.limeText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    child: Text(
                      mastermindLabel,
                      style: DisplayTypography.spaceGroteskResultsBadge(
                        color: BrutalistColors.lime,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RevealSection extends StatelessWidget {
  const _RevealSection({
    required this.secretWordLabel,
    required this.secretWord,
    required this.outPlayerLabel,
  });

  final String secretWordLabel;
  final String secretWord;
  final String? outPlayerLabel;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.homeSecondaryButton,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              secretWordLabel,
              style: DisplayTypography.plusJakartaResultsRevealLabel(
                color: BrutalistColors.sectionLabel,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              secretWord.toUpperCase(),
              style: DisplayTypography.rubikResultsSecretWord(
                color: BrutalistColors.playerCountBadgeBackground,
              ),
              textAlign: TextAlign.center,
            ),
            if (outPlayerLabel != null) ...[
              const SizedBox(height: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.cardBackground,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    outPlayerLabel!,
                    style: DisplayTypography.plusJakartaResultsRevealBody(
                      color: BrutalistColors.cardText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({
    required this.rank,
    required this.player,
    required this.isOutPlayer,
  });

  final int rank;
  final Player player;
  final bool isOutPlayer;

  @override
  Widget build(BuildContext context) {
    final isFirst = rank == 1;
    final rankColor = isFirst
        ? const Color(0xFFFFE170)
        : BrutalistColors.sectionLabel;
    final nameColor = isOutPlayer
        ? const Color(0xFFFFB4AB)
        : BrutalistColors.cardText;
    final scoreColor = isFirst
        ? BrutalistColors.lime
        : isOutPlayer
        ? BrutalistColors.sectionLabel
        : BrutalistColors.cardText;

    return Opacity(
      opacity: isOutPlayer && !isFirst ? 0.75 : 1,
      child: OtlBrutalistShadowCard(
        color: BrutalistColors.cardBackground,
        borderRadius: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Text(
                  '$rank',
                  style: DisplayTypography.rubikResultsRank(
                    color: rankColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _LeaderboardAvatar(
                rank: rank,
                name: player.name,
                seed: player.avatarSeed,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  player.name,
                  style: DisplayTypography.rubikResultsPlayerName(
                    color: nameColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${player.totalScore}',
                style: DisplayTypography.rubikResultsScore(
                  color: scoreColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaderboardAvatar extends StatelessWidget {
  const _LeaderboardAvatar({
    required this.rank,
    required this.name,
    required this.seed,
  });

  final int rank;
  final String name;
  final String seed;

  @override
  Widget build(BuildContext context) {
    final frameColor = switch (rank) {
      1 => BrutalistColors.playerCountBadgeBackground,
      2 => BrutalistColors.playerCardYellow,
      _ => BrutalistColors.headerBorder,
    };
    final fillColor = switch (rank) {
      1 => BrutalistColors.lime,
      2 => BrutalistColors.playerCardYellow,
      _ => BrutalistColors.headerBorder,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: frameColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: fillColor,
            shape: BoxShape.circle,
          ),
          child: PlayerAvatar(name: name, seed: seed, size: 36),
        ),
      ),
    );
  }
}
