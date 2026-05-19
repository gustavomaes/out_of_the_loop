import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class SecretRevealScreen extends StatefulWidget {
  const SecretRevealScreen({
    required this.players,
    required this.round,
    this.language = SupportedLanguage.ptBr,
    this.onComplete,
    super.key,
  });

  final List<Player> players;
  final RoundState round;
  final SupportedLanguage language;
  final VoidCallback? onComplete;

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
    return AppShell(
      routeName: AppRoutes.gameReveal,
      title: 'Top Secret',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('TOP SECRET', style: AppTypography.emphasis),
          const SizedBox(height: AppSpacing.sm),
          Text('${_activePlayer.name}\'s turn', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: Center(
              child: OtlCard(
                selected: _revealed,
                child: AnimatedSwitcher(
                  duration: AppDurations.fast,
                  child: _revealed
                      ? _RevealedRole(roleText: _roleText)
                      : const _HiddenRole(),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OtlButton.primary(
            label: _revealed
                ? (_isLastPlayer ? 'START QUESTIONS' : 'NEXT PLAYER')
                : 'VIEW MY WORD',
            onPressed: _revealed
                ? _advance
                : () => setState(() => _revealed = true),
          ),
        ],
      ),
    );
  }

  String get _roleText {
    if (_isOutPlayer) {
      return 'Voce esta FORA do circulo - aja naturalmente.';
    }
    return widget.round.secretWord.value.valueFor(widget.language);
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

class _HiddenRole extends StatelessWidget {
  const _HiddenRole();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('hidden-role'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.lock_outline,
          color: AppColors.secondaryMain,
          size: 56,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Make sure nobody else is looking.',
          style: AppTypography.bodyLarge,
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
        const Icon(Icons.visibility, color: AppColors.primaryMain, size: 56),
        const SizedBox(height: AppSpacing.md),
        Text(roleText, style: AppTypography.h2, textAlign: TextAlign.center),
      ],
    );
  }
}
