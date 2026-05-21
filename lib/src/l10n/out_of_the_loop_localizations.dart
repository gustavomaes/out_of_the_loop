import 'package:flutter/widgets.dart';

import '../domain/models/models.dart';

abstract final class OutOfTheLoopLocalizations {
  static const fallbackLocale = Locale('en');

  static const supportedLocales = <Locale>[
    fallbackLocale,
    Locale('pt', 'BR'),
    Locale('es'),
    Locale('hi'),
    Locale('ar'),
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

    if (requestedLocale.languageCode == 'pt') {
      return const Locale('pt', 'BR');
    }

    return fallbackLocale;
  }

  static Locale localeFor(SupportedLanguage language) {
    return switch (language) {
      SupportedLanguage.ptBr => const Locale('pt', 'BR'),
      SupportedLanguage.en => fallbackLocale,
      SupportedLanguage.es => const Locale('es'),
      SupportedLanguage.hi => const Locale('hi'),
      SupportedLanguage.ar => const Locale('ar'),
    };
  }

  /// Maps the device (or requested) locale to in-game content language.
  ///
  /// Unsupported locales fall back to English rather than Portuguese.
  static SupportedLanguage supportedLanguageFrom(Locale locale) {
    return switch (locale.languageCode) {
      'pt' => SupportedLanguage.ptBr,
      'en' => SupportedLanguage.en,
      'es' => SupportedLanguage.es,
      'hi' => SupportedLanguage.hi,
      'ar' => SupportedLanguage.ar,
      _ => SupportedLanguage.en,
    };
  }
}
