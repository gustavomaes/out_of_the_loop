import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/preferences/preferences_repository.dart';
import '../domain/models/models.dart';
import '../domain/services/match_setup_service.dart';
import '../features/game/final_leaderboard_screen.dart';
import '../features/game/question_round_screen.dart';
import '../features/game/guess_screen.dart';
import '../features/game/round_results_screen.dart';
import '../features/game/secret_reveal_screen.dart';
import '../features/game/voting_screen.dart';
import '../features/home/home_screen.dart';
import '../features/how_to_play/how_to_play_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/setup/category_selection_screen.dart';
import '../features/setup/match_setup_screen.dart';
import '../features/setup/player_setup_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';
import 'discovery_shell.dart' show DiscoveryNavigation, DiscoveryShell;
import 'game_flow_controller.dart';
import 'otl_tab_slide_container.dart';

class AppRouter {
  AppRouter({
    required this.flow,
    required this.preferencesRepository,
    required this.onFlowChanged,
    Listenable? refreshListenable,
  }) : router = GoRouter(
         initialLocation: AppRoutes.home,
         refreshListenable: refreshListenable,
         navigatorKey: _rootNavigatorKey,
         routes: _routes(
           flow: flow,
           preferencesRepository: preferencesRepository,
           onFlowChanged: onFlowChanged,
         ),
       );

