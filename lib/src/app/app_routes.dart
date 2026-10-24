abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/';
  static const categories = '/categories';
  static const matchSetup = '/match-setup';
  static const players = '/players';
  static const gameReveal = '/game/reveal';
  static const gameReady = '/game/ready';
  static const gameQuestions = '/game/questions';
  static const gameVote = '/game/vote';
  static const gameResults = '/game/results';
  static const gameGuess = '/game/guess';
  static const gameFinal = '/game/final';
  static const howToPlay = '/how-to-play';
  static const settings = '/settings';
  static const packs = '/packs';

  static const all = <String>[
    home,
    categories,
    matchSetup,
    players,
    gameReveal,
    gameReady,
    gameQuestions,
    gameVote,
    gameResults,
    gameGuess,
    gameFinal,
    howToPlay,
    settings,
    packs,
    onboarding,
  ];

  static const bottomNavigationRoutes = <String>[home, categories, settings];
}
