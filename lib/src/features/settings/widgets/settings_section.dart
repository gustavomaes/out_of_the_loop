import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: DisplayTypography.spaceGroteskSectionLabel(
            color: BrutalistColors.sectionLabel,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
