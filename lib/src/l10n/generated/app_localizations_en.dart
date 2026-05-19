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
  String get howToPlay => 'HOW TO PLAY';

  @override
  String get pickCategory => 'Pick a category';

  @override
  String get addPlayer => 'Add player';

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
