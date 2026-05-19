import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 64,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: DisplayTypography.rubikSettingLabel(
                color: BrutalistColors.cardText,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: BrutalistColors.cardText,
            size: 28,
          ),
        ],
      ),
    );
  }
}
