import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'hidden_role.dart';
import 'revealed_role.dart';
import 'secret_card_pattern.dart';

class SecretCard extends StatelessWidget {
  const SecretCard({
    required this.revealed,
    required this.topSecretLabel,
    required this.roleText,
    super.key,
  });

  final bool revealed;
  final String topSecretLabel;
  final String roleText;

  static const _shadowDx = 4.0;
  static const _shadowDy = 8.0;
  /// Fits icon + one line of text + padding; card grows when copy is longer.
  static const _minHeight = 176.0;
  static const _verticalPadding = 28.0;

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
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _minHeight),
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.cardBackground,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.black, width: 6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Positioned.fill(child: SecretCardPattern()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: _verticalPadding,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: revealed
                              ? RevealedRole(roleText: roleText)
                              : HiddenRole(topSecretLabel: topSecretLabel),
                        ),
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
