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
      id: 'fixture.ball',
      categoryId: 'sports',
      language: 'en',
      text: 'Ball',
    ),
  ];
}

/// Presentation catalog only: Premium words arrive in stage five.
class ClassicCategory {
  const ClassicCategory(this.id, this.name, this.emoji, {this.premium = false});
  final String id;
  final String name;
  final String emoji;
  final bool premium;
}

const classicCategories = <ClassicCategory>[
  ClassicCategory('food', 'Food & Drinks', '🍕'),
  ClassicCategory('animals', 'Animals', '🦁'),
  ClassicCategory('sports', 'Sports', '⚽'),
  ClassicCategory('movies', 'Movies & TV', '🎬', premium: true),
  ClassicCategory('music', 'Music & Bands', '🎵', premium: true),
  ClassicCategory('travel', 'Countries & Cities', '🌎', premium: true),
  ClassicCategory('famous', 'Famous People', '🌟', premium: true),
  ClassicCategory('objects', 'Everyday Objects', '🛋️', premium: true),
  ClassicCategory('brands', 'Brands & Logos', '🏷️', premium: true),
  ClassicCategory('jobs', 'Jobs & Professions', '🧑‍🍳', premium: true),
  ClassicCategory('hobbies', 'Hobbies & Activities', '🎨', premium: true),
  ClassicCategory('places', 'Places Around Town', '🏙️', premium: true),
  ClassicCategory('nature', 'Nature & Outdoors', '🌲', premium: true),
  ClassicCategory('technology', 'Tech & Gadgets', '🎧', premium: true),
  ClassicCategory('fashion', 'Fashion & Style', '👟', premium: true),
  ClassicCategory('transport', 'On the Move', '🚲', premium: true),
  ClassicCategory('school', 'School Days', '🎒', premium: true),
  ClassicCategory('games', 'Games & Toys', '🎲', premium: true),
  ClassicCategory('us_backyard', 'Backyard & BBQ', '🍔', premium: true),
  ClassicCategory('us_roadtrip', 'Road Trip USA', '🚗', premium: true),
  ClassicCategory('us_holidays', 'Holiday Hangouts', '🎉', premium: true),
  ClassicCategory('sweet', 'Sweet Tooth', '🍩', premium: true),
  ClassicCategory('ocean', 'Ocean & Beach', '🏖️', premium: true),
];
