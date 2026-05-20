import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/data/preferences/preferences_repository.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PreferencesRepository', () {
    const repository = PreferencesRepository();

    test('returns defaults when preferences are empty', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await repository.load();

      expect(preferences.language, SupportedLanguage.ptBr);
    });

    test('saves and restores language', () async {
      SharedPreferences.setMockInitialValues({});
      await repository.saveLanguage(SupportedLanguage.en);

      final preferences = await repository.load();
      expect(preferences.language, SupportedLanguage.en);
    });
  });
}
