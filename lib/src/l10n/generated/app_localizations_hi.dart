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
  String get addPlayer => 'खिलाड़ी जोड़ें';

  @override
  String get startMatch => 'मैच शुरू करें';

  @override
  String get revealMyWord => 'मेरा शब्द दिखाएं';

  @override
  String get outOfLoopMessage => 'आप लूप से बाहर हैं - स्वाभाविक रहें.';

  @override
  String get doneAnswering => 'उत्तर पूरा हुआ';

  @override
  String get whoIsOutOfTheLoop => 'लूप से बाहर कौन है?';

  @override
  String get confirmVotes => 'वोट पक्का करें';

  @override
  String get roundResults => 'राउंड के नतीजे';

  @override
  String get guessWord => 'शब्द का अनुमान लगाएं';

  @override
  String get correct => 'सही';

  @override
  String get wrong => 'गलत';

  @override
  String get playAgain => 'फिर खेलें';

  @override
  String get backToHome => 'होम पर वापस';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get settingsScreenTitle => 'सेटिंग्स';

  @override
  String get settingsSectionLanguage => 'भाषा';

  @override
  String get settingsSectionAudio => 'ऑडियो';

  @override
  String get settingsSectionTimer => 'टाइमर';

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
  String get settingsUseTimer => 'टाइमर उपयोग करें';

  @override
  String settingsTimerSeconds(int seconds) {
    return 'प्रति मोड़ $seconds सेकंड';
  }

  @override
  String get language => 'भाषा';

  @override
  String get timer => 'टाइमर';

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
