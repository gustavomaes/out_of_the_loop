import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../src/domain/models/models.dart';
import '../src/data/content/local_content_repository.dart';
import '../src/features/game/free_clue_screen.dart';
import '../src/features/packs/packs_screen.dart';
import '../src/features/packs/packs_controller.dart';
import '../src/domain/services/vote_scoring_service.dart';
import '../src/features/home/home_screen.dart';
import '../src/features/onboarding/onboarding_screen.dart';
import '../src/features/setup/category_selection_screen.dart';
import '../src/features/setup/match_setup_screen.dart';
import '../src/features/setup/player_setup_screen.dart';
import '../src/features/game/secret_reveal_screen.dart';
import '../src/features/game/questions_ready_screen.dart';
import '../src/features/game/question_round_screen.dart';
import '../src/features/game/voting_screen.dart';
import '../src/features/game/round_results_screen.dart';
import '../src/features/game/guess_screen.dart';
import '../src/features/game/final_leaderboard_screen.dart';
import '../src/features/settings/settings_screen.dart';
import '../src/features/how_to_play/how_to_play_screen.dart';
import '../src/l10n/generated/app_localizations.dart';
import '../src/theme/theme.dart';

/// Isolated, offline previews. Nothing here is registered in production routing.
enum NeonPreviewScreen {
  onboarding,
  home,
  categories,
  matchSetup,
  players,
  reveal,
  ready,
  question,
  voting,
  results,
  guess,
  leaderboard,
  settings,
  rules,
  freeClues,
  packs,
}

const neonPreviewPlayers = [
  Player(id: 'bia', name: 'Bia', avatarSeed: 'bia', totalScore: 125),
  Player(id: 'davi', name: 'Davi', avatarSeed: 'davi', totalScore: 50),
  Player(id: 'leo', name: 'Léo', avatarSeed: 'leo', totalScore: 100),
  Player(id: 'sara', name: 'Sara', avatarSeed: 'sara', totalScore: 125),
];
const _question = Question(
  id: 'q1',
  wordId: 'churrasco',
  text: LocalizedText({
    SupportedLanguage.ptBr:
        'Isso combina mais com domingo em família ou com uma festa?',
    SupportedLanguage.en:
        'Does this belong at a family Sunday lunch or a party?',
    SupportedLanguage.es:
        '¿Esto combina más con un domingo en familia o una fiesta?',
    SupportedLanguage.hi:
        'क्या यह परिवार के साथ रविवार या किसी पार्टी के लिए है?',
    SupportedLanguage.ar: 'هل يناسب هذا غداء الأحد مع العائلة أم حفلة؟',
  }),
);
final _word = SecretWord(
  id: 'churrasco',
  categoryId: 'food',
  value: const LocalizedText({
    SupportedLanguage.ptBr: 'Churrasco',
    SupportedLanguage.en: 'Barbecue',
    SupportedLanguage.es: 'Asado',
    SupportedLanguage.hi: 'बारबेक्यू',
    SupportedLanguage.ar: 'شواء',
  }),
  questions: const [_question],
);
final neonPreviewRound = RoundState(
  roundNumber: 1,
  outPlayerId: 'davi',
  secretWord: _word,
  questions: const [_question],
  questionTurns: const [QuestionTurn(question: _question, playerId: 'bia')],
  phase: RoundPhase.results,
  votes: const [
    Vote(voterId: 'bia', suspectId: 'davi'),
    Vote(voterId: 'davi', suspectId: 'leo'),
    Vote(voterId: 'leo', suspectId: 'davi'),
    Vote(voterId: 'sara', suspectId: 'davi'),
  ],
);
const _category = Category(
  id: 'food',
  iconKey: 'restaurant',
  primaryArgb: 0xffcaff36,
  secondaryArgb: 0xff2c223f,
  name: LocalizedText({
    SupportedLanguage.ptBr: 'Comida',
    SupportedLanguage.en: 'Food',
    SupportedLanguage.es: 'Comida',
    SupportedLanguage.hi: 'खाना',
    SupportedLanguage.ar: 'طعام',
  }),
);