  final GameFlowController flow;
  final PreferencesRepository preferencesRepository;
  final VoidCallback onFlowChanged;
  final GoRouter router;

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static List<RouteBase> _routes({
    required GameFlowController flow,
    required PreferencesRepository preferencesRepository,
    required VoidCallback onFlowChanged,
  }) {
    return [
      StatefulShellRoute(
        builder: (context, state, navigationShell) {
          return DiscoveryShell(navigationShell: navigationShell);
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return OtlTabSlideContainer(
            navigationShell: navigationShell,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: _DiscoveryHomeRoute()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.categories,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: _DiscoveryCategoriesRoute(
                    flow: flow,
                    onFlowChanged: onFlowChanged,
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: _DiscoverySettingsRoute(
                    flow: flow,
                    preferencesRepository: preferencesRepository,
                    onFlowChanged: onFlowChanged,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.matchSetup,
        builder: (context, state) => MatchSetupScreen(
          categoryWords: flow.categoryWords,
          onBack: () => context.pop(),
          onContinue: (roundCount, questionsPerPlayer) {
            flow.configureMatch(
              roundCount: roundCount,
              questionsPerPlayer: questionsPerPlayer,
            );
            context.push(AppRoutes.players);
          },
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.players,
        builder: (context, state) => PlayerSetupScreen(
          roundCount:
              flow.pendingRoundCount ?? MatchSetup.recommendedRoundCount,
          questionsPerPlayer:
              flow.pendingQuestionsPerPlayer ??
              MatchSetupService.recommendedQuestionsPerPlayer(0),
          categoryWords: flow.categoryWords,
          onBack: () => context.pop(),
          onStart: (players, roundCount, questionsPerPlayer) {
            flow.startMatch(
              players,
              roundCount: roundCount,
              questionsPerPlayer: questionsPerPlayer,
            );
            context.push(AppRoutes.gameReveal);
          },
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.gameReveal,
        builder: (context, state) => _gameRoute(
          flow,
          AppRoutes.gameReveal,
          () => SecretRevealScreen(
            players: flow.players,
            round: flow.currentRound!,
            language: flow.language,
            onComplete: () => context.pushReplacement(AppRoutes.gameQuestions),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.gameQuestions,
        builder: (context, state) => _gameRoute(
          flow,
          AppRoutes.gameQuestions,
          () => QuestionRoundScreen(
            players: flow.players,
            questionTurns: flow.currentRound!.questionTurns,
            language: flow.language,
            timerSettings: flow.timerSettings,
            onComplete: () => context.pushReplacement(AppRoutes.gameVote),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.gameVote,
        builder: (context, state) => _gameRoute(
          flow,
          AppRoutes.gameVote,
          () => VotingScreen(
            players: flow.players,
            timerSettings: flow.timerSettings,
            onComplete: (votes) {
              flow.recordVotes(votes);
              onFlowChanged();
              context.pushReplacement(AppRoutes.gameResults);
            },
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.gameResults,
        builder: (context, state) {
          final result = flow.currentResult;
          if (result == null) {
            return _placeholder(AppRoutes.gameResults);
          }
          return _gameRoute(
            flow,
            AppRoutes.gameResults,
            () => RoundResultsScreen(
              players: flow.players,
              round: flow.currentRound!,
              result: result,
              totalRoundCount: flow.setup?.roundCount,
              language: flow.setup?.language ?? flow.language,
              onContinue: () => _finishRound(context, flow, onFlowChanged),
              onGuess: () => context.push(AppRoutes.gameGuess),
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.gameGuess,
        builder: (context, state) => _gameRoute(
          flow,
          AppRoutes.gameGuess,
          () => GuessScreen(
            players: flow.players,
            round: flow.currentRound!,
            onResolved: (result) =>
                _finishRound(context, flow, onFlowChanged, result: result),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.gameFinal,
        builder: (context, state) {
          final lastRound = flow.lastCompletedRound;
          final outPlayerId = lastRound?.outPlayerId;
          return FinalLeaderboardScreen(
            players: flow.finalRanking(),
            secretWord: lastRound?.secretWord,
            outPlayer: outPlayerId == null
                ? null
                : flow.playerById(outPlayerId),
            language: flow.setup?.language ?? flow.language,
            onNewMatch: () {
              flow.resetMatch();
              onFlowChanged();
              context.goDiscoveryTab(AppRoutes.categories);
            },
            onBackHome: () {
              flow.resetMatch();
              onFlowChanged();
              context.goDiscoveryTab(AppRoutes.home);
            },
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.howToPlay,
        builder: (context, state) => const HowToPlayScreen(),
      ),
    ];
  }

  static void _finishRound(
    BuildContext context,
    GameFlowController flow,
    VoidCallback onFlowChanged, {
    RoundResult? result,
  }) {
    final resolved = result ?? flow.currentResult;
    if (resolved == null) {
      return;
    }
    final isFinalRound = flow.resolveCurrentRound(resolved);
    onFlowChanged();
    final nextRoute = isFinalRound ? AppRoutes.gameFinal : AppRoutes.gameReveal;
    context.pushReplacement(nextRoute);
  }

  static Widget _gameRoute(
    GameFlowController flow,
    String routeName,
    Widget Function() childBuilder,
  ) {
    if (!flow.hasActiveRound) {
      return _placeholder(routeName);
    }
    return childBuilder();
  }

  static Widget _placeholder(String routeName) {
    final title = _routeTitles[routeName] ?? 'Not Found';
    return PlaceholderRoutePage(title: title, routeName: routeName);
  }
}

class _DiscoveryHomeRoute extends StatelessWidget {
  const _DiscoveryHomeRoute();

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      onStartGame: () => context.goDiscoveryTab(AppRoutes.categories),
      onHowToPlay: () => context.push(AppRoutes.howToPlay),
    );
  }
}

class _DiscoveryCategoriesRoute extends StatelessWidget {
  const _DiscoveryCategoriesRoute({
    required this.flow,
    required this.onFlowChanged,
  });

  final GameFlowController flow;
  final VoidCallback onFlowChanged;

  @override
  Widget build(BuildContext context) {
    return CategorySelectionScreen(
      repository: flow.repository,
      language: flow.language,
      onContinue: (category) async {
        await flow.selectCategory(category);
        if (!context.mounted) {
          return;
        }
        context.push(AppRoutes.matchSetup);
      },
    );
  }
}

class _DiscoverySettingsRoute extends StatelessWidget {
  const _DiscoverySettingsRoute({
    required this.flow,
    required this.preferencesRepository,
    required this.onFlowChanged,
  });

  final GameFlowController flow;
  final PreferencesRepository preferencesRepository;
  final VoidCallback onFlowChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      initialLanguage: flow.language,
      initialTimerSettings: flow.timerSettings,
      onLanguageChanged: (language) {
        flow.language = language;
        onFlowChanged();
        unawaited(preferencesRepository.saveLanguage(language));
      },
      onTimerChanged: (timerSettings) {
        flow.timerSettings = timerSettings;
        onFlowChanged();
        unawaited(preferencesRepository.saveTimerSettings(timerSettings));
      },
    );
  }
}

const _routeTitles = <String, String>{
  AppRoutes.home: 'OUT OF THE LOOP',
  AppRoutes.categories: 'Categories',
  AppRoutes.matchSetup: 'Match Setup',
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
