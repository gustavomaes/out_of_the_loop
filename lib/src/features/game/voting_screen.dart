import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({
    required this.players,
    this.timerSettings = const TimerSettings(),
    this.remainingSeconds,
    this.onComplete,
    VoteScoringService? scoringService,
    this.onBack,
    this.onSettings,
    super.key,
  }) : scoringService = scoringService ?? const VoteScoringService();

  final List<Player> players;
  final TimerSettings timerSettings;
  final int? remainingSeconds;
  final ValueChanged<List<Vote>>? onComplete;
  final VoteScoringService scoringService;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  static const _votingTimerAccent = Color(0xFFFFB4AB);
  static const _voteButtonText = Color(0xFF520049);

  var _voterIndex = 0;
  List<Vote> _votes = const [];

  Player get _activeVoter => widget.players[_voterIndex];
  bool get _allVotesCollected => _votes.length == widget.players.length;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final remainingSeconds =
        widget.remainingSeconds ?? widget.timerSettings.durationSeconds;
    final timerExpired = widget.timerSettings.enabled && remainingSeconds == 0;
    final votingDisabled = timerExpired || _allVotesCollected;

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(
          onBack: widget.onBack ?? () => context.pop(),
          onSettings: widget.onSettings,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const _VotingAtmosphere(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, viewport) {
                  final compact = viewport.maxHeight < 700;
                  final bottomInset = _allVotesCollected
                      ? (compact ? 100.0 : 112.0)
                      : widget.timerSettings.enabled
                      ? (compact ? 120.0 : 140.0)
                      : 24.0;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _VotingHeadline(l10n: l10n),
                                    SizedBox(height: compact ? 16 : 24),
                                    ...widget.players.asMap().entries.map(
                                      (entry) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: entry.key <
                                                  widget.players.length - 1
                                              ? 16
                                              : 0,
                                        ),
                                        child: _VotingPlayerCard(
                                          player: entry.value,
                                          index: entry.key,
                                          isSelf:
                                              entry.value.id ==
                                              _activeVoter.id,
                                          voteLabel: l10n.votingVote,
                                          youLabel: l10n.votingYou,
                                          cannotVoteSelfLabel:
                                              l10n.votingCannotVoteSelf,
                                          onVote: votingDisabled
                                              ? null
                                              : () => _recordVote(
                                                  entry.value.id,
                                                ),
                                        ),
                                      ),
                                    ),
                                    if (timerExpired && !_allVotesCollected)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                        ),
                                        child: _TimerExpiredMessage(
                                          line1: l10n.votingTimerExpiredLine1,
                                          line2: l10n.votingTimerExpiredLine2,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (_allVotesCollected)
                              _VotingConfirmCta(
                                label: l10n.confirmVotes,
                                onPressed: () =>
                                    widget.onComplete?.call(_votes),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.timerSettings.enabled && !_allVotesCollected)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _VotingTimerDock(
                  timeToVoteLabel: l10n.votingTimeToVote,
                  secondsLabel: l10n.votingTimeSeconds(remainingSeconds),
                  remainingSeconds: remainingSeconds,
                  totalSeconds: widget.timerSettings.durationSeconds,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _recordVote(String suspectId) {
    if (_allVotesCollected) {
      return;
    }

    final vote = Vote(voterId: _activeVoter.id, suspectId: suspectId);
    final nextVotes = widget.scoringService.recordVote(
      existingVotes: _votes,
      vote: vote,
    );
    setState(() {
      _votes = nextVotes;
      if (_voterIndex < widget.players.length - 1) {
        _voterIndex += 1;
      }
    });
  }
}

Color _votingAvatarColorForIndex(int index) {
  const colors = [
    BrutalistColors.lime,
    BrutalistColors.playerCardYellow,
    Color(0xFFFFB4AB),
  ];
  return colors[index % colors.length];
}

class _VotingHeadline extends StatelessWidget {
  const _VotingHeadline({required this.l10n});

  final AppLocalizations l10n;

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
                text: l10n.votingHeadlineWhoIs,
                style: DisplayTypography.rubikVotingHeadlineAccent(
                  color: _accentGreen,
                ),
                shadowOffset: const Offset(4, 4),
              ),
              _ShadowedText(
                text: l10n.votingHeadlineOutOf,
                style: DisplayTypography.rubikVotingHeadlineMain(
                  color: Colors.white,
                ),
                shadowOffset: const Offset(2, 2),
              ),
              _ShadowedText(
                text: l10n.votingHeadlineTheLoop,
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
          constraints: const BoxConstraints(maxWidth: 280),
          child: Column(
            children: [
              Text(
                l10n.votingSubtitleLine1,
                style: DisplayTypography.plusJakartaVotingSubtitle(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                l10n.votingSubtitleLine2,
                style: DisplayTypography.plusJakartaVotingSubtitle(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                l10n.votingSubtitleLine3,
                style: DisplayTypography.plusJakartaVotingSubtitle(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
            ],
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

class _VotingPlayerCard extends StatelessWidget {
  const _VotingPlayerCard({
    required this.player,
    required this.index,
    required this.isSelf,
    required this.voteLabel,
    required this.youLabel,
    required this.cannotVoteSelfLabel,
    required this.onVote,
  });

  final Player player;
  final int index;
  final bool isSelf;
  final String voteLabel;
  final String youLabel;
  final String cannotVoteSelfLabel;
  final VoidCallback? onVote;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    final avatarColor = isSelf
        ? BrutalistColors.headerBorder
        : _votingAvatarColorForIndex(index);

    return Opacity(
      opacity: isSelf ? 0.8 : 1,
      child: Padding(
        padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!isSelf)
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
                color: isSelf
                    ? const Color(0xFF1A1A2E)
                    : BrutalistColors.cardBackground,
                border: Border.all(
                  color: isSelf ? BrutalistColors.headerBorder : Colors.black,
                  width: 4,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _VotingAvatar(
                      name: player.name,
                      seed: player.avatarSeed,
                      backgroundColor: avatarColor,
                      dimmed: isSelf,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSelf ? youLabel : player.name,
                            style: DisplayTypography.plusJakartaVotingPlayerName(
                              color: isSelf
                                  ? BrutalistColors.sectionLabel
                                  : Colors.white,
                            ),
                          ),
                          if (isSelf) ...[
                            const SizedBox(height: 2),
                            Text(
                              cannotVoteSelfLabel,
                              style: DisplayTypography.spaceGroteskVotingSelfHint(
                                color: BrutalistColors.cardText,
                              ).copyWith(
                                color: BrutalistColors.cardText.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    _VotingActionButton(
                      label: voteLabel,
                      enabled: !isSelf && onVote != null,
                      onPressed: onVote,
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

class _VotingAvatar extends StatelessWidget {
  const _VotingAvatar({
    required this.name,
    required this.seed,
    required this.backgroundColor,
    required this.dimmed,
  });

  final String name;
  final String seed;
  final Color backgroundColor;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: dimmed ? BrutalistColors.headerBorder : Colors.black,
          width: 4,
        ),
        boxShadow: dimmed
            ? null
            : const [
                BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(0, -4),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: PlayerAvatar(name: name, seed: seed, size: 48),
      ),
    );
  }
}

class _VotingActionButton extends StatelessWidget {
  const _VotingActionButton({
    required this.label,
    required this.enabled,
    this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  static const _shadowDx = 4.0;
  static const _shadowDy = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (enabled)
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
          SizedBox(
            width: 100,
            height: 56,
            child: Material(
              color: enabled
                  ? BrutalistColors.playerCardPink
                  : BrutalistColors.headerBorder.withValues(alpha: 0.3),
              child: InkWell(
                onTap: enabled ? onPressed : null,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: enabled
                          ? Colors.black
                          : BrutalistColors.headerBorder,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: DisplayTypography.rubikVotingButton(
                        color: enabled
                            ? _VotingScreenState._voteButtonText
                            : BrutalistColors.sectionLabel,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VotingTimerDock extends StatelessWidget {
  const _VotingTimerDock({
    required this.timeToVoteLabel,
    required this.secondsLabel,
    required this.remainingSeconds,
    required this.totalSeconds,
  });

  final String timeToVoteLabel;
  final String secondsLabel;
  final int remainingSeconds;
  final int totalSeconds;

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds == 0
        ? 0.0
        : (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrutalistColors.homeSecondaryButton,
        border: const Border(top: BorderSide(color: Colors.black, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            offset: const Offset(0, -8),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: BrutalistColors.sectionLabel,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timeToVoteLabel,
                            style: DisplayTypography.spaceGroteskSectionLabel(
                              color: BrutalistColors.sectionLabel,
                            ),
                          ),
                        ],
                      ),
                      _ShadowedText(
                        text: secondsLabel,
                        style: DisplayTypography.rubikVotingTimerSeconds(
                          color: _VotingScreenState._votingTimerAccent,
                        ),
                        shadowOffset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 16,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: BrutalistColors.screenBackground,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: _VotingScreenState._votingTimerAccent,
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 4,
                                    color: Colors.white.withValues(alpha: 0.3),
                                  ),
                                ),
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.5),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VotingConfirmCta extends StatelessWidget {
  const _VotingConfirmCta({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  static const _height = 72.0;
  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowDx, _shadowDy),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height,
            width: double.infinity,
            child: Material(
              color: BrutalistColors.lime,
              child: InkWell(
                onTap: onPressed,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: DisplayTypography.rubikQuestionRoundCta(
                        color: BrutalistColors.homePrimaryButtonText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerExpiredMessage extends StatelessWidget {
  const _TimerExpiredMessage({required this.line1, required this.line2});

  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          line1,
          style: DisplayTypography.plusJakartaVotingSubtitle(
            color: BrutalistColors.sectionLabel,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          line2,
          style: DisplayTypography.plusJakartaVotingSubtitle(
            color: BrutalistColors.sectionLabel,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _VotingAtmosphere extends StatelessWidget {
  const _VotingAtmosphere();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  const Color(0xFFFFB4AB).withValues(alpha: 0.08),
                  BrutalistColors.screenBackground,
                ],
              ),
            ),
          ),
          Positioned(
            left: -40,
            top: 120,
            child: _glow(BrutalistColors.playerCardPink),
          ),
        ],
      ),
    );
  }

  Widget _glow(Color color) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
      child: Opacity(
        opacity: 0.18,
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
