import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/models.dart';

final class PreferencesSnapshot {
  const PreferencesSnapshot({required this.language});

  final SupportedLanguage language;
}

final class PreferencesRepository {
  const PreferencesRepository();

  static const _languageKey = 'settings.language';

  Future<PreferencesSnapshot> load() async {
    final preferences = await SharedPreferences.getInstance();
    return PreferencesSnapshot(
      language: _languageFromCode(preferences.getString(_languageKey)),
    );
  }

  Future<void> saveLanguage(SupportedLanguage language) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, language.code);
  }

  SupportedLanguage _languageFromCode(String? code) {
    return SupportedLanguage.values
            .where((language) => language.code == code)
            .firstOrNull ??
        SupportedLanguage.ptBr;
  }
}
