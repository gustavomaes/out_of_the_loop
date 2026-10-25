import '../../../l10n/out_of_the_loop_localizations.dart';
import '../application/classic_experience.dart';
import 'package:flutter/material.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'classic_home.dart';
import 'classic_components.dart';

class ClassicApp extends StatelessWidget {
  const ClassicApp({
    super.key,
    this.textScaler,
    this.home,
    this.locale,
    this.experience,
  });
  final ClassicExperience? experience;
  final Locale? locale;
  final TextScaler? textScaler;
  final Widget? home;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([?experience]),
    builder: (context, _) => MaterialApp(
      theme: CoralTokens.theme,
      locale: experience?.locale ?? locale,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: experience == null
            ? child!
            : ClassicExperienceScope(experience: experience!, child: child!),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: OutOfTheLoopLocalizations.supportedLocales,
      localeResolutionCallback: (locale, _) =>
          OutOfTheLoopLocalizations.resolve(locale),
      home: home ?? const ClassicHome(),
    ),
  );
}
