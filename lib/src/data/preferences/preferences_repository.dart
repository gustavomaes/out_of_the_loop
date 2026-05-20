import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/models.dart';

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
  const PreferencesRepository();

  static const _languageKey = 'settings.language';
  static const _musicKey = 'settings.music';
  static const _soundEffectsKey = 'settings.soundEffects';

  Future<PreferencesSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    return PreferencesSnapshot(
      language: _languageFromCode(preferences.getString(_languageKey)),
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

  SupportedLanguage _languageFromCode(String? code) {
    return SupportedLanguage.values
            .where((language) => language.code == code)
            .firstOrNull ??
        SupportedLanguage.ptBr;
  }
}
