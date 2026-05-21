import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/models.dart';
import '../../l10n/out_of_the_loop_localizations.dart';

final class PreferencesSnapshot {
  const PreferencesSnapshot({
    required this.language,
    this.musicEnabled = false,
    this.soundEffectsEnabled = true,
  });

  final SupportedLanguage language;
  final bool musicEnabled;
  final bool soundEffectsEnabled;
}

final class PreferencesRepository {
  const PreferencesRepository({Locale? deviceLocale})
    : _deviceLocale = deviceLocale;

  final Locale? _deviceLocale;

  static const _languageKey = 'settings.language';
  static const _musicKey = 'settings.music';
  static const _soundEffectsKey = 'settings.soundEffects';

  Future<PreferencesSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    final savedLanguageCode = preferences.getString(_languageKey);
    final language = _resolveLanguage(savedLanguageCode);

    if (savedLanguageCode == null) {
      await preferences.setString(_languageKey, language.code);
    }

    return PreferencesSnapshot(
      language: language,
      musicEnabled: preferences.getBool(_musicKey) ?? false,
      soundEffectsEnabled: preferences.getBool(_soundEffectsKey) ?? true,
    );
  }

  Future<void> saveLanguage(SupportedLanguage language) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, language.code);
  }

  Future<void> saveMusicEnabled(bool enabled) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_musicKey, enabled);
  }

  Future<void> saveSoundEffectsEnabled(bool enabled) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_soundEffectsKey, enabled);
  }

  SupportedLanguage _resolveLanguage(String? savedCode) {
    if (savedCode != null) {
      return SupportedLanguage.values
              .where((language) => language.code == savedCode)
              .firstOrNull ??
          _defaultLanguage();
    }
    return _defaultLanguage();
  }

  SupportedLanguage _defaultLanguage() {
    final locale = _deviceLocale ?? PlatformDispatcher.instance.locale;
    return OutOfTheLoopLocalizations.supportedLanguageFrom(locale);
  }
}