Widget neonPreviewPage(
  NeonPreviewScreen screen,
  SupportedLanguage language, {
  LocalContentRepository? repository,
  PacksController? packsController,
}) => switch (screen) {
  NeonPreviewScreen.onboarding => OnboardingScreen(onComplete: (_) async {}),
  NeonPreviewScreen.freeClues => FreeClueScreen(
    players: neonPreviewPlayers,
    outPlayerId: 'davi',
    onComplete: () {},
  ),
  NeonPreviewScreen.packs => PacksScreen(
    controller: packsController ?? PacksController(),
    onPlay: (_) {},
  ),
  NeonPreviewScreen.home => HomeScreen(onStartGame: () {}, onHowToPlay: () {}),
  NeonPreviewScreen.categories => CategorySelectionScreen(
    language: language,
    repository: repository,
    packsController: packsController,
    onExplorePacks: () {},
  ),
  NeonPreviewScreen.matchSetup => const MatchSetupScreen(),
  NeonPreviewScreen.players => const PlayerSetupScreen(
    roundCount: 3,
    questionsPerPlayer: 1,
    initialPlayers: neonPreviewPlayers,
  ),
  NeonPreviewScreen.reveal => SecretRevealScreen(
    players: neonPreviewPlayers,
    round: neonPreviewRound,
    language: language,
  ),
  NeonPreviewScreen.ready => QuestionsReadyScreen(
    category: _category,
    language: language,
    roundNumber: 1,
  ),
  NeonPreviewScreen.question => QuestionRoundScreen(
    players: neonPreviewPlayers,
    questionTurns: neonPreviewRound.questionTurns,
    language: language,
  ),
  NeonPreviewScreen.voting => const VotingScreen(players: neonPreviewPlayers),
  NeonPreviewScreen.results => RoundResultsScreen(
    players: neonPreviewPlayers,
    round: neonPreviewRound,
    result: const VoteScoringService().calculateRoundResult(
      round: neonPreviewRound,
      players: neonPreviewPlayers,
    ),
    language: language,
  ),
  NeonPreviewScreen.guess => GuessScreen(
    players: neonPreviewPlayers,
    round: neonPreviewRound,
  ),
  NeonPreviewScreen.leaderboard => FinalLeaderboardScreen(
    players: neonPreviewPlayers,
    secretWord: _word,
    language: language,
  ),
  NeonPreviewScreen.settings => SettingsScreen(initialLanguage: language),
  NeonPreviewScreen.rules => const HowToPlayScreen(),
};

Widget neonPreviewApp(NeonPreviewScreen screen) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: OutOfTheLoopTheme.dark,
  locale: const Locale('pt', 'BR'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: neonPreviewPage(screen, SupportedLanguage.ptBr),
);

@Preview(name: 'Início', group: 'Neon refinado', size: Size(390, 844))
Widget neonHomePreview() => neonPreviewApp(NeonPreviewScreen.home);
@Preview(name: 'Categorias', group: 'Neon refinado', size: Size(390, 844))
Widget neonCategoriesPreview() => neonPreviewApp(NeonPreviewScreen.categories);
@Preview(name: 'Configuração', group: 'Neon refinado', size: Size(390, 844))
Widget neonSetupPreview() => neonPreviewApp(NeonPreviewScreen.matchSetup);
@Preview(name: 'Jogadores', group: 'Neon refinado', size: Size(390, 844))
Widget neonPlayersPreview() => neonPreviewApp(NeonPreviewScreen.players);
@Preview(name: 'Revelação', group: 'Neon refinado', size: Size(390, 844))
Widget neonRevealPreview() => neonPreviewApp(NeonPreviewScreen.reveal);
@Preview(name: 'Prontos', group: 'Neon refinado', size: Size(390, 844))
Widget neonReadyPreview() => neonPreviewApp(NeonPreviewScreen.ready);
@Preview(name: 'Pergunta', group: 'Neon refinado', size: Size(390, 844))
Widget neonQuestionPreview() => neonPreviewApp(NeonPreviewScreen.question);
@Preview(name: 'Votação', group: 'Neon refinado', size: Size(390, 844))
Widget neonVotingPreview() => neonPreviewApp(NeonPreviewScreen.voting);
@Preview(name: 'Resultado', group: 'Neon refinado', size: Size(390, 844))
Widget neonResultsPreview() => neonPreviewApp(NeonPreviewScreen.results);
@Preview(name: 'Palpite', group: 'Neon refinado', size: Size(390, 844))
Widget neonGuessPreview() => neonPreviewApp(NeonPreviewScreen.guess);
@Preview(name: 'Placar', group: 'Neon refinado', size: Size(390, 844))
Widget neonLeaderboardPreview() =>
    neonPreviewApp(NeonPreviewScreen.leaderboard);
@Preview(name: 'Configurações', group: 'Neon refinado', size: Size(390, 844))
Widget neonSettingsPreview() => neonPreviewApp(NeonPreviewScreen.settings);
@Preview(name: 'Como jogar', group: 'Neon refinado', size: Size(390, 844))
Widget neonRulesPreview() => neonPreviewApp(NeonPreviewScreen.rules);

@Preview(name: 'Free play', group: 'Neon refinado', size: Size(390, 844))
Widget neonFreePlayPreview() => neonPreviewApp(NeonPreviewScreen.freeClues);
@Preview(name: 'Game night packs', group: 'Neon refinado', size: Size(390, 844))
Widget neonPacksPreview() => neonPreviewApp(NeonPreviewScreen.packs);

@Preview(name: 'Onboarding', group: 'Neon refinado', size: Size(390, 844))
Widget onboardingPreview() => neonPreviewApp(NeonPreviewScreen.onboarding);
