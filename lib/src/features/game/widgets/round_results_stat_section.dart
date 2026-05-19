import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class RoundResultsStatSection extends StatelessWidget {
  const RoundResultsStatSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: DisplayTypography.spaceGroteskResultsSectionLabel(
            color: BrutalistColors.sectionLabel,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}
