import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class RevealedRole extends StatelessWidget {
  const RevealedRole({required this.roleText, super.key});

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
