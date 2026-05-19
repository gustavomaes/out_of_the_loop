import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/l10n/out_of_the_loop_localizations.dart';

void main() {
  test('declares MVP supported locales with pt-BR first', () {
    expect(OutOfTheLoopLocalizations.supportedLocales, const [
      Locale('pt', 'BR'),
      Locale('en'),
      Locale('es'),
      Locale('hi'),
    ]);
  });

  test(
    'resolves unsupported or regional Portuguese locales to pt-BR fallback',
    () {
      expect(OutOfTheLoopLocalizations.resolve(null), const Locale('pt', 'BR'));
      expect(
        OutOfTheLoopLocalizations.resolve(const Locale('fr', 'FR')),
        const Locale('pt', 'BR'),
      );
      expect(
        OutOfTheLoopLocalizations.resolve(const Locale('pt', 'PT')),
        const Locale('pt', 'BR'),
      );
    },
  );

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
  });

  test('generated localizations expose core MVP strings', () {
    final localizations = lookupAppLocalizations(const Locale('pt', 'BR'));

    expect(localizations.appTitle, 'Out of the Loop');
    expect(localizations.startGame, 'JOGAR');
    expect(localizations.navPlay, 'INÍCIO');
    expect(localizations.navCategories, 'CATEGORIAS');
    expect(localizations.navProfile, 'PERFIL');
    expect(localizations.howToPlay, 'COMO JOGAR');
    expect(localizations.revealMyWord, 'Visualizar minha palavra');
    expect(localizations.confirmVotes, 'Confirmar votos');
    expect(localizations.settings, 'Configuracoes');
    expect(localizations.howToPlayScreenTitle, 'COMO JOGAR');
    expect(localizations.howToPlaySecretBodyHighlight, 'Fora do Loop!');
  });
}
