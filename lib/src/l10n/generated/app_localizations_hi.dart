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
  String get homeTagline => 'सब जानते हैं। एक को छोड़कर।';

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
  String secretRevealViewerLine1(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealViewerLine2 => 'अपना शब्द देखेगा';

  @override
  String get secretRevealHandPhoneLine => 'फोन केवल इस खिलाड़ी को दें।';

  @override
  String get secretRevealPrivacy =>
      'सुनिश्चित करें कि कोई और स्क्रीन नहीं देख रहा।';

  @override
  String secretRevealConfirmTitle(String playerName) {
    return 'क्या यह $playerName है?';
  }

  @override
  String get secretRevealConfirmMessage =>
      'पुष्टि करें कि फोन केवल उसी के पास है जिसे शब्द देखना है।';

  @override
  String get secretRevealConfirmYes => 'हाँ, दिखाएँ';

  @override
  String get secretRevealConfirmNo => 'अभी नहीं';

  @override
  String get secretRevealTopSecret => 'गुप्त';

  @override
  String get secretRevealNextPlayer => 'अगला खिलाड़ी';

  @override
  String get secretRevealFinished => 'हो गया';

  @override
  String get secretRevealStartQuestions => 'प्रश्न शुरू करें';

  @override
  String get questionsReadyTitleLine1 => 'सब';

  @override
  String get questionsReadyTitleLine2 => 'तैयार?';

  @override
  String get questionsReadyBody =>
      'जब सभी ने अपना शब्द देख लिया हो, प्रश्न राउंड शुरू करें।';

  @override
  String get questionsReadyThemeLabel => 'थीम';

  @override
  String get questionsReadyStartQuestions => 'प्रश्न शुरू करें';

  @override
  String get outOfLoopMessage => 'आप लूप से बाहर हैं — स्वाभाविक रहें।';

  @override
  String get doneAnswering => 'उत्तर पूरा हुआ';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return '$playerName की बारी';
  }

  @override
  String get questionRoundAnsweringNow => 'अभी जवाब दे रहे हैं';

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
  String votingPlayerTurn(String playerName) {
    return '$playerName का वोट';
  }

  @override
  String get votingNow => 'अभी वोट कर रहे हैं';

  @override
  String get votingCandidatesSection => 'एक संदिग्ध चुनें';

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
  String get roundResultsGuessReminderTitle => 'शब्द मत बोलो!';

  @override
  String get roundResultsGuessReminderLine1 =>
      'बाहर का खिलाड़ी अब अनुमान लगाएगा।';

  @override
  String get roundResultsGuessReminderLine2 =>
      'चुप रहें — शब्द मत बताएं और संकेत मत दें।';

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
  String get settingsLanguageArabic => 'अरबी';

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
      'निर्देशित मोड में ऐप के सवालों के जवाब दें। स्वतंत्र खेल में एक शब्द का संकेत दें। ';

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

  @override
  String get reviewPromptTitle => 'मैच मज़ेदार रहा?';

  @override
  String get reviewPromptMessage =>
      'अगर सबको मज़ा आया, तो स्टोर पर एक समीक्षा गेम को और लोगों तक पहुँचाती है।';

  @override
  String get reviewPromptRate => 'रेट करें';

  @override
  String get reviewPromptLater => 'अभी नहीं';

  @override
  String get gameModeLabel => 'आप कैसे खेलेंगे?';

  @override
  String get guidedMode => 'निर्देशित';

  @override
  String get guidedModeDescription => 'ऐप के सवालों के जवाब दें।';

  @override
  String get freeMode => 'स्वतंत्र खेल';

  @override
  String get freeModeDescription => 'एक शब्द का संकेत दें और झांसा दें।';

  @override
  String get freeClueTitle => 'एक शब्द। सोचकर बोलें।';

  @override
  String get freeClueBody =>
      'गुप्त शब्द बोले बिना संकेत दें। इम्पोस्टर को घुलना-मिलना होगा।';

  @override
  String get clueDone => 'संकेत दे दिया';

  @override
  String get anotherLap => 'एक और दौर';

  @override
  String get voteNow => 'अब वोट दें';

  @override
  String get cluesReady => 'सबने संकेत दे दिया है।';

  @override
  String get savedGroupHint => 'आपका पिछला समूह तैयार है। नाम बदल सकते हैं।';

  @override
  String get historySection => 'नए दौर';

  @override
  String get historyDescription =>
      'हाल के शब्द और सवाल दोहराए नहीं जाते। पैक खत्म होने पर सबसे पुराने शब्द लौटते हैं।';

  @override
  String get resetHistory => 'शब्द इतिहास रीसेट करें';

  @override
  String get historyReset => 'शब्द इतिहास रीसेट हो गया।';

  @override
  String get forgetGroup => 'सहेजा समूह हटाएं';

  @override
  String get groupForgotten => 'सहेजा समूह हटा दिया गया।';

  @override
  String get gameNightPacks => 'गेम नाइट पैक';

  @override
  String get packsSubtitle =>
      'अगली मुलाकात के लिए नए विषय। सामग्री अंग्रेज़ी में।';

  @override
  String get packPurchaseOnce => 'एक बार खरीदें। कोई सदस्यता नहीं।';

  @override
  String get packOwned => 'खेलने के लिए तैयार';

  @override
  String get packPlay => 'यह पैक खेलें';

  @override
  String get packBuy => 'पैक अनलॉक करें';

  @override
  String get packUnavailable =>
      'खरीद अभी उपलब्ध नहीं है। मुफ़्त श्रेणियां अभी भी खेल सकते हैं।';

  @override
  String get restorePurchases => 'खरीद बहाल करें';

  @override
  String get purchaseFailed => 'खरीद पूरी नहीं हो सकी। फिर कोशिश करें।';

  @override
  String get purchasePending =>
      'खरीद की स्वीकृति बाकी है। मुफ़्त खेल जारी रखें।';

  @override
  String get purchaseRestored => 'खरीद जांच ली गई। उपलब्ध पैक नीचे हैं।';

  @override
  String get purchaseSuccess => 'आपका पैक तैयार है। चलिए खेलें!';

  @override
  String get packEnglishOnly => 'अंग्रेज़ी सामग्री';

  @override
  String get packBundleTitle => 'गेम नाइट संग्रह';

  @override
  String get packBundleDescription =>
      'यहां दिए तीनों पैक। एक बार खरीदें और रखें।';

  @override
  String roundsOnlySummary(int roundCount) {
    return '$roundCount दौर · एक शब्द के संकेत';
  }

  @override
  String packWordCount(int count) {
    return '$count शब्द · निर्देशित और स्वतंत्र खेल';
  }

  @override
  String get readyToPlay => 'खेलने के लिए तैयार';

  @override
  String get explorePacks => 'पैक देखें';

  @override
  String get packEnglishContent => 'अंग्रेज़ी सामग्री वाला पैक';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingNext => 'आगे बढ़ें';

  @override
  String get onboardingStart => 'खेल शुरू करें';

  @override
  String get onboardingReplay => 'इंटरैक्टिव ट्यूटोरियल फिर देखें';

  @override
  String onboardingStep(int step) {
    return 'चरण $step / 3';
  }

  @override
  String get onboardingSecretTitle => 'सब जानते हैं। एक को छोड़कर।';

  @override
  String get onboardingSecretBody =>
      '3 से 9 लोगों को इकट्ठा करें। एक को छोड़कर सभी को एक ही गुप्त शब्द मिलता है। Out of the Loop खिलाड़ी को जानने का नाटक करना होगा!';

  @override
  String get onboardingPassTitle => 'अपना राज़ देखें और फ़ोन आगे दें।';

  @override
  String get onboardingPassBody =>
      'अभ्यास के लिए कार्ड पर टैप करें। असली खेल में अपना रोल अकेले देखें, शब्द छिपाएँ और फ़ोन अगले खिलाड़ी को दें।';

  @override
  String get onboardingVoteTitle => 'संकेत दें। झाँसा दें। वोट करें।';

  @override
  String get onboardingVoteBody =>
      'गाइडेड मोड में सवालों के जवाब दें। फ़्री मोड में एक शब्द का संकेत दें। फिर Out of the Loop खिलाड़ी को पहचानने के लिए वोट करें। अगर वह अंत में शब्द का अनुमान लगा ले, तो वह जीतता है!';

  @override
  String get onboardingWord => 'पिज़्ज़ा';

  @override
  String get onboardingOut => 'Out of the Loop';

  @override
  String get onboardingReveal => 'दिखाने के लिए टैप करें';

  @override
  String get onboardingHide => 'छिपाने के लिए टैप करें';

  @override
  String get onboardingVoteLabel => 'कौन झाँसा दे रहा है?';

  @override
  String get onboardingSaveError => 'सेव नहीं हो सका। फिर कोशिश करें।';

  @override
  String get classicDevTitle => 'Classic · विकास';

  @override
  String get classicFixtureNotice => 'ऑफ़लाइन कैटलॉग · संपादकीय समीक्षा लंबित';

  @override
  String get classicHint => 'श्रेणी संकेत';

  @override
  String get classicSheet => 'घटक पैनल';

  @override
  String get classicUnavailable => 'चरण 3 में खेल उपलब्ध होगा';

  @override
  String get classicLoading => 'लोड हो रहा है';

  @override
  String get classicError => 'उदाहरण त्रुटि';

  @override
  String get classicRetry => 'फिर कोशिश करें';

  @override
  String get classicCrew => 'आपका समूह';

  @override
  String get classicNames => 'नाम बदलें';

  @override
  String get classicCategories => 'श्रेणियाँ';

  @override
  String get classicImpostors => 'धोखेबाज़';

  @override
  String get classicAuto => 'अपने आप (सुझाया गया)';

  @override
  String get classicTimer => 'चर्चा का समय';

  @override
  String get classicDuration => 'अवधि';

  @override
  String get classicTroll => 'ट्रोल मोड';

  @override
  String get classicSave => 'नाम सहेजें';

  @override
  String get classicConfirm => 'पुष्टि करें';

  @override
  String get classicClear => 'साफ़ करें';

  @override
  String get classicSelectFree => 'सभी मुफ़्त चुनें';

  @override
  String get classicSelectAll => 'सभी चुनें';

  @override
  String get classicAll => 'सभी';

  @override
  String get classicDone => 'हो गया';

  @override
  String get classicAdd => 'खिलाड़ी जोड़ें';

  @override
  String get classicRemove => 'खिलाड़ी हटाएँ';

  @override
  String get classicPlayer => 'खिलाड़ी';

  @override
  String get classicHelp => 'कैसे खेलें';

  @override
  String get classicSettings => 'सेटिंग';

  @override
  String get classicPremium => 'Premium';

  @override
  String get classicDemoBuy => 'Premium डेमो चालू करें';

  @override
  String get classicDemoNotice => 'नकली खरीद वाला विकास डेमो।';

  @override
  String get classicStart => 'खेल शुरू करें';

  @override
  String get classicTitle => 'धोखेबाज़ कौन है?';

  @override
  String get classicSubtitle => 'एक फ़ोन। आपके दोस्त। एक गुप्त शब्द।';

  @override
  String get classicOff => 'बंद';

  @override
  String get classicMinutes => 'मिनट';

  @override
  String get classicShare => 'साझा करें';

  @override
  String get classicRate => 'ऐप की समीक्षा करें';

  @override
  String get classicFooter =>
      'साथ में बात करें, झाँसा दें और वोट करें। चर्चा में स्क्रीन की ज़रूरत नहीं।';

  @override
  String get classicHelpSteps =>
      '1. एक फ़ोन के साथ 3–20 खिलाड़ी जुटें।\n2. भूमिका देखने के लिए दबाएँ, छिपाने के लिए छोड़ें।\n3. गुप्त शब्द के संकेत दें।\n4. धोखेबाज़ झाँसा दें।\n5. आमने-सामने चर्चा और वोट करें।\n6. पुष्टि करके शब्द और धोखेबाज़ देखें।\n\nसंकेत में केवल श्रेणी दिखती है। ट्रोल में सभी धोखेबाज़ हो सकते हैं।';

  @override
  String get classicEnglish => 'सामग्री अंग्रेज़ी में';

  @override
  String get classicClose => 'बंद करें';

  @override
  String get classicHold => 'अपनी भूमिका देखने के लिए दबाकर रखें';

  @override
  String get classicRelease =>
      'छिपाने के लिए छोड़ें। कार्ड ढका होने पर ही फ़ोन आगे दें।';

  @override
  String get classicShowRole => 'भूमिका दिखाएँ · सुलभ विकल्प';

  @override
  String get classicHideRole => 'भूमिका छिपाएँ';

  @override
  String get classicYouImpostor => 'आप धोखेबाज़ हैं';

  @override
  String get classicYourWord => 'गुप्त शब्द';

  @override
  String get classicNext => 'अगला खिलाड़ी';

  @override
  String get classicDiscuss => 'चर्चा शुरू करें';

  @override
  String get classicStarts => 'पहला संकेत देने वाला';

  @override
  String get classicInPerson =>
      'आमने-सामने संकेत दें, झाँसा दें, चर्चा करें और वोट करें। तैयार होने पर साथ में नतीजा देखें।';

  @override
  String get classicPause => 'समय रोकें';

  @override
  String get classicResume => 'समय फिर चलाएँ';

  @override
  String get classicTimeUp =>
      'समय पूरा हुआ। बात जारी रखें या तैयार होने पर नतीजा देखें।';

  @override
  String get classicReveal => 'नतीजा दिखाएँ';

  @override
  String get classicRevealQuestion => 'राज़ दिखाएँ?';

  @override
  String get classicRevealWarning =>
      'सभी शब्द और धोखेबाज़ों को देखेंगे। पहले वोट पूरा करें।';

  @override
  String get classicCancel => 'रद्द करें';

  @override
  String get classicEnd => 'दौर समाप्त करें';

  @override
  String get classicExitQuestion => 'यह दौर समाप्त करें?';

  @override
  String get classicExitWarning =>
      'राज़ दिखाए बिना सेटिंग पर लौटें। यह दौर फिर शुरू नहीं किया जा सकेगा।';

  @override
  String get classicResult => 'धोखेबाज़ थे…';

  @override
  String get classicTrollResult => 'ट्रोल दौर — सभी!';

  @override
  String get classicAgain => 'फिर खेलें';

  @override
  String get classicEditGame => 'खेल बदलें';

  @override
  String get classicContentMissing =>
      'कुछ श्रेणियों में अंग्रेज़ी सामग्री नहीं है। शुरू करने के लिए मुफ़्त श्रेणियाँ चुनें।';

  @override
  String get classicRecoveryTitle => 'सहेजा खेल बहाल करें';

  @override
  String get classicFutureSave =>
      'इस सेव के लिए नया ऐप चाहिए। फिर कोशिश करें या इसे बदले बिना अस्थायी रूप से खेलें।';

  @override
  String get classicRecoveryBody =>
      'सहेजा खेल पढ़ा नहीं जा सका। फिर कोशिश करें या सही समूह और इतिहास के साथ नया खेल शुरू करें। खरीद और सेटिंग सुरक्षित हैं।';

  @override
  String get classicNewGame => 'नया खेल';

  @override
  String get classicDiscardBody =>
      'केवल सहेजा दौर हटाएँ? समूह, इतिहास, सेटिंग और खरीद सुरक्षित रहेंगे।';

  @override
  String get classicResumeTitle => 'खेल जारी है';

  @override
  String get classicResumeBody =>
      'ढके कार्ड और रुके समय के साथ जारी रखें या दौर समाप्त करें।';

  @override
  String get classicWriteFailure =>
      'सहेजा नहीं जा सका। फिर कोशिश करें या जारी रखें। दोबारा खोलने पर आखिरी सहेजे चरण पर लौट सकते हैं।';

  @override
  String get classicContinueUnsaved => 'बिना सहेजे जारी रखें';

  @override
  String get classicUnsavedNotice =>
      'प्रगति सहेजी नहीं गई है। दोबारा खोलने पर हाल की प्रगति खो सकती है।';

  @override
  String get classicResetHistory => 'शब्दों का इतिहास मिटाएँ';

  @override
  String get classicResetHistoryBody =>
      'केवल शब्द और धोखेबाज़ों का इतिहास मिटाएँ? समूह, सेटिंग और खरीद सुरक्षित रहेंगे।';

  @override
  String get classicResumeGame => 'खेल जारी रखें';

  @override
  String get classicAccessChanged =>
      'पहुँच बदली। चयन अपडेट हुआ; जारी रखने के लिए फिर टैप करें।';

  @override
  String get classicHaptics => 'कंपन';

  @override
  String get classicSupport => 'सहायता से संपर्क करें';

  @override
  String get classicFeedbackNotice =>
      'संपादन योग्य ईमेल खुलता है। भेजना आप तय करते हैं; ऐप डिलीवरी की पुष्टि नहीं कर सकता।';

  @override
  String get classicLinkCopied => 'ऐप लिंक कॉपी हुआ।';

  @override
  String get classicActionUnavailable =>
      'यह क्रिया कॉन्फ़िगर नहीं है या इस डिवाइस पर उपलब्ध नहीं है।';

  @override
  String get classicActionFailed => 'क्रिया पूरी नहीं हुई। फिर कोशिश करें।';

  @override
  String get classicCatalogNotice =>
      '3 मुफ़्त श्रेणियाँ। अतिरिक्त सामग्री अंग्रेज़ी में है; शीर्षक और शब्द सामग्री की भाषा में हैं।';

  @override
  String get premiumSummary =>
      '20 अतिरिक्त श्रेणियाँ · 800 अतिरिक्त अंग्रेज़ी शब्द';

  @override
  String get premiumRenewal =>
      'वार्षिक या साप्ताहिक सदस्यता। स्टोर सेटिंग में रद्द न करने तक अपने आप नवीनीकृत होती है।';

  @override
  String get premiumActive => 'Premium सक्रिय है।';

  @override
  String get premiumAnnual => 'वार्षिक';

  @override
  String get premiumWeekly => 'साप्ताहिक';

  @override
  String get premiumUnavailable =>
      'स्टोर प्लान उपलब्ध नहीं। मुफ़्त खेल उपलब्ध है।';

  @override
  String get premiumRestore => 'खरीद बहाल करें';

  @override
  String get premiumManage => 'सदस्यता प्रबंधित करें';

  @override
  String get premiumTerms => 'उपयोग की शर्तें';

  @override
  String get premiumNone => 'कोई खरीद नहीं मिली।';

  @override
  String get premiumRestored => 'खरीद बहाल हुई।';

  @override
  String get premiumRefreshError => 'खरीद अपडेट नहीं हुई। फिर कोशिश करें।';

  @override
  String get premiumVerifying =>
      'खरीद की पहुँच सत्यापन की प्रतीक्षा है। बहाल करें या फिर कोशिश करें।';

  @override
  String get premiumCancelled => 'खरीद रद्द हुई।';

  @override
  String get premiumPending => 'भुगतान स्वीकृति की प्रतीक्षा में है।';

  @override
  String get premiumBuyError => 'खरीद उपलब्ध नहीं। फिर कोशिश करें।';

  @override
  String get premiumVerifyError =>
      'खरीद सत्यापित नहीं हुई। बहाल करें या फिर कोशिश करें।';
}
