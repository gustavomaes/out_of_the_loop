import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'hidden_role.dart';
import 'revealed_role.dart';

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
  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: double.infinity,
    constraints: const BoxConstraints(minHeight: 210),
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: BrutalistColors.cardBackground,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: revealed ? BrutalistColors.lime : BrutalistColors.headerBorder,
        width: revealed ? 2 : 1,
      ),
    ),
    child: Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: revealed
            ? RevealedRole(roleText: roleText)
            : HiddenRole(topSecretLabel: topSecretLabel),
      ),
    ),
  );
}
