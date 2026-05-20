import 'package:flutter/material.dart';

/// Legacy app palette (Poppins shell, forms).
abstract final class AppColors {
  static const backgroundPrimary = Color(0xFF070718);
  static const backgroundSecondary = Color(0xFF12122E);
  static const backgroundTertiary = Color(0xFF1D1D43);

  static const primaryMain = Color(0xFFC8FF2E);
  static const primaryLight = Color(0xFFE2FF7A);
  static const primaryDark = Color(0xFF8FC71F);

  static const secondaryMain = Color(0xFFFF3DF2);
  static const secondaryLight = Color(0xFFFF78F7);
  static const secondaryDark = Color(0xFFC218B7);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFC8CCE5);
  static const textTertiary = Color(0xFF858AAF);
  static const textDisabled = Color(0xFF4E5273);

  static const success = Color(0xFF59E88B);
  static const error = Color(0xFFFF4D6D);
  static const warning = Color(0xFFFFC857);
  static const info = Color(0xFF5AA9FF);

  static const borderDefault = Color(0xFF30345F);
  static const borderStrong = Color(0xFF626993);
  static const borderFocus = Color(0xFFC8FF2E);

  static const overlayDark = Color(0x99000000);
  static const overlayGlow = Color(0x33C8FF2E);
  static const overlayGlowStrong = Color(0x66C8FF2E);
  static const overlayMagentaGlow = Color(0x33FF3DF2);
}

/// Figma-aligned neubrutalist palette (discovery, setup, game screens).
abstract final class BrutalistColors {
  static const screenBackground = Color(0xFF111125);
  static const headerBackground = Color(0xFF111125);
  static const headerBorder = Color(0xFF333348);
  static const cardBackground = Color(0xFF1E1E32);
  static const cardText = Color(0xFFE2E0FC);
  static const sectionLabel = Color(0xFFC2CAAD);
  static const lime = Color(0xFFB7F700);
  static const limeText = Color(0xFF141F00);
  static const homePrimaryButtonText = Color(0xFF506E00);
  static const homeSecondaryButton = Color(0xFF28283D);
  static const versionGreen = Color(0xFFA0D800);
  static const toggleOff = Color(0xFF333348);
  static const playerCountBadgeBackground = Color(0xFFFFACE8);
  static const playerCountBadgeText = Color(0xFF5E0053);

  /// Player turn chip and voting vote-button label (Figma).
  static const turnChipText = Color(0xFF520049);
  static const playerCardPink = Color(0xFFFF24E4);
  static const playerCardYellow = Color(0xFFFFE170);
  static const playerCardGreen = Color(0xFFA0D800);
  static const playerAvatarFrame = Color(0xFF37374D);
  static const inputHint = Color(0xFF6B7280);
  static const footerScrim = Color(0xCC111125);

  /// Soft peach accent for voting-screen radial gradient (Figma).
  static const votingAtmosphereAccent = Color(0xFFFFB4AB);

  /// Self-voter card background on voting screen (Figma).
  static const votingCardSelfBackground = Color(0xFF1A1A2E);

  /// Inset highlight on voting player avatars.
  static const votingAvatarInsetShadow = Color(0x33000000);

  /// How-to-play rule card accents (Figma).
  static const howToPlayYellowText = Color(0xFF221B00);
  static const howToPlayCyan = Color(0xFF00E5FF);

  /// Final leaderboard decorative / rank accents.
  static const resultsWinnerStar = Color(0xFF8FBF00);
  static const resultsOutPlayerName = Color(0xFFFFB4AB);

  /// Settings audio row icon tints (Figma).
  static const settingsMusicIcon = Color(0xFFFF3DF2);
  static const settingsSfxIcon = Color(0xFFFFE170);
}
