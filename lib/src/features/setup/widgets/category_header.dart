import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

/// Title block for category selection.
class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: DisplayTypography.rubikTitle(
            color: BrutalistColors.cardText,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: DisplayTypography.plusJakartaBody(
            color: BrutalistColors.sectionLabel,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
