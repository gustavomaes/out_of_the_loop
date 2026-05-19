import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

class QuestionRoundScreen extends StatefulWidget {
  const QuestionRoundScreen({
    required this.players,
    required this.questionTurns,
    this.language = SupportedLanguage.ptBr,
    this.timerSettings = const TimerSettings(),
    this.remainingSeconds,
    this.onComplete,
    this.onBack,
    this.onSettings,
    super.key,
  });

  final List<Player> players;
  final List<QuestionTurn> questionTurns;
  final SupportedLanguage language;
  final TimerSettings timerSettings;
  final int? remainingSeconds;
  final VoidCallback? onComplete;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  @override
  State<QuestionRoundScreen> createState() => _QuestionRoundScreenState();
}

class _QuestionRoundScreenState extends State<QuestionRoundScreen> {
  var _turnIndex = 0;
  var _awaitingNextQuestion = false;

  bool get _isLastTurn => _turnIndex == widget.questionTurns.length - 1;

  QuestionTurn get _currentTurn => widget.questionTurns[_turnIndex];

  Player get _currentPlayer => widget.players.firstWhere(
    (player) => player.id == _currentTurn.playerId,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final remainingSeconds =
        widget.remainingSeconds ?? widget.timerSettings.durationSeconds;
    final timerExpired = widget.timerSettings.enabled && remainingSeconds == 0;

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
            const _QuestionRoundAtmosphere(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, viewport) {
                  final compact = viewport.maxHeight < 700;
                  final sectionGap = compact ? 20.0 : 28.0;

                  final cardMinHeight = (viewport.maxHeight * 0.38).clamp(
                    160.0,
                    300.0,
                  );

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _PlayerTurnChip(
                                      label: l10n.questionRoundPlayerTurn(
                                        _currentPlayer.name,
                                      ),
                                    ),
                                    SizedBox(height: sectionGap),
                                    SizedBox(
                                      height: cardMinHeight,
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 280,
                                        ),
                                        switchInCurve: Curves.easeOutCubic,
                                        switchOutCurve: Curves.easeInCubic,
                                        transitionBuilder: (child, animation) {
                                          final offsetAnimation =
                                              Tween<Offset>(
                                                begin: const Offset(0.1, 0),
                                                end: Offset.zero,
                                              ).animate(
                                                CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.easeOutCubic,
                                                ),
                                              );

                                          return FadeTransition(
                                            opacity: animation,
                                            child: SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: _QuestionCard(
                                          key: ValueKey('turn-$_turnIndex'),
                                          questionText: _currentTurn
                                              .question
                                              .text
                                              .valueFor(widget.language)
                                              .toUpperCase(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: sectionGap),
                                    _SpeakUpPrompt(
                                      title: l10n.questionRoundSpeakUp,
                                      line1: l10n.questionRoundSpeakUpLine1,
                                      line2: l10n.questionRoundSpeakUpLine2,
                                    ),
                                    if (widget.timerSettings.enabled) ...[
                                      SizedBox(height: compact ? 16 : 20),
                                      _QuestionRoundTimer(
                                        timeRemainingLabel:
                                            l10n.questionRoundTimeRemaining,
                                        secondsLabel:
                                            l10n.questionRoundTimeSeconds(
                                          remainingSeconds,
                                        ),
                                        remainingSeconds: remainingSeconds,
                                        totalSeconds: widget
                                            .timerSettings
                                            .durationSeconds,
                                      ),
                                      if (timerExpired) ...[
                                        const SizedBox(height: 12),
                                        _TimerExpiredMessage(
                                          line1: l10n
                                              .questionRoundTimerExpiredLine1,
                                          line2: l10n
                                              .questionRoundTimerExpiredLine2,
                                        ),
                                      ],
                                    ],
                                    SizedBox(height: compact ? 16 : 24),
                                  ],
                                ),
                              ),
                            ),
                            _QuestionRoundCta(
                              label: _primaryButtonLabel(l10n),
                              onPressed: _onPrimaryPressed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _primaryButtonLabel(AppLocalizations l10n) {
    if (_awaitingNextQuestion) {
      return _isLastTurn
          ? l10n.questionRoundGoToVoting
          : l10n.questionRoundNextQuestion;
    }
    return l10n.questionRoundDoneAnswering;
  }

  void _onPrimaryPressed() {
    if (!_awaitingNextQuestion) {
      setState(() => _awaitingNextQuestion = true);
      return;
    }

    if (_isLastTurn) {
      widget.onComplete?.call();
      return;
    }

    setState(() {
      _turnIndex += 1;
      _awaitingNextQuestion = false;
    });
  }
}

class _PlayerTurnChip extends StatelessWidget {
  const _PlayerTurnChip({required this.label});

