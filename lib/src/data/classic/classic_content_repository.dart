import '../../domain/classic/classic_models.dart';

/// Initial offline English catalog. Full editorial launch catalog arrives in stage five.
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
      id: 'classic.food.pizza',
      categoryId: 'food',
      language: 'en',
      text: 'Pizza',
    ),
    ClassicWord(
      id: 'classic.food.pancakes',
      categoryId: 'food',
      language: 'en',
      text: 'Pancakes',
    ),
    ClassicWord(
      id: 'classic.food.popcorn',
      categoryId: 'food',
      language: 'en',
      text: 'Popcorn',
    ),
    ClassicWord(
      id: 'classic.food.sushi',
      categoryId: 'food',
      language: 'en',
      text: 'Sushi',
    ),
    ClassicWord(
      id: 'classic.food.tacos',
      categoryId: 'food',
      language: 'en',
      text: 'Tacos',
    ),
    ClassicWord(
      id: 'classic.food.ice_cream',
      categoryId: 'food',
      language: 'en',
      text: 'Ice cream',
    ),
    ClassicWord(
      id: 'classic.food.spaghetti',
      categoryId: 'food',
      language: 'en',
      text: 'Spaghetti',
    ),
    ClassicWord(
      id: 'classic.food.watermelon',
      categoryId: 'food',
      language: 'en',
      text: 'Watermelon',
    ),
    ClassicWord(
      id: 'classic.food.cheese',
      categoryId: 'food',
      language: 'en',
      text: 'Cheese',
    ),
    ClassicWord(
      id: 'classic.food.chocolate',
      categoryId: 'food',
      language: 'en',
      text: 'Chocolate',
    ),
    ClassicWord(
      id: 'classic.food.hamburger',
      categoryId: 'food',
      language: 'en',
      text: 'Hamburger',
    ),
    ClassicWord(
      id: 'classic.food.lemonade',
      categoryId: 'food',
      language: 'en',
      text: 'Lemonade',
    ),
    ClassicWord(
      id: 'classic.animals.elephant',
      categoryId: 'animals',
      language: 'en',
      text: 'Elephant',
    ),
    ClassicWord(
      id: 'classic.animals.penguin',
      categoryId: 'animals',
      language: 'en',
      text: 'Penguin',
    ),
    ClassicWord(
      id: 'classic.animals.dolphin',
      categoryId: 'animals',
      language: 'en',
      text: 'Dolphin',
    ),
    ClassicWord(
      id: 'classic.animals.giraffe',
      categoryId: 'animals',
      language: 'en',
      text: 'Giraffe',
    ),
    ClassicWord(
      id: 'classic.animals.kangaroo',
      categoryId: 'animals',
      language: 'en',
      text: 'Kangaroo',
    ),
    ClassicWord(
      id: 'classic.animals.butterfly',
      categoryId: 'animals',
      language: 'en',
      text: 'Butterfly',
    ),
    ClassicWord(
      id: 'classic.animals.octopus',
      categoryId: 'animals',
      language: 'en',
      text: 'Octopus',
    ),
    ClassicWord(
      id: 'classic.animals.turtle',
      categoryId: 'animals',
      language: 'en',
      text: 'Turtle',
    ),
    ClassicWord(
      id: 'classic.animals.rabbit',
      categoryId: 'animals',
      language: 'en',
      text: 'Rabbit',
    ),
    ClassicWord(
      id: 'classic.animals.lion',
      categoryId: 'animals',
      language: 'en',
      text: 'Lion',
    ),
    ClassicWord(
      id: 'classic.animals.panda',
      categoryId: 'animals',
      language: 'en',
      text: 'Panda',
    ),
    ClassicWord(
      id: 'classic.animals.flamingo',
      categoryId: 'animals',
      language: 'en',
      text: 'Flamingo',
    ),
    ClassicWord(
      id: 'classic.sports.basketball',
      categoryId: 'sports',
      language: 'en',
      text: 'Basketball',
    ),
    ClassicWord(
      id: 'classic.sports.swimming',
      categoryId: 'sports',
      language: 'en',
      text: 'Swimming',
    ),
    ClassicWord(
      id: 'classic.sports.tennis',
      categoryId: 'sports',
      language: 'en',
      text: 'Tennis',
    ),
    ClassicWord(
      id: 'classic.sports.soccer',
      categoryId: 'sports',
      language: 'en',
      text: 'Soccer',
    ),
    ClassicWord(
      id: 'classic.sports.baseball',
      categoryId: 'sports',
      language: 'en',
      text: 'Baseball',
    ),
    ClassicWord(
      id: 'classic.sports.volleyball',
      categoryId: 'sports',
      language: 'en',
      text: 'Volleyball',
    ),
    ClassicWord(
      id: 'classic.sports.surfing',
      categoryId: 'sports',
      language: 'en',
      text: 'Surfing',
    ),
    ClassicWord(
      id: 'classic.sports.boxing',
      categoryId: 'sports',
      language: 'en',
      text: 'Boxing',
    ),
    ClassicWord(
      id: 'classic.sports.cycling',
      categoryId: 'sports',
      language: 'en',
      text: 'Cycling',
    ),
    ClassicWord(
      id: 'classic.sports.skiing',
      categoryId: 'sports',
      language: 'en',
      text: 'Skiing',
    ),
    ClassicWord(
      id: 'classic.sports.golf',
      categoryId: 'sports',
      language: 'en',
      text: 'Golf',
    ),
    ClassicWord(
      id: 'classic.sports.skateboarding',
      categoryId: 'sports',
      language: 'en',
      text: 'Skateboarding',
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
