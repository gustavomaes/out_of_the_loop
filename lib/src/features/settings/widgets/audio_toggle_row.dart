import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

class AudioToggleRow extends StatelessWidget {
  const AudioToggleRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(24),
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              label,
              style: DisplayTypography.rubikSettingLabel(
                color: BrutalistColors.cardText,
              ),
            ),
          ),
          OtlBrutalistToggle(value: value),
        ],
      ),
    );
  }
}
