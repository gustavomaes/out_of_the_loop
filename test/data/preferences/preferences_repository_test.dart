import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/preferences/preferences_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PreferencesRepository', () {
    const repository = PreferencesRepository();

    test('uses device locale and persists it when preferences are empty', () async {
      SharedPreferences.setMockInitialValues({});
      const deviceRepository = PreferencesRepository(
        deviceLocale: Locale('es'),
      );

      final preferences = await deviceRepository.load();
      final stored = await SharedPreferences.getInstance();

      expect(preferences.language, SupportedLanguage.es);
      expect(stored.getString('settings.language'), 'es');
    });

    test('returns defaults for audio when preferences are empty', () async {
      SharedPreferences.setMockInitialValues({});
      const deviceRepository = PreferencesRepository(
        deviceLocale: Locale('en'),
      );

      final preferences = await deviceRepository.load();

      expect(preferences.musicEnabled, isFalse);
      expect(preferences.soundEffectsEnabled, isTrue);
    });

    test('saves and restores language', () async {
      SharedPreferences.setMockInitialValues({});
      await repository.saveLanguage(SupportedLanguage.en);

      final preferences = await repository.load();
      expect(preferences.language, SupportedLanguage.en);
    });

    test('does not overwrite saved language on load', () async {
      SharedPreferences.setMockInitialValues({
        'settings.language': 'hi',
      });
      const deviceRepository = PreferencesRepository(
        deviceLocale: Locale('es'),
      );

      final preferences = await deviceRepository.load();

      expect(preferences.language, SupportedLanguage.hi);
    });

    test('saves and restores music preference', () async {
      SharedPreferences.setMockInitialValues({});
      await repository.saveMusicEnabled(true);

      final preferences = await repository.load();
      expect(preferences.musicEnabled, isTrue);
    });

    test('saves and restores sound effects preference', () async {
      SharedPreferences.setMockInitialValues({});
      await repository.saveSoundEffectsEnabled(false);

      final preferences = await repository.load();
      expect(preferences.soundEffectsEnabled, isFalse);
    });
  });
}
