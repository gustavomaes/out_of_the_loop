import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    this.language = SupportedLanguage.ptBr,
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            const OtlPartyAtmosphere.secretReveal(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, viewport) {
                  final sectionGap = viewport.maxHeight < 700 ? 24.0 : 40.0;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          children: [
                            SecretRevealInstructions(
                              l10n: l10n,
                              roundNumber: widget.round.roundNumber,
                              playerName: _activePlayer.name,
                            ),
                            SizedBox(height: sectionGap),
                            Expanded(
                              child: SecretCard(
                                revealed: _revealed,
                                topSecretLabel: l10n.secretRevealTopSecret,
                                roleText: _roleText(l10n),
                              ),
                            ),
                            SizedBox(height: sectionGap),
                            SecretRevealCta(
                              label: _ctaLabel(l10n),
                              onPressed: _revealed
                                  ? _advance
                                  : () => setState(() => _revealed = true),
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
      return l10n.secretRevealStartQuestions;
    }
    return l10n.secretRevealNextPlayer;
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
