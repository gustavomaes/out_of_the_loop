// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Out of the Loop';

  @override
  String get startGame => 'खेल शुरू करें';

  @override
  String get navPlay => 'खेलें';

  @override
  String get navCategories => 'श्रेणियाँ';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get howToPlay => 'कैसे खेलें';

  @override
  String get pickCategory => 'श्रेणी चुनें';

  @override
  String get pickCategorySubtitle => 'अपना मैदान चुनें। लूप इंतज़ार कर रहा है।';

  @override
  String get categoryFoodAndDrink => 'खाना और पेय';

  @override
  String get categoryTravel => 'यात्रा';

  @override
  String get categoryMovies => 'फ़िल्में';

  @override
  String get categoryAnimals => 'जानवर';

  @override
  String get categorySports => 'खेल';

  @override
  String get categoryTech => 'टेक';

  @override
  String get categoriesLoadError => 'श्रेणियाँ लोड नहीं हो सकीं।';

  @override
  String get addPlayer => 'खिलाड़ी जोड़ें';

  @override
  String get addPlayerButton => 'जोड़ें';

  @override
  String get playerSetupTitleLine1 => 'कौन';

  @override
  String get playerSetupTitleLine2 => 'खेलेगा?';

  @override
  String get playerSetupPlayerCountBadge => '3-9 खिलाड़ी';

  @override
  String get playerNameHint => 'खिलाड़ी का नाम';

  @override
  String get playerSetupStartGame => 'खेल शुरू करें';

  @override
  String playerSetupRemovePlayer(String playerName) {
    return '$playerName हटाएँ';
  }

  @override
  String get playerSetupErrorEmptyName => 'नाम खाली नहीं हो सकता।';

  @override
  String get playerSetupErrorDuplicateName =>
      'खिलाड़ियों के नाम अलग होने चाहिए।';

  @override
  String get playerSetupErrorTooManyPlayers =>
      'एक मैच में अधिकतम 9 खिलाड़ी हो सकते हैं।';

  @override
  String get playerSetupErrorTooFewPlayers => 'कम से कम 3 खिलाड़ी जोड़ें।';

  @override
  String get playerSetupErrorInvalidRoundCount => 'राउंड की संख्या अमान्य है।';

  @override
  String get playerSetupErrorInvalidQuestions =>
      'प्रति खिलाड़ी 1 से 3 प्रश्न चुनें।';

  @override
  String get playerSetupErrorInsufficientWords =>
      'इस श्रेणी में इतने राउंड के लिए पर्याप्त शब्द नहीं हैं।';

  @override
  String get playerSetupErrorInsufficientQuestions =>
      'इस श्रेणी में इतने खिलाड़ियों के लिए पर्याप्त प्रश्न नहीं हैं।';

  @override
  String get matchSetupTitleLine1 => 'मैच';

  @override
  String get matchSetupTitleLine2 => 'सेटअप';

  @override
  String get matchSetupRulesBadge => '1–5 राउंड · 1–3 प्रश्न';

  @override
  String get matchSetupSubtitle => 'खिलाड़ी जोड़ने से पहले नियम तय करें।';

  @override
  String get matchSetupQuestionsSection => 'प्रति खिलाड़ी प्रश्न';

  @override
  String get matchSetupQuestionsDescription =>
      'इस राउंड में प्रत्येक खिलाड़ी कितने प्रश्नों के जवाब देगा?';

  @override
  String matchSetupQuestionsRecommendation(int recommended) {
    return '3–4 खिलाड़ियों के लिए हम $recommended की सलाह देते हैं; 5 या अधिक के लिए 1 (श्रेणी अनुमति दे तो 3 तक)।';
  }

  @override
  String get matchSetupRoundsSection => 'मैच में राउंड';

  @override
  String get matchSetupRoundsDescription => 'इस मैच में कितने राउंड होंगे?';

  @override
  String matchSetupRoundsRecommended(int count) {
    return 'अनुशंसित: $count राउंड।';
  }

  @override
  String matchSetupRoundsValue(int count) {
    return 'राउंड: $count';
  }

  @override
  String matchSetupQuestionCountChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रश्न',
      one: '1 प्रश्न',
    );
    return '$_temp0';
  }

  @override
  String matchSetupSummary(int roundCount, int questionCount) {
    String _temp0 = intl.Intl.pluralLogic(
      roundCount,
      locale: localeName,
      other: '$roundCount राउंड',
      one: '1 राउंड',
    );
    String _temp1 = intl.Intl.pluralLogic(
      questionCount,
      locale: localeName,
      other: '$questionCount प्रश्न',
      one: '1 प्रश्न',
    );
    return '$_temp0 · $_temp1 प्रति खिलाड़ी';
  }

  @override
  String get matchSetupContinue => 'जारी रखें';

  @override
  String get startMatch => 'मैच शुरू करें';

  @override
  String get revealMyWord => 'मेरी भूमिका देखें';

  @override
  String secretRevealRound(int roundNumber) {
    return 'राउंड $roundNumber';
  }

  @override
  String get secretRevealPassTo => 'फोन दें';

  @override
  String secretRevealPassToPlayer(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealPrivacyLine1 => 'सुनिश्चित करें कि कोई और';

  @override
  String get secretRevealPrivacyLine2 => 'आपकी स्क्रीन नहीं देख रहा।';

  @override
  String get secretRevealTopSecret => 'गुप्त';

  @override
  String get secretRevealNextPlayer => 'अगला खिलाड़ी';

  @override
  String get secretRevealStartQuestions => 'प्रश्न शुरू करें';

  @override
  String get outOfLoopMessage => 'आप लूप से बाहर हैं — स्वाभाविक रहें।';

  @override
  String get doneAnswering => 'उत्तर पूरा हुआ';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return '$playerName की बारी';
  }

  @override
  String get questionRoundSpeakUp => 'ज़ोर से बोलें!';

  @override
  String get questionRoundSpeakUpLine1 => 'सवाल का जवाब ज़ोर से बोलें ताकि';

  @override
  String get questionRoundSpeakUpLine2 => 'सभी सुन सकें।';

  @override
  String get questionRoundDoneAnswering => 'जवाब पूरा';

  @override
  String get questionRoundNextQuestion => 'अगला सवाल';

  @override
  String get questionRoundGoToVoting => 'वोटिंग पर जाएं';

  @override
  String get questionRoundExitTitle => 'मैच रद्द करें?';

  @override
  String get questionRoundExitMessage =>
      'अभी वापस जाने पर मैच रद्द होगा और आप श्रेणी चयन पर लौटेंगे।';

  @override
  String get questionRoundExitConfirm => 'मैच छोड़ें';

  @override
  String get questionRoundExitStay => 'खेल जारी रखें';

  @override
  String get whoIsOutOfTheLoop => 'लूप से बाहर कौन है?';

  @override
  String get votingHeadlineWhoIs => 'कौन है';

  @override
  String get votingHeadlineOutOf => 'लूप से';

  @override
  String get votingHeadlineTheLoop => 'बाहर?';

  @override
  String get votingSubtitleLine1 =>
      'इम्पोस्टर को ढूंढें! उस खिलाड़ी को वोट दें';

  @override
  String get votingSubtitleLine2 => 'जो आपको लगता है गुप्त शब्द';

  @override
  String get votingSubtitleLine3 => 'नहीं जानता।';

  @override
  String get votingVote => 'वोट';

  @override
  String get votingYou => 'आप';

  @override
  String get votingCannotVoteSelf => 'खुद को वोट नहीं कर सकते';

  @override
  String get confirmVotes => 'वोट की पुष्टि करें';

  @override
  String get roundResults => 'राउंड परिणाम';

  @override
  String get roundResultsHeadlineAccent => 'राउंड';

  @override
  String get roundResultsHeadlineMain => 'परिणाम';

  @override
  String get roundResultsOutPlayerLabel => 'बाहर का खिलाड़ी था';

  @override
  String get roundResultsMajorityFound =>
      'समूह ने बहुमत से बाहर के खिलाड़ी को पहचान लिया।';

  @override
  String get roundResultsMajorityEscaped =>
      'बाहर का खिलाड़ी बहुमत वोट से बच गया।';

  @override
  String get roundResultsVoteTotals => 'कुल वोट';

  @override
  String get roundResultsRoundPoints => 'राउंड अंक';

  @override
  String roundResultsVoteCount(int count) {
    return '$count वोट';
  }

  @override
  String roundResultsPointsGain(int points) {
    return '+$points';
  }

  @override
  String get roundResultsContinue => 'जारी रखें';

  @override
  String roundResultsGoToRound(int roundNumber) {
    return 'राउंड $roundNumber पर जाएं';
  }

  @override
  String get roundResultsViewFinalScore => 'अंतिम स्कोर देखें';

  @override
  String get guessWord => 'शब्द का अनुमान लगाएं';

  @override
  String get guessHeadlineAccent => 'शब्द';

  @override
  String get guessHeadlineMain => 'अनुमान';

  @override
  String guessPlayerTurn(String name) {
    return '$name की बारी';
  }

  @override
  String get guessInstructionLine1 => 'गुप्त शब्द जोर से बोलें।';

  @override
  String get guessInstructionLine2 => 'समूह तय करता है कि आपने';

  @override
  String get guessInstructionLine3 => 'सही अनुमान लगाया या नहीं।';

  @override
  String get guessCorrectButton => 'सही';

  @override
  String get guessWrongButton => 'गलत';

  @override
  String get correct => 'सही';

  @override
  String get wrong => 'गलत';

  @override
  String get playAgain => 'फिर खेलें';

  @override
  String get newMatchDialogTitle => 'नया मैच';

  @override
  String get newMatchDialogMessage =>
      'क्या आप वही श्रेणी रखना चाहते हैं या नई चुनना चाहते हैं?';

  @override
  String get newMatchKeepCategory => 'श्रेणी रखें';

  @override
  String get newMatchChangeCategory => 'श्रेणी बदलें';

  @override
  String get backToHome => 'होम पर वापस जाएं';

  @override
  String resultsWinnerWins(String name) {
    return '$name जीते!';
  }

  @override
  String get resultsTheMastermind => 'मास्टरमाइंड';

  @override
  String get resultsSecretWordWas => 'गुप्त शब्द था:';

  @override
  String resultsOutPlayerWas(String name) {
    return '$name लूप से बाहर थे!';
  }

  @override
  String get resultsLeaderboard => 'लीडरबोर्ड';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get settingsScreenTitle => 'सेटिंग्स';

  @override
  String get settingsSectionLanguage => 'भाषा';

  @override
  String get settingsSectionAudio => 'ऑडियो';

  @override
  String get settingsSectionAbout => 'के बारे में';

  @override
  String get settingsMusic => 'संगीत';

  @override
  String get settingsSoundEffects => 'ध्वनि प्रभाव';

  @override
  String get settingsTermsOfUse => 'उपयोग की शर्तें';

  @override
  String get settingsPrivacy => 'गोपनीयता';

  @override
  String get settingsAppVersionLabel => 'ऐप संस्करण';

  @override
  String get settingsAppVersionValue => 'v0.1.0';

  @override
  String get settingsLanguagePortuguese => 'पुर्तगाली';

  @override
  String get settingsLanguageEnglish => 'अंग्रेज़ी';

  @override
  String get settingsLanguageSpanish => 'स्पेनिश';

  @override
  String get settingsLanguageHindi => 'हिंदी';

  @override
  String get language => 'भाषा';

  @override
  String get howToPlayScreenTitle => 'कैसे खेलें';

  @override
  String get howToPlayKapow => 'धमाका!';

  @override
  String get howToPlaySecretTitle => 'रहस्य';

  @override
  String get howToPlaySecretBodyBefore =>
      'हर खिलाड़ी गुप्त शब्द देखता है, सिवाय एक के... जो ';

  @override
  String get howToPlaySecretBodyHighlight => 'लूप से बाहर है!';

  @override
  String get howToPlayQuestionTitle => 'सवाल';

  @override
  String get howToPlayQuestionBodyBefore =>
      'शब्द के बारे में मज़ेदार सवालों के जवाब दें, बिना सब कुछ बता दिए। ';

  @override
  String get howToPlayQuestionBodyEmphasis => 'चतुर बनो!';

  @override
  String get howToPlayVoteTitle => 'वोट';

  @override
  String get howToPlayVoteBodyBefore => 'पहचानें कौन कुछ नहीं जानता और ';

  @override
  String get howToPlayVoteBodyHighlight => 'वोट करें!';

  @override
  String get howToPlayVoteBodyAfter => ' बेझिझक उंगली उठाएं।';

  @override
  String get howToPlayOutcomeTitle => 'अंत';

  @override
  String get howToPlayOutcomeBodyBefore =>
      'अगर लूप से बाहर खिलाड़ी अंत में शब्द सही अनुमान लगाए, तो ';

  @override
  String get howToPlayOutcomeBodyHighlight => 'वह जीतता है';

  @override
  String get howToPlayOutcomeBodyAfter => ' और मास्टरमाइंड बन जाता है!';
}
