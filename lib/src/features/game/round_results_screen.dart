import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_routes.dart';
import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/otl_brutalist_discovery_app_bar.dart';
import '../../shared/widgets/otl_brutalist_pill_button.dart';
import '../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../shared/widgets/player_avatar.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

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
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(onBack: () => context.pop()),
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
                    _RoundResultsHeadline(
                      accentLabel: l10n.roundResultsHeadlineAccent,
                      mainLabel: l10n.roundResultsHeadlineMain,
                      outcomeMessage: outcomeMessage,
                      success: result.wasOutFoundByMajority,
                    ),
                    const SizedBox(height: 24),
                    _OutPlayerCard(
                      outPlayer: outPlayer,
                      label: l10n.roundResultsOutPlayerLabel,
                    ),
                    const SizedBox(height: 24),
                    _SecretWordReveal(
                      label: l10n.resultsSecretWordWas,
                      secretWord: secretWord,
                    ),
                    const SizedBox(height: 24),
                    _ResultsStatSection(
                      title: l10n.roundResultsVoteTotals,
                      children: [
                        for (var index = 0; index < players.length; index += 1)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: index < players.length - 1 ? 16 : 0,
                            ),
                            child: _ResultsPlayerRow(
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
                    _ResultsStatSection(
                      title: l10n.roundResultsRoundPoints,
                      children: [
                        for (var index = 0; index < players.length; index += 1)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: index < players.length - 1 ? 16 : 0,
                            ),
                            child: _ResultsPlayerRow(
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

class _RoundResultsHeadline extends StatelessWidget {
  const _RoundResultsHeadline({
    required this.accentLabel,
    required this.mainLabel,
    required this.outcomeMessage,
    required this.success,
  });

  final String accentLabel;
  final String mainLabel;
  final String outcomeMessage;
  final bool success;

  static const _accentGreen = Color(0xFFA0D800);
  static const _accentPeach = Color(0xFFFFB4AB);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              _ShadowedText(
                text: accentLabel,
                style: DisplayTypography.rubikVotingHeadlineAccent(
                  color: success ? _accentGreen : _accentPeach,
                ),
                shadowOffset: const Offset(4, 4),
              ),
              _ShadowedText(
                text: mainLabel,
                style: DisplayTypography.rubikVotingHeadlineMain(
                  color: Colors.white,
                ),
                shadowOffset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            outcomeMessage,
            style: DisplayTypography.plusJakartaVotingSubtitle(
              color: BrutalistColors.sectionLabel,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ShadowedText extends StatelessWidget {
  const _ShadowedText({
    required this.text,
    required this.style,
    required this.shadowOffset,
  });

  final String text;
  final TextStyle style;
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: shadowOffset,
          child: Text(
            text,
            style: style.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Text(text, style: style, textAlign: TextAlign.center),
      ],
    );
  }
}

class _OutPlayerCard extends StatelessWidget {
  const _OutPlayerCard({required this.outPlayer, required this.label});

  final Player outPlayer;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.playerCardPink,
      child: Padding(
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
                    color: const Color(0xFFFFB4AB),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: PlayerAvatar(
                    name: outPlayer.name,
                    seed: outPlayer.avatarSeed,
                    size: 88,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                  label,
                  style: DisplayTypography.spaceGroteskResultsBadge(
                    color: BrutalistColors.lime,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              outPlayer.name,
              style: DisplayTypography.rubikResultsWinnerTitle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SecretWordReveal extends StatelessWidget {
  const _SecretWordReveal({required this.label, required this.secretWord});

  final String label;
  final String secretWord;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.homeSecondaryButton,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              label,
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
          ],
        ),
      ),
    );
  }
}

class _ResultsStatSection extends StatelessWidget {
  const _ResultsStatSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: DisplayTypography.spaceGroteskResultsSectionLabel(
            color: BrutalistColors.sectionLabel,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

Color _resultsAvatarColorForIndex(int index) {
  const colors = [
    BrutalistColors.lime,
    BrutalistColors.playerCardYellow,
    const Color(0xFFFFB4AB),
  ];
  return colors[index % colors.length];
}

class _ResultsPlayerRow extends StatelessWidget {
  const _ResultsPlayerRow({
    required this.player,
    required this.index,
    required this.value,
    required this.highlight,
    this.valueColor,
  });

  final Player player;
  final int index;
  final String value;
  final bool highlight;
  final Color? valueColor;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    final nameColor = highlight ? const Color(0xFFFFB4AB) : Colors.white;
    final resolvedValueColor =
        valueColor ??
        (highlight ? BrutalistColors.lime : BrutalistColors.sectionLabel);
    final avatarColor = highlight
        ? const Color(0xFFFFB4AB)
        : _resultsAvatarColorForIndex(index);

    return Opacity(
      opacity: highlight ? 1 : 0.95,
      child: Padding(
        padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Transform.translate(
                offset: const Offset(_shadowDx, _shadowDy),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: BrutalistColors.cardBackground,
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _ResultsAvatar(
                      name: player.name,
                      seed: player.avatarSeed,
                      backgroundColor: avatarColor,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Text(
                        player.name,
                        style: DisplayTypography.plusJakartaVotingPlayerName(
                          color: nameColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      value,
                      style: DisplayTypography.rubikVotingTimerSeconds(
                        color: resolvedValueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultsAvatar extends StatelessWidget {
  const _ResultsAvatar({
    required this.name,
    required this.seed,
    required this.backgroundColor,
  });

  final String name;
  final String seed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: PlayerAvatar(name: name, seed: seed, size: 48),
      ),
    );
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
                            _GuessHeadline(
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
                            _GuessOutPlayerCard(
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

class _GuessHeadline extends StatelessWidget {
  const _GuessHeadline({
    required this.accentLabel,
    required this.mainLabel,
    required this.playerTurnLabel,
    required this.instructionLines,
  });

  final String accentLabel;
  final String mainLabel;
  final String playerTurnLabel;
  final List<String> instructionLines;

  static const _accentGreen = Color(0xFFA0D800);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              _ShadowedText(
                text: accentLabel,
                style: DisplayTypography.rubikVotingHeadlineAccent(
                  color: _accentGreen,
                ),
                shadowOffset: const Offset(4, 4),
              ),
              _ShadowedText(
                text: mainLabel,
                style: DisplayTypography.rubikVotingHeadlineMain(
                  color: Colors.white,
                ),
                shadowOffset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          playerTurnLabel,
          style: DisplayTypography.rubikSpeakUpTitle(
            color: const Color(0xFFFFB4AB),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        OtlBrutalistShadowCard(
          color: BrutalistColors.homeSecondaryButton,
          borderRadius: 32,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                for (final line in instructionLines)
                  Text(
                    line,
                    style: DisplayTypography.plusJakartaVotingSubtitle(
                      color: BrutalistColors.sectionLabel,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GuessOutPlayerCard extends StatelessWidget {
  const _GuessOutPlayerCard({required this.outPlayer, required this.label});

  final Player outPlayer;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.playerCardPink,
      child: Padding(
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
                    color: const Color(0xFFFFB4AB),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: PlayerAvatar(
                    name: outPlayer.name,
                    seed: outPlayer.avatarSeed,
                    size: 88,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                  label,
                  style: DisplayTypography.spaceGroteskResultsBadge(
                    color: BrutalistColors.lime,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              outPlayer.name,
              style: DisplayTypography.rubikResultsWinnerTitle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Player _playerById(List<Player> players, String playerId) {
  return players.firstWhere((player) => player.id == playerId);
}
