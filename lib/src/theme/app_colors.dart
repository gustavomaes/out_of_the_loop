import 'package:flutter/material.dart';

/// Neon refined palette shared by every route.
abstract final class AppColors {
  static const backgroundPrimary = Color(0xFF191323);
  static const backgroundSecondary = Color(0xFF241B32);
  static const backgroundTertiary = Color(0xFF2C223F);

  static const primaryMain = Color(0xFFCAFF36);
  static const primaryLight = Color(0xFFE2FF7A);
  static const primaryDark = Color(0xFF8FC71F);

  static const secondaryMain = Color(0xFFFF58BC);
  static const secondaryLight = Color(0xFFFF78F7);
  static const secondaryDark = Color(0xFFC218B7);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB6ACCB);
  static const textTertiary = Color(0xFFA396B8);
  static const textDisabled = Color(0xFF766B87);

  static const success = Color(0xFF59E88B);
  static const error = Color(0xFFFF4D6D);
  static const warning = Color(0xFFFFC857);
  static const info = Color(0xFF5AA9FF);

  static const borderDefault = Color(0xFF49395E);
  static const borderStrong = Color(0xFF75618E);
  static const borderFocus = Color(0xFFCAFF36);

  static const overlayDark = Color(0x99000000);
  static const overlayGlow = Color(0x33CAFF36);
  static const overlayGlowStrong = Color(0x66CAFF36);
  static const overlayMagentaGlow = Color(0x33FF58BC);
}

/// Compatibility names for the shared Neon refined palette.
abstract final class BrutalistColors {
  static const screenBackground = Color(0xFF191323);
  static const headerBackground = Color(0xFF191323);
  static const headerBorder = Color(0xFF49395E);
  static const cardBackground = Color(0xFF2C223F);
  static const cardText = Color(0xFFF7F4FF);
  static const sectionLabel = Color(0xFFB6ACCB);
  static const lime = Color(0xFFCAFF36);
  static const limeText = Color(0xFF22182E);
  static const homePrimaryButtonText = Color(0xFF22182E);
  static const homeSecondaryButton = Color(0xFF2C223F);
  static const versionGreen = Color(0xFFCAFF36);
  static const toggleOff = Color(0xFF49395E);
  static const playerCountBadgeBackground = Color(0xFF3B2847);
  static const playerCountBadgeText = Color(0xFFF7F4FF);

  /// Player turn chip and voting vote-button label (Figma).
  static const turnChipText = Color(0xFF22182E);
  static const playerCardPink = Color(0xFFFF58BC);
  static const playerCardYellow = Color(0xFFFFE170);
  static const playerCardGreen = Color(0xFFCAFF36);
  static const playerAvatarFrame = Color(0xFF49395E);
  static const inputHint = Color(0xFFA396B8);
  static const footerScrim = Color(0xCC191323);

  /// Soft peach accent for voting-screen radial gradient (Figma).
  static const votingAtmosphereAccent = Color(0xFFFFB4AB);

  /// Self-voter card background on voting screen (Figma).
  static const votingCardSelfBackground = Color(0xFF241B32);

  /// Inset highlight on voting player avatars.
  static const votingAvatarInsetShadow = Color(0x33000000);

  /// How-to-play rule card accents (Figma).
  static const howToPlayYellowText = Color(0xFF221B00);
  static const howToPlayCyan = Color(0xFF00E5FF);

  /// Final leaderboard decorative / rank accents.
  static const resultsWinnerStar = Color(0xFF8FBF00);
  static const resultsOutPlayerName = Color(0xFFFFB4AB);

  /// Settings audio row icon tints (Figma).
  static const settingsMusicIcon = Color(0xFFFF58BC);
  static const settingsSfxIcon = Color(0xFFFFE170);
}
