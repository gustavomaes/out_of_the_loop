import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/vote_scoring_service.dart';
import 'package:outoftheloop/src/features/game/final_leaderboard_screen.dart';
import 'package:outoftheloop/src/features/game/question_round_screen.dart';
import 'package:outoftheloop/src/features/game/round_results_screen.dart';
import 'package:outoftheloop/src/features/game/secret_reveal_screen.dart';
import 'package:outoftheloop/src/features/game/voting_screen.dart';
import 'package:outoftheloop/src/shared/widgets/shared_widgets.dart';
import 'package:outoftheloop/src/theme/app_tokens.dart';

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
    expect(find.textContaining('FORA'), findsNothing);

    await tester.tap(find.text('VIEW MY WORD'));
    await tester.pumpAndSettle();

    expect(find.text('Pizza'), findsOneWidget);

    await tester.tap(find.text('NEXT PLAYER'));
    await tester.pumpAndSettle();

    expect(find.text('Pizza'), findsNothing);
    expect(find.text('Bia\'s turn'), findsOneWidget);

    await tester.tap(find.text('VIEW MY WORD'));
    await tester.pumpAndSettle();

    expect(find.textContaining('FORA'), findsOneWidget);
  });

  testWidgets('question round advances through player questions', (
    tester,
  ) async {
    var completed = false;

    await tester.pumpWidget(
      _TestApp(
        child: QuestionRoundScreen(
          players: _players,
          questions: _questions,
          onComplete: () => completed = true,
        ),
      ),
    );

    expect(find.text('Ana answers'), findsOneWidget);
    expect(find.text('QUESTION 1 OF 3'), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();

    expect(find.text('Bia answers'), findsOneWidget);
    expect(find.text('QUESTION 2 OF 3'), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    await tester.tap(find.text('GO TO VOTING'));
    await tester.pump();

    expect(completed, isTrue);
  });

  testWidgets('question round rotates players across multiple rounds', (
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
          questions: questions,
          onComplete: () => completed = true,
        ),
      ),
    );

    expect(find.text('QUESTION 1 OF 6'), findsOneWidget);
    expect(find.text('Ana answers'), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    expect(find.text('Bia answers'), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    expect(find.text('Caio answers'), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    expect(find.text('Ana answers'), findsOneWidget);
    expect(find.text('QUESTION 4 OF 6'), findsOneWidget);

    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    await tester.tap(find.text('DONE ANSWERING'));
    await tester.pump();
    await tester.tap(find.text('GO TO VOTING'));
    await tester.pump();

    expect(completed, isTrue);
  });

  testWidgets(
    'question round uses configured timer and allows expired advance',
    (tester) async {
      var completed = false;

      await tester.pumpWidget(
        _TestApp(
          child: QuestionRoundScreen(
            players: _players,
            questions: [_questions.first],
            timerSettings: const TimerSettings(durationSeconds: 12),
            remainingSeconds: 0,
            onComplete: () => completed = true,
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget);
      expect(
        find.text('Time is up. Finish this answer when ready.'),
        findsOneWidget,
      );

      await tester.tap(find.text('GO TO VOTING'));
      await tester.pump();

      expect(completed, isTrue);
    },
  );

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

    expect(find.text('Ana, choose secretly.'), findsOneWidget);
    await _tapVoteButtonFor(tester, 'Bia');
    await tester.tap(find.text('CONFIRM VOTE'));
    await tester.pump();

    expect(find.text('Bia, choose secretly.'), findsOneWidget);
    expect(find.text('SELECTED'), findsNothing);

    await _tapVoteButtonFor(tester, 'Ana');
    await tester.tap(find.text('CONFIRM VOTE'));
    await tester.pump();

    await _tapVoteButtonFor(tester, 'Ana');
    await tester.tap(find.text('CONFIRM VOTE'));
    await tester.pump();

    expect(
      find.text('All votes are in. Reveal the totals next.'),
      findsOneWidget,
    );
    await tester.tap(find.text('CONFIRM VOTES'));
    await tester.pump();

    expect(votes, hasLength(3));
  });

  testWidgets('voting uses configured timer and expiration records no vote', (
    tester,
  ) async {
    List<Vote>? votes;

    await tester.pumpWidget(
      _TestApp(
        child: VotingScreen(
          players: _players,
          timerSettings: const TimerSettings(durationSeconds: 12),
          remainingSeconds: 0,
          onComplete: (value) => votes = value,
        ),
      ),
    );

    expect(
      find.text('Time is up. No vote was recorded automatically.'),
      findsOneWidget,
    );
    expect(find.text('CONFIRM VOTE'), findsOneWidget);
    expect(
      tester.widget<OtlButton>(find.byType(OtlButton).last).onPressed,
      isNull,
    );

    expect(votes, isNull);
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
    expect(find.text('+125'), findsWidgets);

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

    await tester.tap(find.text('ACERTOU'));
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

    await tester.pumpWidget(
      _TestApp(
        child: FinalLeaderboardScreen(
          players: const [
            Player(id: 'p1', name: 'Ana', avatarSeed: 'ana', totalScore: 50),
            Player(id: 'p2', name: 'Bia', avatarSeed: 'bia', totalScore: 200),
            Player(id: 'p3', name: 'Caio', avatarSeed: 'caio', totalScore: 75),
          ],
          onNewMatch: () => newMatch = true,
          onBackHome: () => backHome = true,
        ),
      ),
    );

    expect(find.text('Bia wins!'), findsOneWidget);
    expect(find.text('NOVA PARTIDA'), findsOneWidget);
    expect(find.text('VOLTAR AO INICIO'), findsOneWidget);

    await tester.tap(find.text('NOVA PARTIDA'));
    await tester.pump();
    await tester.tap(find.text('VOLTAR AO INICIO'));
    await tester.pump();

    expect(newMatch, isTrue);
    expect(backHome, isTrue);
  });
}

Future<void> _tapVoteButtonFor(WidgetTester tester, String playerName) async {
  final card = find.ancestor(
    of: find.text(playerName),
    matching: find.byType(AnimatedContainer),
  );
  final voteButton = find.descendant(of: card, matching: find.text('VOTE'));
  await tester.tap(voteButton);
  await tester.pump();
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: OutOfTheLoopTheme.dark, home: child);
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
  phase: RoundPhase.reveal,
);

final _roundWithVotes = RoundState(
  roundNumber: 1,
  outPlayerId: 'p2',
  secretWord: _word,
  questions: _questions,
  phase: RoundPhase.results,
  votes: const [
    Vote(voterId: 'p1', suspectId: 'p3'),
    Vote(voterId: 'p2', suspectId: 'p1'),
    Vote(voterId: 'p3', suspectId: 'p1'),
  ],
);
