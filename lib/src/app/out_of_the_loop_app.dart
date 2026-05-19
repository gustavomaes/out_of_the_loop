import 'dart:async';

import 'package:flutter/material.dart';

import '../data/preferences/preferences_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../l10n/out_of_the_loop_localizations.dart';
import '../features/game/final_leaderboard_screen.dart';
import '../features/game/question_round_screen.dart';
import '../features/game/round_results_screen.dart';
import '../features/game/secret_reveal_screen.dart';
import '../features/game/voting_screen.dart';
import '../features/home/home_screen.dart';
import '../features/how_to_play/how_to_play_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/setup/category_selection_screen.dart';
import '../features/setup/player_setup_screen.dart';
import '../domain/models/models.dart';
import '../theme/app_tokens.dart';
import 'app_routes.dart';
import 'app_shell.dart';
import 'game_flow_controller.dart';

class OutOfTheLoopApp extends StatefulWidget {
  const OutOfTheLoopApp({
    this.preferencesRepository = const PreferencesRepository(),
    super.key,
  });

  final PreferencesRepository preferencesRepository;

  @override
  State<OutOfTheLoopApp> createState() => _OutOfTheLoopAppState();
}

class _OutOfTheLoopAppState extends State<OutOfTheLoopApp> {
  final _flow = GameFlowController();

  @override
  void initState() {
    super.initState();
    _restorePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Out of the Loop',
      debugShowCheckedModeBanner: false,
      theme: OutOfTheLoopTheme.dark,
      locale: OutOfTheLoopLocalizations.localeFor(_flow.language),
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

    return MaterialPageRoute<void>(
      settings: RouteSettings(name: routeName),
      builder: (context) => _buildRoute(context, routeName),
    );
  }

  Widget _buildRoute(BuildContext context, String routeName) {
    return switch (routeName) {
      AppRoutes.home => HomeScreen(
        onStartGame: () =>
            Navigator.of(context).pushNamed(AppRoutes.categories),
        onHowToPlay: () => Navigator.of(context).pushNamed(AppRoutes.howToPlay),
      ),
      AppRoutes.categories => CategorySelectionScreen(
        repository: _flow.repository,
        language: _flow.language,
        onContinue: (category) async {
          await _flow.selectCategory(category);
          if (!context.mounted) {
            return;
          }
          Navigator.of(context).pushNamed(AppRoutes.players);
        },
      ),
      AppRoutes.players => PlayerSetupScreen(
        roundCount: _flow.roundCount,
        categoryWords: _flow.categoryWords,
        onStart: (players, questionsPerPlayer) {
          _flow.startMatch(
            players,
            questionsPerPlayer: questionsPerPlayer,
          );
          Navigator.of(context).pushNamed(AppRoutes.gameReveal);
        },
      ),
      AppRoutes.gameReveal => _gameRoute(
        AppRoutes.gameReveal,
        () => SecretRevealScreen(
          players: _flow.players,
          round: _flow.currentRound!,
          language: _flow.language,
          onComplete: () => Navigator.of(
            context,
          ).pushReplacementNamed(AppRoutes.gameQuestions),
        ),
      ),
      AppRoutes.gameQuestions => _gameRoute(
        AppRoutes.gameQuestions,
        () => QuestionRoundScreen(
          players: _flow.players,
          questions: _flow.currentRound!.questions,
          language: _flow.language,
          timerSettings: _flow.timerSettings,
          onComplete: () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.gameVote),
        ),
      ),
      AppRoutes.gameVote => _gameRoute(
        AppRoutes.gameVote,
        () => VotingScreen(
          players: _flow.players,
          timerSettings: _flow.timerSettings,
          onComplete: (votes) {
            setState(() => _flow.recordVotes(votes));
            Navigator.of(context).pushReplacementNamed(AppRoutes.gameResults);
          },
        ),
      ),
      AppRoutes.gameResults => _resultsRoute(context),
      AppRoutes.gameGuess => _gameRoute(
        AppRoutes.gameGuess,
        () => GuessScreen(
          players: _flow.players,
          round: _flow.currentRound!,
          onResolved: (result) => _finishRound(context, result),
        ),
      ),
      AppRoutes.gameFinal => FinalLeaderboardScreen(
        players: _flow.finalRanking(),
        onNewMatch: () {
          setState(_flow.resetMatch);
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.categories, (_) => false);
        },
        onBackHome: () {
          setState(_flow.resetMatch);
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
        },
      ),
      AppRoutes.howToPlay => HowToPlayScreen(
        onDone: () => Navigator.of(context).maybePop(),
      ),
      AppRoutes.settings => SettingsScreen(
        initialLanguage: _flow.language,
        initialTimerSettings: _flow.timerSettings,
        onLanguageChanged: (language) => setState(() {
          _flow.language = language;
          unawaited(widget.preferencesRepository.saveLanguage(language));
        }),
        onTimerChanged: (timerSettings) => setState(() {
          _flow.timerSettings = timerSettings;
          unawaited(
            widget.preferencesRepository.saveTimerSettings(timerSettings),
          );
        }),
      ),
      _ => _placeholder(routeName),
    };
  }

  Widget _resultsRoute(BuildContext context) {
    final result = _flow.currentResult;
    if (result == null) {
      return _placeholder(AppRoutes.gameResults);
    }

    return _gameRoute(
      AppRoutes.gameResults,
      () => RoundResultsScreen(
        players: _flow.players,
        round: _flow.currentRound!,
        result: result,
        onContinue: () => _finishRound(context, result),
        onGuess: () => Navigator.of(context).pushNamed(AppRoutes.gameGuess),
      ),
    );
  }

  Widget _gameRoute(String routeName, Widget Function() childBuilder) {
    if (!_flow.hasActiveRound) {
      return _placeholder(routeName);
    }
    return childBuilder();
  }

  Widget _placeholder(String routeName) {
    final title = _routeTitles[routeName] ?? 'Not Found';
    return PlaceholderRoutePage(title: title, routeName: routeName);
  }

  void _finishRound(BuildContext context, RoundResult result) {
    final isFinalRound = _flow.resolveCurrentRound(result);
    final nextRoute = isFinalRound ? AppRoutes.gameFinal : AppRoutes.gameReveal;
    setState(() {});
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  Future<void> _restorePreferences() async {
    final preferences = await widget.preferencesRepository.load();
    if (!mounted) {
      return;
    }
    if (_flow.language == preferences.language &&
        _flow.timerSettings == preferences.timerSettings) {
      return;
    }
    setState(() {
      _flow.language = preferences.language;
      _flow.timerSettings = preferences.timerSettings;
    });
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
