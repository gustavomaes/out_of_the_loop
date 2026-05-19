import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class HiddenRole extends StatelessWidget {
  const HiddenRole({required this.topSecretLabel, super.key});

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
