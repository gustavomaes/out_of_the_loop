import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

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
            const _SecretRevealAtmosphere(),
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
                            _SecretRevealInstructions(
                              l10n: l10n,
                              roundNumber: widget.round.roundNumber,
                              playerName: _activePlayer.name,
                            ),
                            SizedBox(height: sectionGap),
                            Expanded(
                              child: _SecretCard(
                                revealed: _revealed,
                                topSecretLabel: l10n.secretRevealTopSecret,
                                roleText: _roleText(l10n),
                              ),
                            ),
                            SizedBox(height: sectionGap),
                            _SecretRevealCta(
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

class _SecretRevealInstructions extends StatelessWidget {
  const _SecretRevealInstructions({
    required this.l10n,
    required this.roundNumber,
    required this.playerName,
  });

  final AppLocalizations l10n;
  final int roundNumber;
  final String playerName;

  static const _roundYellow = Color(0xFFFFE170);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          l10n.secretRevealRound(roundNumber),
          style: DisplayTypography.spaceGroteskRoundLabel(color: _roundYellow),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        _HeadingWithShadow(
          line1: l10n.secretRevealPassTo,
          line2: l10n.secretRevealPassToPlayer(playerName),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Column(
            children: [
              Text(
                l10n.secretRevealPrivacyLine1,
                style: DisplayTypography.plusJakartaSecretRevealBody(
                  color: BrutalistColors.sectionLabel,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                l10n.secretRevealPrivacyLine2,
                style: DisplayTypography.plusJakartaSecretRevealBody(
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

class _HeadingWithShadow extends StatelessWidget {
  const _HeadingWithShadow({required this.line1, required this.line2});

  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    final style = DisplayTypography.rubikSecretRevealHeading(
      color: Colors.white,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(2, 2),
          child: Column(
            children: [
              Text(
                line1,
                style: style.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                line2,
                style: style.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(line1, style: style, textAlign: TextAlign.center),
            Text(line2, style: style, textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}

class _SecretCard extends StatelessWidget {
  const _SecretCard({
    required this.revealed,
    required this.topSecretLabel,
    required this.roleText,
  });

  final bool revealed;
  final String topSecretLabel;
  final String roleText;

  static const _shadowDx = 4.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final verticalPadding = constraints.maxHeight < 220 ? 20.0 : 32.0;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: const Offset(_shadowDx, _shadowDy),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: constraints.maxHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: BrutalistColors.cardBackground,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.black, width: 6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Stack(
                      children: [
                        const Positioned.fill(child: _SecretCardPattern()),
                        Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: verticalPadding,
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: revealed
                                  ? _RevealedRole(roleText: roleText)
                                  : _HiddenRole(topSecretLabel: topSecretLabel),
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
        },
      ),
    );
  }
}

class _SecretCardPattern extends StatelessWidget {
  const _SecretCardPattern();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.4,
              colors: [
                Colors.white.withValues(alpha: 0.35),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HiddenRole extends StatelessWidget {
  const _HiddenRole({required this.topSecretLabel});

  final String topSecretLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('hidden-role'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.visibility_off_outlined,
          color: BrutalistColors.lime,
          size: 56,
        ),
        const SizedBox(height: 12),
        Text(
          topSecretLabel,
          style: DisplayTypography.rubikTopSecretLabel(
            color: BrutalistColors.cardText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _RevealedRole extends StatelessWidget {
  const _RevealedRole({required this.roleText});

  final String roleText;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('revealed-role'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.visibility_outlined, color: BrutalistColors.lime, size: 56),
        const SizedBox(height: 16),
        Text(
          roleText,
          style: DisplayTypography.rubikTopSecretLabel(
            color: BrutalistColors.cardText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SecretRevealCta extends StatelessWidget {
  const _SecretRevealCta({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  static const _height = 64.0;
  static const _shadowDx = 4.0;
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
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
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
                      style: DisplayTypography.rubikHomeButton(
                        color: BrutalistColors.homePrimaryButtonText,
                      ),
                      textAlign: TextAlign.center,
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

class _SecretRevealAtmosphere extends StatelessWidget {
  const _SecretRevealAtmosphere();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.1,
                colors: [
                  BrutalistColors.lime.withValues(alpha: 0.12),
                  BrutalistColors.screenBackground,
                ],
              ),
            ),
          ),
          Positioned(
            right: -48,
            top: 120,
            child: _glow(BrutalistColors.playerCardPink),
          ),
          Positioned(
            left: -48,
            bottom: 160,
            child: _glow(BrutalistColors.lime),
          ),
        ],
      ),
    );
  }

  Widget _glow(Color color) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Opacity(
        opacity: 0.2,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
