import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/player_turn_chip.dart';
import 'widgets/question_card.dart';
import 'widgets/question_round_cta.dart';
import 'widgets/speak_up_prompt.dart';

class QuestionRoundScreen extends StatefulWidget {
  const QuestionRoundScreen({
    required this.players,
    required this.questionTurns,
    this.language = SupportedLanguage.en,
    this.onComplete,
    this.onBack,
    super.key,
  });

  final List<Player> players;
  final List<QuestionTurn> questionTurns;
  final SupportedLanguage language;
  final VoidCallback? onComplete;
  final VoidCallback? onBack;

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

  Future<void> _onBackPressed() async {
    await confirmExitGameOnBack(context, onBack: widget.onBack);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            unawaited(_onBackPressed());
          }
        },
        child: Scaffold(
          appBar: OtlBrutalistDiscoveryAppBar(
            onBack: _onBackPressed,
            showSettings: false,
          ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const OtlPartyAtmosphere.questionRound(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, viewport) {
                  final compact = viewport.maxHeight < 700;
                  final sectionGap = compact ? 20.0 : 28.0;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PlayerTurnChip(
                                      label: l10n.questionRoundPlayerTurn(
                                        _currentPlayer.name,
                                      ),
                                    ),
                                    SizedBox(height: sectionGap),
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 280,
                                      ),
                                      switchInCurve: Curves.easeOutCubic,
                                      switchOutCurve: Curves.easeInCubic,
                                      transitionBuilder: (child, animation) {
                                        final offsetAnimation = Tween<Offset>(
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
                                      child: QuestionCard(
                                        key: ValueKey('turn-$_turnIndex'),
                                        questionText: _currentTurn.question.text
                                            .valueFor(widget.language)
                                            .toUpperCase(),
                                      ),
                                    ),
                                    SizedBox(height: sectionGap),
                                    SpeakUpPrompt(
                                      title: l10n.questionRoundSpeakUp,
                                      line1: l10n.questionRoundSpeakUpLine1,
                                      line2: l10n.questionRoundSpeakUpLine2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            QuestionRoundCta(
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
