import 'package:flutter_test/flutter_test.dart';
import 'package:outoftheloop/src/domain/models/models.dart';
import 'package:outoftheloop/src/domain/services/match_setup_service.dart';

void main() {
  group('MatchSetupService', () {
    const service = MatchSetupService();

    test('rejects 2 players and allows 3 and 9 players', () {
      expect(
        service
            .validate(
              players: _players(2),
              roundCount: 1,
              categoryWords: [_word('pizza', questionCount: 3)],
            )
            .errors,
        contains(MatchSetupValidationError.tooFewPlayers),
      );

      expect(
        service
            .validate(
              players: _players(3),
              roundCount: 1,
              categoryWords: [_word('pizza', questionCount: 3)],
            )
            .canStart,
        isTrue,
      );

      expect(
        service
            .validate(
              players: _players(9),
              roundCount: 1,
              categoryWords: [_word('pizza', questionCount: 9)],
            )
            .canStart,
        isTrue,
      );
    });

    test('rejects 10 players', () {
      final result = service.validate(
        players: _players(10),
        roundCount: 1,
        categoryWords: [_word('pizza', questionCount: 10)],
      );

      expect(result.errors, contains(MatchSetupValidationError.tooManyPlayers));
    });

    test('rejects empty and duplicate names', () {
      final result = service.validate(
        players: [
          _player('p1', 'Ana'),
          _player('p2', ' ana '),
          _player('p3', ' '),
        ],
        roundCount: 1,
        categoryWords: [_word('pizza', questionCount: 3)],
      );

      expect(
        result.errors,
        containsAll([
          MatchSetupValidationError.duplicatePlayerName,
          MatchSetupValidationError.emptyPlayerName,
        ]),
      );
    });

    test('validates round count against playable content capacity', () {
      final result = service.validate(
        players: _players(4),
        roundCount: 2,
        categoryWords: [
          _word('pizza', questionCount: 4),
          _word('sushi', questionCount: 3),
        ],
      );

      expect(
        result.errors,
        contains(MatchSetupValidationError.insufficientPlayableWords),
      );
    });
  });
}

List<Player> _players(int count) =>
    List.generate(count, (index) => _player('p$index', 'Player $index'));

Player _player(String id, String name) =>
    Player(id: id, name: name, avatarSeed: id);

SecretWord _word(String id, {required int questionCount}) {
  return SecretWord(
    id: id,
    categoryId: 'food',
    value: _localized(id),
    questions: List.generate(
      questionCount,
      (index) => Question(
        id: '$id-q$index',
        wordId: id,
        text: _localized('Question $index'),
      ),
    ),
  );
}

LocalizedText _localized(String value) => LocalizedText({
  SupportedLanguage.ptBr: value,
  SupportedLanguage.en: value,
  SupportedLanguage.es: value,
  SupportedLanguage.hi: value,
});
