// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Out of the Loop';

  @override
  String get startGame => 'START GAME';

  @override
  String get navPlay => 'PLAY';

  @override
  String get navCategories => 'CATEGORIES';

  @override
  String get navProfile => 'PROFILE';

  @override
  String get howToPlay => 'HOW TO PLAY';

  @override
  String get pickCategory => 'Pick a Category';

  @override
  String get pickCategorySubtitle =>
      'Choose your battlefield. The loop awaits.';

  @override
  String get categoryFoodAndDrink => 'Food & Drink';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryMovies => 'Movies';

  @override
  String get categoryAnimals => 'Animals';

  @override
  String get categorySports => 'Sports';

  @override
  String get categoryTech => 'Tech';

  @override
  String get categoriesLoadError => 'Could not load categories.';

  @override
  String get addPlayer => 'Add player';

  @override
  String get addPlayerButton => 'ADD';

  @override
  String get playerSetupTitleLine1 => 'WHO WILL';

  @override
  String get playerSetupTitleLine2 => 'PLAY?';

  @override
  String get playerSetupPlayerCountBadge => '3-9 PLAYERS';

  @override
  String get playerNameHint => 'Player name';

  @override
  String get playerSetupStartGame => 'START GAME';

  @override
  String playerSetupRemovePlayer(String playerName) {
    return 'Remove $playerName';
  }

  @override
  String get playerSetupErrorEmptyName => 'Name cannot be empty.';

  @override
  String get playerSetupErrorDuplicateName => 'Player names must be unique.';

  @override
  String get playerSetupErrorTooManyPlayers =>
      'A match supports up to 9 players.';

  @override
  String get playerSetupErrorTooFewPlayers => 'Add at least 3 players.';

  @override
  String get playerSetupErrorInvalidRoundCount => 'Invalid round count.';

  @override
  String get playerSetupErrorInvalidQuestions =>
      'Choose between 1 and 3 questions per player.';

  @override
  String get playerSetupErrorInsufficientWords =>
      'This category does not have enough words for that many rounds.';

  @override
  String get playerSetupErrorInsufficientQuestions =>
      'This category does not have enough questions for that many players.';

  @override
  String get matchSetupTitleLine1 => 'SET UP';

  @override
  String get matchSetupTitleLine2 => 'MATCH';

  @override
  String get matchSetupRulesBadge => '1–5 ROUNDS · 1–3 QUESTIONS';

  @override
  String get matchSetupSubtitle => 'Set the rules before adding players.';

  @override
  String get matchSetupQuestionsSection => 'QUESTIONS PER PLAYER';

  @override
  String get matchSetupQuestionsDescription =>
      'How many questions does each player answer per round?';

  @override
  String matchSetupQuestionsRecommendation(int recommended) {
    return 'For 3–4 players we recommend $recommended; for 5 or more, 1 (up to 3 if the category allows).';
  }

  @override
  String get matchSetupRoundsSection => 'ROUNDS IN MATCH';

  @override
  String get matchSetupRoundsDescription =>
      'How many rounds will this match have?';

  @override
  String matchSetupRoundsRecommended(int count) {
    return 'Recommended: $count rounds.';
  }

  @override
  String matchSetupRoundsValue(int count) {
    return 'Rounds: $count';
  }

  @override
  String matchSetupQuestionCountChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '1 question',
    );
    return '$_temp0';
  }

  @override
  String matchSetupSummary(int roundCount, int questionCount) {
    String _temp0 = intl.Intl.pluralLogic(
      roundCount,
      locale: localeName,
      other: '$roundCount rounds',
      one: '1 round',
    );
    String _temp1 = intl.Intl.pluralLogic(
      questionCount,
      locale: localeName,
      other: '$questionCount questions',
      one: '1 question',
    );
    return '$_temp0 · $_temp1 per player';
  }

  @override
  String get matchSetupContinue => 'CONTINUE';

  @override
  String get startMatch => 'Start match';

  @override
  String get revealMyWord => 'Reveal my word';

  @override
  String get outOfLoopMessage => 'You are OUT of the loop - act naturally.';

  @override
  String get doneAnswering => 'Done answering';

  @override
  String get whoIsOutOfTheLoop => 'Who is out of the loop?';

  @override
  String get confirmVotes => 'Confirm votes';

  @override
  String get roundResults => 'Round results';

  @override
  String get guessWord => 'Guess the word';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Wrong';

  @override
  String get playAgain => 'Play again';

  @override
  String get backToHome => 'Back to home';

  @override
  String get settings => 'Settings';

  @override
  String get settingsScreenTitle => 'SETTINGS';

  @override
  String get settingsSectionLanguage => 'LANGUAGE';

  @override
  String get settingsSectionAudio => 'AUDIO';

  @override
  String get settingsSectionTimer => 'TIMER';

  @override
  String get settingsSectionAbout => 'ABOUT';

  @override
  String get settingsMusic => 'Music';

  @override
  String get settingsSoundEffects => 'Sound Effects';

  @override
  String get settingsTermsOfUse => 'Terms of Use';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsAppVersionLabel => 'App Version';

  @override
  String get settingsAppVersionValue => 'v0.1.0';

  @override
  String get settingsLanguagePortuguese => 'Portuguese';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Spanish';

  @override
  String get settingsLanguageHindi => 'Hindi';

  @override
  String get settingsUseTimer => 'Use timer';

  @override
  String settingsTimerSeconds(int seconds) {
    return '$seconds seconds per turn';
  }

  @override
  String get language => 'Language';

  @override
  String get timer => 'Timer';

  @override
  String get howToPlayScreenTitle => 'HOW TO PLAY';

  @override
  String get howToPlayKapow => 'KA-POW!';

  @override
  String get howToPlaySecretTitle => 'THE SECRET';

  @override
  String get howToPlaySecretBodyBefore =>
      'Every player sees the secret word, except one... who is ';

  @override
  String get howToPlaySecretBodyHighlight => 'Out of the Loop!';

  @override
  String get howToPlayQuestionTitle => 'THE QUESTION';

  @override
  String get howToPlayQuestionBodyBefore =>
      'Answer funny questions about the word without making it too obvious. ';

  @override
  String get howToPlayQuestionBodyEmphasis => 'Be clever!';

  @override
  String get howToPlayVoteTitle => 'THE VOTE';

  @override
  String get howToPlayVoteBodyBefore => 'Try to spot who knows nothing and ';

  @override
  String get howToPlayVoteBodyHighlight => 'VOTE!';

  @override
  String get howToPlayVoteBodyAfter => ' Point the finger with confidence.';

  @override
  String get howToPlayOutcomeTitle => 'THE FINALE';

  @override
  String get howToPlayOutcomeBodyBefore =>
      'If the Out of the Loop player guesses the word at the end, ';

  @override
  String get howToPlayOutcomeBodyHighlight => 'they win';

  @override
  String get howToPlayOutcomeBodyAfter => ' and become the mastermind!';
}
