import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';
import 'about_divider.dart';
import 'about_row.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
    required this.termsLabel,
    required this.privacyLabel,
    required this.versionLabel,
    required this.versionValue,
    this.onTermsTap,
    this.onPrivacyTap,
    super.key,
  });

  final String termsLabel;
  final String privacyLabel;
  final String versionLabel;
  final String versionValue;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          AboutRow(
            label: termsLabel,
            onTap: onTermsTap,
            showChevron: true,
          ),
          const AboutDivider(),
          AboutRow(
            label: privacyLabel,
            onTap: onPrivacyTap,
            showChevron: true,
          ),
          const AboutDivider(),
          AboutRow(
            label: versionLabel,
            trailing: versionValue,
            showChevron: false,
          ),
        ],
      ),
    );
  }
}
