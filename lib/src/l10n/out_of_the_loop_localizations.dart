import 'package:flutter/widgets.dart';

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
}
