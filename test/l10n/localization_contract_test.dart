import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/l10n/out_of_the_loop_localizations.dart';

void main() {
  test('declares MVP supported locales with English first', () {
    expect(OutOfTheLoopLocalizations.supportedLocales, const [
      Locale('en'),
      Locale('pt', 'BR'),
      Locale('es'),
      Locale('hi'),
      Locale('ar'),
    ]);
  });

  test('resolves unsupported locales to English fallback', () {
    expect(OutOfTheLoopLocalizations.resolve(null), const Locale('en'));
    expect(
      OutOfTheLoopLocalizations.resolve(const Locale('fr', 'FR')),
      const Locale('en'),
    );
  });

  test('resolves regional Portuguese locales to pt-BR', () {
    expect(
      OutOfTheLoopLocalizations.resolve(const Locale('pt', 'PT')),
      const Locale('pt', 'BR'),
    );
  });

  test('resolves supported language-only locales', () {
    expect(
      OutOfTheLoopLocalizations.resolve(const Locale('en', 'US')),
      const Locale('en'),
    );
    expect(
      OutOfTheLoopLocalizations.resolve(const Locale('es', 'MX')),
      const Locale('es'),
    );
    expect(
      OutOfTheLoopLocalizations.resolve(const Locale('hi', 'IN')),
      const Locale('hi'),
    );
    expect(
      OutOfTheLoopLocalizations.resolve(const Locale('ar', 'SA')),
      const Locale('ar'),
    );
  });

  test('generated localizations expose Classic runtime strings', () {
    final l = lookupAppLocalizations(const Locale('en'));
    expect(l.classicStart, 'Start game');
  });
}
