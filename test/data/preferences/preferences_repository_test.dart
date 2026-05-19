import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/preferences/preferences_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PreferencesRepository', () {
    test('loads defaults when no local preferences exist', () async {
      SharedPreferences.setMockInitialValues({});
      const repository = PreferencesRepository();

      final preferences = await repository.load();

      expect(preferences.language, SupportedLanguage.ptBr);
      expect(preferences.timerSettings, const TimerSettings());
    });

    test('saves and restores language and timer settings', () async {
      SharedPreferences.setMockInitialValues({});
      const repository = PreferencesRepository();

      await repository.saveLanguage(SupportedLanguage.en);
      await repository.saveTimerSettings(
        const TimerSettings(enabled: false, durationSeconds: 45),
      );

      final preferences = await repository.load();

      expect(preferences.language, SupportedLanguage.en);
      expect(
        preferences.timerSettings,
        const TimerSettings(enabled: false, durationSeconds: 45),
      );
    });
  });
}
