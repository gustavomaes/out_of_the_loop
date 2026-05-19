import 'package:flutter/widgets.dart';

import '../domain/models/models.dart';

abstract final class OutOfTheLoopLocalizations {
  static const fallbackLocale = Locale('pt', 'BR');

  static const supportedLocales = <Locale>[
    fallbackLocale,
    Locale('en'),
    Locale('es'),
    Locale('hi'),
  ];

  static Locale resolve(Locale? requestedLocale) {
    if (requestedLocale == null) {
      return fallbackLocale;
    }

    for (final locale in supportedLocales) {
      if (locale.languageCode == requestedLocale.languageCode &&
          locale.countryCode == requestedLocale.countryCode) {
        return locale;
      }
    }

    for (final locale in supportedLocales) {
      if (locale.languageCode == requestedLocale.languageCode &&
          locale.countryCode == null) {
        return locale;
      }
    }

    if (requestedLocale.languageCode == fallbackLocale.languageCode) {
      return fallbackLocale;
    }

    return fallbackLocale;
  }

  static Locale localeFor(SupportedLanguage language) {
    return switch (language) {
      SupportedLanguage.ptBr => fallbackLocale,
      SupportedLanguage.en => const Locale('en'),
      SupportedLanguage.es => const Locale('es'),
      SupportedLanguage.hi => const Locale('hi'),
    };
  }
}
