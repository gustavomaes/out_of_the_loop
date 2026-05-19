import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/models.dart';

final class PreferencesSnapshot {
  const PreferencesSnapshot({
    required this.language,
    required this.timerSettings,
  });

  final SupportedLanguage language;
  final TimerSettings timerSettings;
}

final class PreferencesRepository {
  const PreferencesRepository();

  static const _languageKey = 'settings.language';
  static const _timerEnabledKey = 'settings.timer.enabled';
  static const _timerDurationKey = 'settings.timer.durationSeconds';

  Future<PreferencesSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    return PreferencesSnapshot(
      language: _languageFromCode(preferences.getString(_languageKey)),
      timerSettings: TimerSettings(
        enabled:
            preferences.getBool(_timerEnabledKey) ??
            const TimerSettings().enabled,
        durationSeconds:
            preferences.getInt(_timerDurationKey) ??
            const TimerSettings().durationSeconds,
      ),
    );
  }

  Future<void> saveLanguage(SupportedLanguage language) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, language.code);
  }

  Future<void> saveTimerSettings(TimerSettings timerSettings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_timerEnabledKey, timerSettings.enabled);
    await preferences.setInt(_timerDurationKey, timerSettings.durationSeconds);
  }

  SupportedLanguage _languageFromCode(String? code) {
    return SupportedLanguage.values
            .where((language) => language.code == code)
            .firstOrNull ??
        SupportedLanguage.ptBr;
  }
}
