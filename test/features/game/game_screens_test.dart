import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/l10n/generated/app_localizations.dart';
import 'package:outoftheloop/src/domain/services/vote_scoring_service.dart';
import 'package:outoftheloop/src/features/game/final_leaderboard_screen.dart';
import 'package:outoftheloop/src/features/game/question_round_screen.dart';
import 'package:outoftheloop/src/features/game/guess_screen.dart';
import 'package:outoftheloop/src/features/game/round_results_screen.dart';
import 'package:outoftheloop/src/features/game/secret_reveal_screen.dart';
import 'package:outoftheloop/src/features/game/voting_screen.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

import '../../app/app_test_helpers.dart';

void main() {
  testWidgets('secret reveal hides and clears player role between turns', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TestApp(
        child: SecretRevealScreen(players: _players, round: _round),
      ),
    );

    expect(find.text('Pizza'), findsNothing);
    expect(find.textContaining('OUT of the loop'), findsNothing);

    await tester.tap(find.text('REVEAL MY ROLE'));
    await tester.pumpAndSettle();

    expect(find.text('Pizza'), findsOneWidget);

    await tester.tap(find.text('NEXT PLAYER'));
    await tester.pumpAndSettle();

    expect(find.text('Pizza'), findsNothing);
    expect(find.text('Bia'), findsWidgets);

    await tester.tap(find.text('REVEAL MY ROLE'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('OUT of the loop'),
      findsOneWidget,
    );
  });

  testWidgets('question round confirms before leaving the match', (
    tester,
  ) async {
    var cancelled = false;

    await tester.pumpWidget(
      _TestApp(
        child: QuestionRoundScreen(
          players: _players,
          questionTurns: _questionTurns(
            players: _players,
            questions: [_questions.first],
            playerOrder: const ['p1'],
          ),
          onBack: () => cancelled = true,
        ),
      ),
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Leave the match?'), findsOneWidget);
    expect(cancelled, isFalse);

    await tester.tap(find.text('KEEP PLAYING'));
    await tester.pumpAndSettle();

    expect(find.text('Leave the match?'), findsNothing);
    expect(cancelled, isFalse);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('LEAVE MATCH'));
    await tester.pumpAndSettle();

    expect(cancelled, isTrue);
  });

  testWidgets('question round advances through turns on one screen', (
    tester,
  ) async {
    var completed = false;

    await tester.pumpWidget(
      _TestApp(
        child: QuestionRoundScreen(
          players: _players,
          questionTurns: _questionTurns(
            players: _players,
            questions: _questions,
            playerOrder: const ['p1', 'p2', 'p3'],
          ),
          onComplete: () => completed = true,
        ),
      ),
    );

    expect(find.text("Ana's turn"), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    expect(find.text('NEXT QUESTION'), findsOneWidget);

    await tester.tap(find.text('NEXT QUESTION'));
    await tester.pumpAndSettle();

    expect(find.text("Bia's turn"), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    await tester.tap(find.text('NEXT QUESTION'));
    await tester.pumpAndSettle();

    expect(find.text("Caio's turn"), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    await tester.tap(find.text('GO TO VOTING'));
    await tester.pump();

    expect(completed, isTrue);
  });

  testWidgets('question round supports multiple turns per player', (
    tester,
  ) async {
    var completed = false;
    final players = _players.take(3).toList();
    final questions = List.generate(
      6,
      (index) => Question(
        id: 'q$index',
        wordId: 'pizza',
        text: LocalizedText({
          SupportedLanguage.ptBr: 'Question ${index + 1}',
          SupportedLanguage.en: 'Question ${index + 1}',
          SupportedLanguage.es: 'Question ${index + 1}',
          SupportedLanguage.hi: 'Question ${index + 1}',
        }),
      ),
    );

    await tester.pumpWidget(
      _TestApp(
        child: QuestionRoundScreen(
          players: players,
          questionTurns: _questionTurns(
            players: players,
            questions: questions,
            playerOrder: const ['p1', 'p2', 'p3', 'p1', 'p2', 'p3'],
          ),
          onComplete: () => completed = true,
        ),
      ),
    );

    expect(find.text("Ana's turn"), findsOneWidget);

    await _advanceQuestion(tester);
    expect(find.text("Bia's turn"), findsOneWidget);

    await _advanceQuestion(tester);
    expect(find.text("Caio's turn"), findsOneWidget);

    await _advanceQuestion(tester);
    expect(find.text("Ana's turn"), findsOneWidget);

    await _advanceQuestion(tester);
    await _advanceQuestion(tester);
    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    await tester.tap(find.text('GO TO VOTING'));
    await tester.pump();

    expect(completed, isTrue);
  });

  testWidgets('voting confirms before leaving the match', (tester) async {
    var cancelled = false;

    await tester.pumpWidget(
      _TestApp(
        child: VotingScreen(
          players: _players,
          onBack: () => cancelled = true,
        ),
      ),
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Leave the match?'), findsOneWidget);
    expect(cancelled, isFalse);

    await tester.tap(find.text('LEAVE MATCH'));
    await tester.pumpAndSettle();

    expect(cancelled, isTrue);
  });

  testWidgets('voting collects one hidden vote per player', (tester) async {
    List<Vote>? votes;

    await tester.pumpWidget(
      _TestApp(
        child: VotingScreen(
          players: _players,
          onComplete: (value) => votes = value,
        ),
      ),
    );

    expect(find.text('WHO IS'), findsWidgets);

    for (var vote = 0; vote < 3; vote += 1) {
      await tapFirstEnabledVote(tester);
    }

    expect(find.text('YOU'), findsOneWidget);
    expect(find.text('CANNOT VOTE SELF'), findsOneWidget);

    expect(find.text('CONFIRM VOTES'), findsOneWidget);
    await tester.tap(find.text('CONFIRM VOTES'));
    await tester.pump();

    expect(votes, hasLength(3));
  });

  testWidgets('round results confirms before leaving the match', (tester) async {
    var cancelled = false;
    final service = VoteScoringService();
    final round = _roundWithVotes;
    final result = service.calculateRoundResult(round: round, players: _players);

    await tester.pumpWidget(
      _TestApp(
        child: RoundResultsScreen(
          players: _players,
          round: round,
          result: result,
          onBack: () => cancelled = true,
        ),
      ),
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Leave the match?'), findsOneWidget);
    await tester.tap(find.text('KEEP PLAYING'));
    await tester.pumpAndSettle();

    expect(cancelled, isFalse);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('LEAVE MATCH'));
    await tester.pumpAndSettle();

    expect(cancelled, isTrue);
  });

  testWidgets('round results show discovered and guess branches', (
    tester,
  ) async {
    final service = VoteScoringService();
    final discoveredRound = RoundState(
      roundNumber: 1,
      outPlayerId: 'p2',
      secretWord: _word,
      questions: _questions,
      questionTurns: _questionTurns(
        players: _players,
        questions: _questions,
        playerOrder: const ['p1', 'p2', 'p3'],
      ),
      phase: RoundPhase.results,
      votes: const [
        Vote(voterId: 'p1', suspectId: 'p2'),
        Vote(voterId: 'p2', suspectId: 'p1'),
        Vote(voterId: 'p3', suspectId: 'p2'),
      ],
    );
    final discovered = service.calculateRoundResult(
      round: discoveredRound,
      players: _players,
    );

    await tester.pumpWidget(
      _TestApp(
        child: RoundResultsScreen(
          players: _players,
          round: discoveredRound,
          result: discovered,
        ),
      ),
    );

    expect(find.text('Bia'), findsWidgets);
    expect(
      find.text('The group found the out player by majority.'),
      findsOneWidget,
    );
    expect(find.text('THE SECRET WORD WAS:'), findsOneWidget);
    expect(find.text('PIZZA'), findsOneWidget);
    expect(find.text('+125'), findsWidgets);

    await tester.pumpWidget(
      _TestApp(
        child: RoundResultsScreen(
          players: _players,
          round: discoveredRound,
          result: discovered,
          totalRoundCount: 3,
          language: SupportedLanguage.en,
        ),
      ),
    );
    expect(find.text('GO TO ROUND 2'), findsOneWidget);

    final finalDiscoveredRound = RoundState(
      roundNumber: 3,
      outPlayerId: discoveredRound.outPlayerId,
      secretWord: discoveredRound.secretWord,
      questions: discoveredRound.questions,
      questionTurns: discoveredRound.questionTurns,
      phase: discoveredRound.phase,
      votes: discoveredRound.votes,
    );
    await tester.pumpWidget(
      _TestApp(
        child: RoundResultsScreen(
          players: _players,
          round: finalDiscoveredRound,
          result: discovered,
          totalRoundCount: 3,
          language: SupportedLanguage.en,
        ),
      ),
    );
    expect(find.text('VIEW FINAL SCORE'), findsOneWidget);

    final escaped = service.calculateRoundResult(
      round: _roundWithVotes,
      players: _players,
    );
    await tester.pumpWidget(
      _TestApp(
        child: RoundResultsScreen(
          players: _players,
          round: _roundWithVotes,
          result: escaped,
          language: SupportedLanguage.en,
        ),
      ),
    );
    expect(escaped.wasOutFoundByMajority, isFalse);
    expect(
      find.text('The out player escaped the majority vote.'),
      findsOneWidget,
    );
    expect(find.text('GUESS THE WORD'), findsOneWidget);
    expect(find.text('THE SECRET WORD WAS:'), findsNothing);
    expect(find.text('PIZZA'), findsNothing);

    RoundResult? guessedResult;
    await tester.pumpWidget(
      _TestApp(
        child: GuessScreen(
          players: _players,
          round: _roundWithVotes,
          onResolved: (result) => guessedResult = result,
        ),
      ),
    );

    await tester.tap(find.text('GOT IT RIGHT'));
    await tester.pump();

    expect(
      guessedResult!.scoreEvents.any(
        (event) =>
            event.playerId == 'p2' &&
            event.points == 125 &&
            event.reason == ScoreReasons.outPlayerGuessedWord,
      ),
      isTrue,
    );
  });

  testWidgets('final leaderboard sorts players and exposes exit actions', (
    tester,
  ) async {
    var newMatch = false;
    var backHome = false;
    final secretWord = SecretWord(
      id: 'donut',
      categoryId: 'food',
      value: const LocalizedText({
        SupportedLanguage.en: 'Doughnut',
        SupportedLanguage.ptBr: 'Rosquinha',
        SupportedLanguage.es: 'Dona',
        SupportedLanguage.hi: 'डोनट',
      }),
      questions: const [],
    );

    await tester.pumpWidget(
      _TestApp(
        child: FinalLeaderboardScreen(
          players: const [
            Player(id: 'p1', name: 'Ana', avatarSeed: 'ana', totalScore: 50),
            Player(id: 'p2', name: 'Bia', avatarSeed: 'bia', totalScore: 200),
            Player(id: 'p3', name: 'Caio', avatarSeed: 'caio', totalScore: 75),
          ],
          secretWord: secretWord,
          outPlayer: const Player(
            id: 'p3',
            name: 'Caio',
            avatarSeed: 'caio',
            totalScore: 75,
          ),
          language: SupportedLanguage.en,
          onNewMatch: () => newMatch = true,
          onBackHome: () => backHome = true,
        ),
      ),
    );

    expect(find.text('Bia wins!'), findsOneWidget);
    expect(find.text('THE MASTERMIND'), findsOneWidget);
    expect(find.text('THE SECRET WORD WAS:'), findsOneWidget);
    expect(find.text('DOUGHNUT'), findsOneWidget);
    expect(find.text('Caio was Out of the Loop!'), findsOneWidget);
    expect(find.text('LEADERBOARD'), findsOneWidget);
    expect(find.text('PLAY AGAIN'), findsOneWidget);
    expect(find.text('BACK TO HOME'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('PLAY AGAIN'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('PLAY AGAIN'));
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('BACK TO HOME'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('BACK TO HOME'));
    await tester.pump();

    expect(newMatch, isTrue);
    expect(backHome, isTrue);
  });
}

Future<void> _advanceQuestion(WidgetTester tester) async {
  await tester.tap(find.text('DONE ANSWERING'));
  await tester.pump();
  await tester.tap(find.text('NEXT QUESTION'));
  await tester.pumpAndSettle();
}

List<QuestionTurn> _questionTurns({
  required List<Player> players,
  required List<Question> questions,
  required List<String> playerOrder,
}) {
  return List.generate(
    questions.length,
    (index) => QuestionTurn(
      question: questions[index],
      playerId: playerOrder[index],
    ),
  );
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OutOfTheLoopTheme.dark,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
  }
}

const _players = [
  Player(id: 'p1', name: 'Ana', avatarSeed: 'ana'),
  Player(id: 'p2', name: 'Bia', avatarSeed: 'bia'),
  Player(id: 'p3', name: 'Caio', avatarSeed: 'caio'),
];

final _questions = List.generate(
  3,
  (index) => Question(
    id: 'q$index',
    wordId: 'pizza',
    text: LocalizedText({
      SupportedLanguage.ptBr: 'Question ${index + 1}',
      SupportedLanguage.en: 'Question ${index + 1}',
      SupportedLanguage.es: 'Question ${index + 1}',
      SupportedLanguage.hi: 'Question ${index + 1}',
    }),
  ),
);

final _word = SecretWord(
  id: 'pizza',
  categoryId: 'food',
  value: const LocalizedText({
    SupportedLanguage.ptBr: 'Pizza',
    SupportedLanguage.en: 'Pizza',
    SupportedLanguage.es: 'Pizza',
    SupportedLanguage.hi: 'Pizza',
  }),
  questions: _questions,
);

final _round = RoundState(
  roundNumber: 1,
  outPlayerId: 'p2',
  secretWord: _word,
  questions: _questions,
  questionTurns: _questionTurns(
    players: _players,
    questions: _questions,
    playerOrder: const ['p1', 'p2', 'p3'],
  ),
  phase: RoundPhase.reveal,
);

final _roundWithVotes = RoundState(
  roundNumber: 1,
  outPlayerId: 'p2',
  secretWord: _word,
  questions: _questions,
  questionTurns: _questionTurns(
    players: _players,
    questions: _questions,
    playerOrder: const ['p1', 'p2', 'p3'],
  ),
  phase: RoundPhase.results,
  votes: const [
    Vote(voterId: 'p1', suspectId: 'p3'),
    Vote(voterId: 'p2', suspectId: 'p1'),
    Vote(voterId: 'p3', suspectId: 'p1'),
  ],
);
