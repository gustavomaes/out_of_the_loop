import '../../domain/classic/classic_models.dart';

/// Offline development fixture, not the commercial launch catalog.
class ClassicContentRepository {
  const ClassicContentRepository();
  List<ClassicWord> wordsFor(ClassicConfig config) => fixture
      .where(
        (word) =>
            word.language == config.contentLanguage &&
            config.categoryIds.contains(word.categoryId),
      )
      .toList(growable: false);

  static const fixture = [
    ClassicWord(
      id: 'fixture.apple',
      categoryId: 'food',
      language: 'en',
      text: 'Apple',
    ),
    ClassicWord(
      id: 'fixture.cat',
      categoryId: 'animals',
      language: 'en',
      text: 'Cat',
    ),
    ClassicWord(
      id: 'fixture.beach',
      categoryId: 'places',
      language: 'en',
      text: 'Beach',
    ),
  ];
}
