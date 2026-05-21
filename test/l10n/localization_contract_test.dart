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

  test('generated localizations expose core MVP strings', () {
    final localizations = lookupAppLocalizations(const Locale('pt', 'BR'));

    expect(localizations.appTitle, 'Out of the Loop');
    expect(localizations.startGame, 'JOGAR');
    expect(localizations.navPlay, 'INÍCIO');
    expect(localizations.navCategories, 'CATEGORIAS');
    expect(localizations.navProfile, 'PERFIL');
    expect(localizations.howToPlay, 'COMO JOGAR');
    expect(localizations.revealMyWord, 'REVELAR MEU PAPEL');
    expect(localizations.secretRevealRound(1), 'RODADA 1');
    expect(localizations.secretRevealPassTo, 'PASSE PARA');
    expect(localizations.secretRevealTopSecret, 'TOP SECREDO');
    expect(localizations.confirmVotes, 'CONFIRMAR VOTOS');
    expect(localizations.votingVote, 'VOTAR');
    expect(localizations.settings, 'Configuracoes');
    expect(localizations.howToPlayScreenTitle, 'COMO JOGAR');
    expect(localizations.howToPlaySecretBodyHighlight, 'Fora do Loop!');
  });
}
