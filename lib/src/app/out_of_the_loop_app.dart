import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/out_of_the_loop_localizations.dart';
import '../theme/app_tokens.dart';
import 'app_routes.dart';
import 'app_shell.dart';

class OutOfTheLoopApp extends StatelessWidget {
  const OutOfTheLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Out of the Loop',
      debugShowCheckedModeBanner: false,
      theme: OutOfTheLoopTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: OutOfTheLoopLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) =>
          OutOfTheLoopLocalizations.resolve(locale),
      initialRoute: AppRoutes.home,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<void> _onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name ?? AppRoutes.home;
    final title = _routeTitles[routeName] ?? 'Not Found';

    return MaterialPageRoute<void>(
      settings: RouteSettings(name: routeName),
      builder: (_) => PlaceholderRoutePage(title: title, routeName: routeName),
    );
  }
}

const _routeTitles = <String, String>{
  AppRoutes.home: 'OUT OF THE LOOP',
  AppRoutes.categories: 'Categories',
  AppRoutes.players: 'Players',
  AppRoutes.gameReveal: 'Secret Reveal',
  AppRoutes.gameQuestions: 'Questions',
  AppRoutes.gameVote: 'Vote',
  AppRoutes.gameResults: 'Results',
  AppRoutes.gameGuess: 'Guess',
  AppRoutes.gameFinal: 'Final Leaderboard',
  AppRoutes.howToPlay: 'How To Play',
  AppRoutes.settings: 'Settings',
};
