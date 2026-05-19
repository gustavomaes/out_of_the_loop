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
                        const Positioned.fill(child: SecretCardPattern()),
                        Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: verticalPadding,
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: revealed
                                  ? RevealedRole(roleText: roleText)
                                  : HiddenRole(topSecretLabel: topSecretLabel),
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
