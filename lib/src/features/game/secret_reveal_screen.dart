import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/secret_card.dart';
import 'widgets/secret_reveal_cta.dart';
import 'widgets/secret_reveal_instructions.dart';

class SecretRevealScreen extends StatefulWidget {
  const SecretRevealScreen({
    required this.players,
    required this.round,
    this.language = SupportedLanguage.en,
    this.onComplete,
    this.onBack,
    this.onSettings,
    super.key,
  });

  final List<Player> players;
  final RoundState round;
  final SupportedLanguage language;
  final VoidCallback? onComplete;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  @override
  State<SecretRevealScreen> createState() => _SecretRevealScreenState();
}

class _SecretRevealScreenState extends State<SecretRevealScreen> {
  var _activeIndex = 0;
  var _revealed = false;

  Player get _activePlayer => widget.players[_activeIndex];
  bool get _isOutPlayer => _activePlayer.id == widget.round.outPlayerId;
  bool get _isLastPlayer => _activeIndex == widget.players.length - 1;

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
          onSettings: widget.onSettings,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const OtlPartyAtmosphere.secretReveal(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, viewport) {
                  final compact = viewport.maxHeight < 700;
                  final sectionGap = compact ? 24.0 : 40.0;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, area) {
                                  return SingleChildScrollView(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minHeight: area.maxHeight,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SecretRevealInstructions(
                                            l10n: l10n,
                                            roundNumber:
                                                widget.round.roundNumber,
                                            playerName: _activePlayer.name,
                                          ),
                                          SizedBox(
                                            height: compact ? 16 : sectionGap,
                                          ),
                                          SecretCard(
                                            revealed: _revealed,
                                            topSecretLabel:
                                                l10n.secretRevealTopSecret,
                                            roleText: _roleText(l10n),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: sectionGap),
                            SecretRevealCta(
                              label: _ctaLabel(l10n),
                              onPressed: _revealed
                                  ? _advance
                                  : () => unawaited(_confirmAndReveal()),
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

  String _roleText(AppLocalizations l10n) {
    if (_isOutPlayer) {
      return l10n.outOfLoopMessage;
    }
    return widget.round.secretWord.value.valueFor(widget.language);
  }

  String _ctaLabel(AppLocalizations l10n) {
    if (!_revealed) {
      return l10n.revealMyWord;
    }
    if (_isLastPlayer) {
      return l10n.secretRevealFinished;
    }
    return l10n.secretRevealNextPlayer;
  }

  Future<void> _confirmAndReveal() async {
    final confirmed = await showSecretRevealConfirmDialog(
      context,
      playerName: _activePlayer.name,
    );
    if (!confirmed || !mounted) {
      return;
    }
    setState(() => _revealed = true);
  }

  void _advance() {
    if (_isLastPlayer) {
      widget.onComplete?.call();
      return;
    }
    setState(() {
      _activeIndex += 1;
      _revealed = false;
    });
  }
}
