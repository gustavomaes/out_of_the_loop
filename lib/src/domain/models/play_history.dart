import 'game_models.dart';

/// Ordered oldest to newest, scoped to language and category, bounded on write.
class PlayHistory {
  PlayHistory({
    Iterable<String> words = const [],
    Iterable<String> questions = const [],
  }) : words = List.of(words),
       questions = List.of(questions);
  final List<String> words;
  final List<String> questions;
  static String wordKey(
    SupportedLanguage language,
    String category,
    String word,
  ) => '${language.code}:$category:$word';
  static String questionKey(
    SupportedLanguage language,
    String category,
    String word,
    String question, {
    String? text,
  }) => text == null
      ? '${wordKey(language, category, word)}:$question'
      : '${language.code}:$category:text:${text.trim().toLowerCase().replaceAll(RegExp(r"\s+"), " ")}';
  void record(RoundState round, SupportedLanguage language) {
    final word = round.secretWord;
    _touch(words, wordKey(language, word.categoryId, word.id), 2000);
    for (final q in round.questions) {
      _touch(
        questions,
        questionKey(
          language,
          word.categoryId,
          word.id,
          q.id,
          text: q.text.valueFor(language),
        ),
        8000,
      );
    }
  }

  void clear() {
    words.clear();
    questions.clear();
  }

  static void _touch(List<String> target, String key, int limit) {
    target.remove(key);
    target.add(key);
    if (target.length > limit) target.removeRange(0, target.length - limit);
  }
}
