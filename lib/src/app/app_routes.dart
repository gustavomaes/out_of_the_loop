abstract final class AppRoutes {
  static const home = '/';
  static const categories = '/categories';
  static const players = '/players';
  static const gameReveal = '/game/reveal';
  static const gameQuestions = '/game/questions';
  static const gameVote = '/game/vote';
  static const gameResults = '/game/results';
  static const gameGuess = '/game/guess';
  static const gameFinal = '/game/final';
  static const howToPlay = '/how-to-play';
  static const settings = '/settings';

  static const all = <String>[
    home,
    categories,
    players,
    gameReveal,
    gameQuestions,
    gameVote,
    gameResults,
    gameGuess,
    gameFinal,
    howToPlay,
    settings,
  ];

  static const bottomNavigationRoutes = <String>[
    home,
    categories,
    howToPlay,
    settings,
  ];
}
