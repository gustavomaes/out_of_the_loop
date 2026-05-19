import 'package:flutter/material.dart';

/// Figma-aligned neubrutalist palette shared by Settings, How To, and similar screens.
abstract final class BrutalistColors {
  static const screenBackground = Color(0xFF111125);
  static const headerBackground = Color(0xFF111125);
  static const headerBorder = Color(0xFF333348);
  static const cardBackground = Color(0xFF1E1E32);
  static const cardText = Color(0xFFE2E0FC);
  static const sectionLabel = Color(0xFFC2CAAD);
  static const lime = Color(0xFFB7F700);
  static const limeText = Color(0xFF141F00);
  static const versionGreen = Color(0xFFA0D800);
  static const toggleOff = Color(0xFF333348);
}

abstract final class BrutalistScreenTheme {
  static Widget wrap(BuildContext context, Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: BrutalistColors.screenBackground,
        canvasColor: BrutalistColors.screenBackground,
      ),
      child: child,
    );
  }
}
