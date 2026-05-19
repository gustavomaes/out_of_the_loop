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
      children: [
        Text(
          title,
          style: DisplayTypography.rubikCategoryTitle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: DisplayTypography.plusJakartaBody(
            color: BrutalistColors.sectionLabel,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
