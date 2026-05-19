import 'package:flutter/material.dart';

/// Figma-aligned display typography (Rubik, Plus Jakarta Sans, Space Grotesk).
///
/// Uses bundled variable fonts from [pubspec.yaml] so typography works offline
/// and in widget tests without runtime font fetching.
///
/// Preset index (add new styles here when duplicated 2+ times):
/// - **Shell / nav**: [bottomNavLabel], [rubikDiscoveryAppBarTitle]
/// - **Home**: [rubikHomeTitle], [rubikHomeButton]
/// - **Setup**: [rubikCategoryTitle], [rubikPlayerSetupTitle], …
/// - **Game flow**: [rubikSecretRevealHeading], [rubikVotingHeadlineMain], …
/// - **Results**: [rubikResultsWinnerTitle], [spaceGroteskResultsSectionLabel], …
abstract final class DisplayTypography {
  static const _rubikFamily = 'Rubik';
  static const _plusJakartaFamily = 'PlusJakartaSans';
  static const _spaceGroteskFamily = 'SpaceGrotesk';

  static TextStyle _rubik({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double letterSpacing = 0,
  }) {
    return TextStyle(
      fontFamily: _rubikFamily,
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle _plusJakarta({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontFamily: _plusJakartaFamily,
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      color: color,
    );
  }

  static TextStyle _spaceGrotesk({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double letterSpacing = 0,
  }) {
    return TextStyle(
      fontFamily: _spaceGroteskFamily,
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle rubikTitle({
    required Color color,
    double fontSize = 28,
    double? height,
    double letterSpacing = -0.7,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return _rubik(
      color: color,
      fontSize: fontSize,
      height: height ?? (fontSize >= 40 ? 52 / fontSize : 32 / fontSize),
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle plusJakartaBody({
    required Color color,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w500,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return _plusJakarta(
      color: color,
      fontSize: fontSize,
      height: 22.5 / 18,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle spaceGroteskSectionLabel({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.4,
  }) {
    return _spaceGrotesk(
      color: color,
      fontSize: fontSize,
      height: 20 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  /// Figma discovery / brutalist app bar title (Rubik 28 / 32, -1.4 tracking).
  static TextStyle rubikDiscoveryAppBarTitle({required Color color}) {
    return rubikTitle(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      letterSpacing: -1.4,
    );
  }

  /// Figma bottom-nav labels (Space Grotesk Bold 14 / 1.4 tracking).
  static TextStyle bottomNavLabel({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.4,
  }) {
    return spaceGroteskSectionLabel(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle rubikSettingLabel({
    required Color color,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return _rubik(
      color: color,
      fontSize: fontSize,
      height: 24 / fontSize,
      fontWeight: fontWeight,
    );
  }

  /// Figma home hero (Rubik Black 48 / 52, -2.4 tracking).
  static TextStyle rubikHomeTitle({
    required Color color,
    double fontSize = 48,
    FontWeight fontWeight = FontWeight.w900,
  }) {
    return _rubik(
      color: color,
      fontSize: fontSize,
      height: 52 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: -2.4,
    );
  }

  /// Figma home CTA (Rubik Bold 20 / 24).
  static TextStyle rubikHomeButton({
    required Color color,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return _rubik(
      color: color,
      fontSize: fontSize,
      height: 24 / fontSize,
      fontWeight: fontWeight,
    );
  }

  /// Figma category screen title (Rubik Bold 16 / 24).
  static TextStyle rubikCategoryTitle({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma category card label (Rubik Bold 16 / 20).
  static TextStyle rubikCategoryCardLabel({
    required Color color,
    double height = 20 / 16,
  }) {
    return _rubik(
      color: color,
      fontSize: 16,
      height: height,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma player setup title (Rubik Bold 40 / 50).
  static TextStyle rubikPlayerSetupTitle({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 40,
      height: 50 / 40,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma player card name (Rubik Bold 16 / 24).
  static TextStyle rubikPlayerCardName({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma player setup CTA (Rubik ExtraBold 28 / 32).
  static TextStyle rubikPlayerSetupCta({required Color color}) {
    return rubikTitle(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      letterSpacing: -0.7,
    );
  }

  static TextStyle spaceGroteskMeta({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.4,
  }) {
    return _spaceGrotesk(
      color: color,
      fontSize: fontSize,
      height: 20 / fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  /// Figma secret reveal round label (Space Grotesk Bold 14 / 2.8 tracking).
  static TextStyle spaceGroteskRoundLabel({required Color color}) {
    return spaceGroteskMeta(
      color: color,
      letterSpacing: 2.8,
    );
  }

  /// Figma secret reveal heading (Rubik Black 48 / 52).
  static TextStyle rubikSecretRevealHeading({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 48,
      height: 52 / 48,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.96,
    );
  }

  /// Figma secret reveal privacy copy (Plus Jakarta Sans Medium 18 / 28).
  static TextStyle plusJakartaSecretRevealBody({required Color color}) {
    return _plusJakarta(
      color: color,
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w500,
    );
  }

  /// Figma secret card label (Rubik ExtraBold 28 / 32).
  static TextStyle rubikTopSecretLabel({required Color color}) {
    return rubikTitle(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      letterSpacing: 0,
      fontWeight: FontWeight.w800,
    );
  }

  /// Figma question round card (Rubik ExtraBold 28 / 35).
  static TextStyle rubikQuestionCard({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 28,
      height: 35 / 28,
      fontWeight: FontWeight.w800,
    );
  }

  /// Figma question round speak-up title (Rubik Bold 24 / 28).
  static TextStyle rubikSpeakUpTitle({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 24,
      height: 28 / 24,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma question round CTA (Rubik Bold 20 / 24).
  static TextStyle rubikQuestionRoundCta({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 20,
      height: 24 / 20,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma player turn chip (Space Grotesk Bold 14 / 20, 1.4 tracking).
  static TextStyle spaceGroteskTurnChip({required Color color}) {
    return spaceGroteskSectionLabel(color: color);
  }

  /// Figma voting headline line 1 (Rubik ExtraBold 28 / 32).
  static TextStyle rubikVotingHeadlineAccent({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.96,
    );
  }

  /// Figma voting headline lines 2–3 (Rubik Black 48 / 60).
  static TextStyle rubikVotingHeadlineMain({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 48,
      height: 60 / 48,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.96,
    );
  }

  /// Figma voting subtitle (Plus Jakarta Sans Regular 16 / 24).
  static TextStyle plusJakartaVotingSubtitle({required Color color}) {
    return _plusJakarta(
      color: color,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    );
  }

  /// Figma voting player name (Plus Jakarta Sans Bold 18 / 28).
  static TextStyle plusJakartaVotingPlayerName({required Color color}) {
    return _plusJakarta(
      color: color,
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma voting self hint (Space Grotesk Bold 10 / 15).
  static TextStyle spaceGroteskVotingSelfHint({required Color color}) {
    return _spaceGrotesk(
      color: color,
      fontSize: 10,
      height: 15 / 10,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
    );
  }

  /// Figma voting card button (Rubik Bold 20 / 24).
  static TextStyle rubikVotingButton({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 20,
      height: 24 / 20,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma voting timer seconds (Rubik ExtraBold 28 / 32).
  static TextStyle rubikVotingTimerSeconds({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      fontWeight: FontWeight.w800,
    );
  }

  /// Figma game results winner title (Rubik ExtraBold 28 / 32).
  static TextStyle rubikResultsWinnerTitle({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      fontWeight: FontWeight.w800,
    );
  }

  /// Figma game results secret word (Rubik ExtraBold 28 / 32, wide tracking).
  static TextStyle rubikResultsSecretWord({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 28,
      height: 32 / 28,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.4,
    );
  }

  /// Figma game results leaderboard rank (Rubik ExtraBold 28 / 32).
  static TextStyle rubikResultsRank({required Color color}) {
    return rubikResultsWinnerTitle(color: color);
  }

  /// Figma game results leaderboard name (Rubik Bold 20 / 24).
  static TextStyle rubikResultsPlayerName({required Color color}) {
    return _rubik(
      color: color,
      fontSize: 20,
      height: 24 / 20,
      fontWeight: FontWeight.w700,
    );
  }

  /// Figma game results leaderboard score (Rubik ExtraBold 28 / 32).
  static TextStyle rubikResultsScore({required Color color}) {
    return rubikResultsWinnerTitle(color: color);
  }

  /// Figma game results reveal label (Plus Jakarta Sans Regular 16 / 24).
  static TextStyle plusJakartaResultsRevealLabel({required Color color}) {
    return plusJakartaVotingSubtitle(color: color);
  }

  /// Figma game results reveal body (Plus Jakarta Sans Regular 16 / 24).
  static TextStyle plusJakartaResultsRevealBody({required Color color}) {
    return plusJakartaResultsRevealLabel(color: color);
  }

  /// Figma game results mastermind badge (Space Grotesk Bold 14 / 20).
  static TextStyle spaceGroteskResultsBadge({required Color color}) {
    return spaceGroteskSectionLabel(color: color);
  }

  /// Figma game results section label (Space Grotesk Bold 14 / 20).
  static TextStyle spaceGroteskResultsSectionLabel({required Color color}) {
    return spaceGroteskSectionLabel(color: color);
  }
}
