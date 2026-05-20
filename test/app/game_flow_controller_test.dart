import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/app/game_flow_controller.dart';
import 'package:outoftheloop/src/domain/models/models.dart';

void main() {
  group('GameFlowController rematch', () {
    late GameFlowController flow;

    const players = [
      Player(id: 'p1', name: 'Ana', avatarSeed: 'ana', totalScore: 40),
      Player(id: 'p2', name: 'Bia', avatarSeed: 'bia', totalScore: 120),
      Player(id: 'p3', name: 'Caio', avatarSeed: 'caio', totalScore: 10),
    ];

    setUp(() {
      flow = GameFlowController();
      flow.selectedCategory = const Category(
        id: 'food',
        name: LocalizedText({SupportedLanguage.en: 'Food'}),
        primaryArgb: 0xFF000000,
        secondaryArgb: 0xFF000000,
      );
      flow.categoryWords = [
        _word('w1', questionCount: 12),
        _word('w2', questionCount: 12),
        _word('w3', questionCount: 12),
      ];
      flow.startMatch(
        players,
        roundCount: 2,
        questionsPerPlayer: 2,
      );
    });

    test('rematchKeepingCategory starts a fresh match with same setup', () {
      flow.rematchKeepingCategory();

      expect(flow.hasActiveRound, isTrue);
      expect(flow.setup?.roundCount, 2);
      expect(flow.setup?.questionsPerPlayer, 2);
      expect(flow.setup?.categoryId, 'food');
      expect(
        flow.players.map((player) => player.totalScore),
        everyElement(0),
      );
      expect(flow.players.map((player) => player.name), ['Ana', 'Bia', 'Caio']);
    });

    test('prepareRematchWithNewCategory stashes players and clears category', () {
      flow.prepareRematchWithNewCategory();

      expect(flow.hasRematchCarryOver, isTrue);
      expect(flow.rematchCarryOver?.roundCount, 2);
      expect(flow.rematchCarryOver?.questionsPerPlayer, 2);
      expect(
        flow.rematchCarryOver?.players.map((player) => player.name),
        ['Ana', 'Bia', 'Caio'],
      );
      expect(
        flow.rematchCarryOver?.players.map((player) => player.totalScore),
        everyElement(0),
      );
      expect(flow.selectedCategory, isNull);
      expect(flow.categoryWords, isEmpty);
      expect(flow.hasActiveRound, isFalse);
    });

    test('resetMatch clears rematch carry over', () {
      flow.prepareRematchWithNewCategory();
      flow.resetMatch();

      expect(flow.hasRematchCarryOver, isFalse);
    });
  });
}

SecretWord _word(String id, {required int questionCount}) {
  return SecretWord(
    id: id,
    categoryId: 'food',
    value: const LocalizedText({
      SupportedLanguage.en: 'Word',
      SupportedLanguage.ptBr: 'Palavra',
      SupportedLanguage.es: 'Palabra',
      SupportedLanguage.hi: 'Word',
    }),
    questions: List.generate(
      questionCount,
      (index) => Question(
        id: '$id-q$index',
        wordId: id,
        text: const LocalizedText({
          SupportedLanguage.en: 'Question',
          SupportedLanguage.ptBr: 'Pergunta',
          SupportedLanguage.es: 'Pregunta',
          SupportedLanguage.hi: 'Question',
        }),
      ),
    ),
  );
}
