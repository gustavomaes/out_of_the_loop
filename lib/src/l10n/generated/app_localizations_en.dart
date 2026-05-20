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
  String get revealMyWord => 'REVEAL MY ROLE';

  @override
  String secretRevealRound(int roundNumber) {
    return 'ROUND $roundNumber';
  }

  @override
  String get secretRevealPassTo => 'PASS TO';

  @override
  String secretRevealPassToPlayer(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealPrivacyLine1 => 'Make sure nobody else is';

  @override
  String get secretRevealPrivacyLine2 => 'looking at your screen.';

  @override
  String get secretRevealTopSecret => 'TOP SECRET';

  @override
  String get secretRevealNextPlayer => 'NEXT PLAYER';

  @override
  String get secretRevealStartQuestions => 'START QUESTIONS';

  @override
  String get outOfLoopMessage => 'You are OUT of the loop - act naturally.';

  @override
  String get doneAnswering => 'Done answering';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return '$playerName\'s turn';
  }

  @override
  String get questionRoundSpeakUp => 'SPEAK UP!';

  @override
  String get questionRoundSpeakUpLine1 => 'Answer the question aloud so';

  @override
  String get questionRoundSpeakUpLine2 => 'everyone can hear you.';

  @override
  String get questionRoundTimeRemaining => 'TIME REMAINING';

  @override
  String questionRoundTimeSeconds(int seconds) {
    return '${seconds}S';
  }

  @override
  String get questionRoundDoneAnswering => 'DONE ANSWERING';

  @override
  String get questionRoundNextQuestion => 'NEXT QUESTION';

  @override
  String get questionRoundGoToVoting => 'GO TO VOTING';

  @override
  String get questionRoundTimerExpiredLine1 => 'Time is up.';

  @override
  String get questionRoundTimerExpiredLine2 => 'Finish this answer when ready.';

  @override
  String get questionRoundExitTitle => 'Leave the match?';

  @override
  String get questionRoundExitMessage =>
      'Going back will cancel the match and return you to category selection.';

  @override
  String get questionRoundExitConfirm => 'LEAVE MATCH';

  @override
  String get questionRoundExitStay => 'KEEP PLAYING';

  @override
  String get whoIsOutOfTheLoop => 'Who is out of the loop?';

  @override
  String get votingHeadlineWhoIs => 'WHO IS';

  @override
  String get votingHeadlineOutOf => 'OUT OF';

  @override
  String get votingHeadlineTheLoop => 'THE LOOP?';

  @override
  String get votingSubtitleLine1 => 'Find the imposter! Vote for the player';

  @override
  String get votingSubtitleLine2 => 'you think does not know the secret';

  @override
  String get votingSubtitleLine3 => 'word.';

  @override
  String get votingVote => 'VOTE';

  @override
  String get votingYou => 'YOU';

  @override
  String get votingCannotVoteSelf => 'CANNOT VOTE SELF';

  @override
  String get votingTimeToVote => 'TIME TO VOTE';

  @override
  String votingTimeSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get votingTimerExpiredLine1 => 'Time is up.';

  @override
  String get votingTimerExpiredLine2 => 'Cast your vote when ready.';

  @override
  String get confirmVotes => 'CONFIRM VOTES';

  @override
  String get roundResults => 'ROUND RESULTS';

  @override
  String get roundResultsHeadlineAccent => 'ROUND';

  @override
  String get roundResultsHeadlineMain => 'RESULTS';

  @override
  String get roundResultsOutPlayerLabel => 'THE OUT PLAYER WAS';

  @override
  String get roundResultsMajorityFound =>
      'The group found the out player by majority.';

  @override
  String get roundResultsMajorityEscaped =>
      'The out player escaped the majority vote.';

  @override
  String get roundResultsVoteTotals => 'VOTE TOTALS';

  @override
  String get roundResultsRoundPoints => 'ROUND POINTS';

  @override
  String roundResultsVoteCount(int count) {
    return '$count votes';
  }

  @override
  String roundResultsPointsGain(int points) {
    return '+$points';
  }

  @override
  String get roundResultsContinue => 'CONTINUE';

  @override
  String roundResultsGoToRound(int roundNumber) {
    return 'GO TO ROUND $roundNumber';
  }

  @override
  String get roundResultsViewFinalScore => 'VIEW FINAL SCORE';

  @override
  String get guessWord => 'GUESS THE WORD';

  @override
  String get guessHeadlineAccent => 'GUESS';

  @override
  String get guessHeadlineMain => 'THE WORD';

  @override
  String guessPlayerTurn(String name) {
    return '$name, your turn';
  }

  @override
  String get guessInstructionLine1 => 'Say the secret word out loud.';

  @override
  String get guessInstructionLine2 => 'The group decides if you';

  @override
  String get guessInstructionLine3 => 'got it right.';

  @override
  String get guessCorrectButton => 'GOT IT RIGHT';

  @override
  String get guessWrongButton => 'MISSED IT';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Wrong';

  @override
  String get playAgain => 'PLAY AGAIN';

  @override
  String get backToHome => 'BACK TO HOME';

  @override
  String resultsWinnerWins(String name) {
    return '$name wins!';
  }

  @override
  String get resultsTheMastermind => 'THE MASTERMIND';

  @override
  String get resultsSecretWordWas => 'THE SECRET WORD WAS:';

  @override
  String resultsOutPlayerWas(String name) {
    return '$name was Out of the Loop!';
  }

  @override
  String get resultsLeaderboard => 'LEADERBOARD';

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
