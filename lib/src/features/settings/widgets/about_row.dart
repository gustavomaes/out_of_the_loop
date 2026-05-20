import 'package:flutter/material.dart';

import '../../../shared/sound/sound_effects_scope.dart';
import '../../../theme/theme.dart';

class AboutRow extends StatelessWidget {
  const AboutRow({
    required this.label,
    this.trailing,
    this.onTap,
    this.showChevron = false,
    super.key,
  });

  final String label;
  final String? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: DisplayTypography.plusJakartaBody(
                color: BrutalistColors.cardText,
              ),
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: DisplayTypography.spaceGroteskMeta(
                color: BrutalistColors.versionGreen,
              ),
            )
          else if (showChevron)
            const Icon(
              Icons.chevron_right,
              color: BrutalistColors.cardText,
              size: 20,
            ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return InkWell(onTap: otlTap(context, onTap), child: content);
  }
}
