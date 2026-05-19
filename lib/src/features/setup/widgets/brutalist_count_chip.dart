import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class BrutalistCountChip extends StatelessWidget {
  const BrutalistCountChip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? BrutalistColors.lime
        : BrutalistColors.homeSecondaryButton;
    final textColor = selected
        ? BrutalistColors.homePrimaryButtonText
        : BrutalistColors.cardText;

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: OtlBrutalistSurface(
        backgroundColor: backgroundColor,
        shadowOffset: 4,
        onTap: enabled ? onTap : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Text(
          label,
          style: DisplayTypography.rubikHomeButton(
            color: textColor,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
