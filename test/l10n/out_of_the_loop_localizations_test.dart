import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/l10n/out_of_the_loop_localizations.dart';

void main() {
  group('OutOfTheLoopLocalizations.supportedLanguageFrom', () {
    test('maps supported device locales', () {
      expect(
        OutOfTheLoopLocalizations.supportedLanguageFrom(const Locale('pt', 'BR')),
        SupportedLanguage.ptBr,
      );
      expect(
        OutOfTheLoopLocalizations.supportedLanguageFrom(const Locale('en', 'US')),
        SupportedLanguage.en,
      );
      expect(
        OutOfTheLoopLocalizations.supportedLanguageFrom(const Locale('es')),
        SupportedLanguage.es,
      );
      expect(
        OutOfTheLoopLocalizations.supportedLanguageFrom(const Locale('hi')),
        SupportedLanguage.hi,
      );
      expect(
        OutOfTheLoopLocalizations.supportedLanguageFrom(const Locale('ar')),
        SupportedLanguage.ar,
      );
    });

    test('falls back to English for unsupported locales', () {
      expect(
        OutOfTheLoopLocalizations.supportedLanguageFrom(const Locale('fr')),
        SupportedLanguage.en,
      );
    });
  });
}