  final String label;

  static const _shadowDx = 4.0;
  static const _shadowDy = 4.0;
  static const _chipText = Color(0xFF520049);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.playerCardPink,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Text(
                label,
                style: DisplayTypography.spaceGroteskTurnChip(color: _chipText),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.questionText, super.key});

  final String questionText;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.homeSecondaryButton,
              borderRadius: BorderRadius.circular(48),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(44),
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: _QuestionCardAccent(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 36, 36, 36),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const _QuestionMarkBadge(),
                            const SizedBox(height: 24),
                            Text(
                              questionText,
                              style: DisplayTypography.rubikQuestionCard(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
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
        ],
      ),
    );
  }
}

class _QuestionCardAccent extends StatelessWidget {
  const _QuestionCardAccent();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrutalistColors.playerCardYellow,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 4),
        ),
      ),
      child: const SizedBox(height: 12, width: double.infinity),
    );
  }
}

class _QuestionMarkBadge extends StatelessWidget {
  const _QuestionMarkBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrutalistColors.playerCardYellow,
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const SizedBox(
        width: 27,
        height: 36,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _SpeakUpPrompt extends StatelessWidget {
  const _SpeakUpPrompt({
    required this.title,
    required this.line1,
    required this.line2,
  });

  final String title;
  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        children: [
          const Positioned.fill(
            child: ColoredBox(color: BrutalistColors.headerBorder),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _DashedBorderPainter(
                color: Colors.black,
                strokeWidth: 4,
                radius: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text(
                  title,
                  style: DisplayTypography.rubikSpeakUpTitle(
                    color: BrutalistColors.lime,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  line1,
                  style: DisplayTypography.plusJakartaSecretRevealBody(
                    color: BrutalistColors.sectionLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  line2,
                  style: DisplayTypography.plusJakartaSecretRevealBody(
                    color: BrutalistColors.sectionLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + 10;
        final extractPath = metric.extractPath(
          distance,
          next.clamp(0, metric.length),
        );
        canvas.drawPath(extractPath, paint);
        distance = next + 6;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius;
  }
}

class _QuestionRoundTimer extends StatelessWidget {
  const _QuestionRoundTimer({
    required this.timeRemainingLabel,
    required this.secondsLabel,
    required this.remainingSeconds,
    required this.totalSeconds,
  });

  final String timeRemainingLabel;
  final String secondsLabel;
  final int remainingSeconds;
  final int totalSeconds;

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds == 0
        ? 0.0
        : (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeRemainingLabel,
                style: DisplayTypography.spaceGroteskSectionLabel(
                  color: BrutalistColors.sectionLabel,
                ),
              ),
              Text(
                secondsLabel,
                style: DisplayTypography.spaceGroteskSectionLabel(
                  color: BrutalistColors.playerCardYellow,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 24,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.cardBackground,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: Colors.black, width: 4),
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
                      decoration: BoxDecoration(
                        color: BrutalistColors.playerCardYellow,
                        border: const Border(
                          right: BorderSide(color: Colors.black, width: 4),
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
                          Colors.black.withValues(alpha: 0.2),
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
          style: DisplayTypography.plusJakartaBody(
            color: BrutalistColors.sectionLabel,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          line2,
          style: DisplayTypography.plusJakartaBody(
            color: BrutalistColors.sectionLabel,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _QuestionRoundCta extends StatelessWidget {
  const _QuestionRoundCta({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  static const _height = 72.0;
  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: DisplayTypography.rubikQuestionRoundCta(
                          color: BrutalistColors.homePrimaryButtonText,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.check_circle_outline,
                        color: BrutalistColors.homePrimaryButtonText,
                        size: 20,
                      ),
                    ],
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

class _QuestionRoundAtmosphere extends StatelessWidget {
  const _QuestionRoundAtmosphere();

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
                  BrutalistColors.playerCardPink.withValues(alpha: 0.08),
                  BrutalistColors.screenBackground,
                ],
              ),
            ),
          ),
          Positioned(
            right: -40,
            top: 140,
            child: _glow(BrutalistColors.playerCardYellow),
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
