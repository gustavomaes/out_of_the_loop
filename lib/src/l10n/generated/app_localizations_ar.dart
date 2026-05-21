// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'خارج الحلقة';

  @override
  String get startGame => 'ابدأ اللعبة';

  @override
  String get navPlay => 'العب';

  @override
  String get navCategories => 'الفئات';

  @override
  String get navProfile => 'الملف';

  @override
  String get howToPlay => 'كيف تلعب';

  @override
  String get pickCategory => 'اختر فئة';

  @override
  String get pickCategorySubtitle => 'اختر ساحة المعركة. الحلقة في انتظارك.';

  @override
  String get categoryFoodAndDrink => 'طعام وشراب';

  @override
  String get categoryTravel => 'سفر';

  @override
  String get categoryMovies => 'أفلام';

  @override
  String get categoryAnimals => 'حيوانات';

  @override
  String get categorySports => 'رياضة';

  @override
  String get categoryTech => 'تقنية';

  @override
  String get categoriesLoadError => 'تعذر تحميل الفئات.';

  @override
  String get addPlayer => 'أضف لاعبًا';

  @override
  String get addPlayerButton => 'أضف';

  @override
  String get playerSetupTitleLine1 => 'من سيلعب';

  @override
  String get playerSetupTitleLine2 => '؟';

  @override
  String get playerSetupPlayerCountBadge => '3-9 لاعبين';

  @override
  String get playerNameHint => 'اسم اللاعب';

  @override
  String get playerSetupStartGame => 'ابدأ اللعبة';

  @override
  String playerSetupRemovePlayer(String playerName) {
    return 'إزالة $playerName';
  }

  @override
  String get playerSetupErrorEmptyName => 'لا يمكن أن يكون الاسم فارغًا.';

  @override
  String get playerSetupErrorDuplicateName =>
      'يجب أن تكون أسماء اللاعبين فريدة.';

  @override
  String get playerSetupErrorTooManyPlayers => 'المباراة تدعم حتى 9 لاعبين.';

  @override
  String get playerSetupErrorTooFewPlayers => 'أضف 3 لاعبين على الأقل.';

  @override
  String get playerSetupErrorInvalidRoundCount => 'عدد جولات غير صالح.';

  @override
  String get playerSetupErrorInvalidQuestions =>
      'اختر بين 1 و3 أسئلة لكل لاعب.';

  @override
  String get playerSetupErrorInsufficientWords =>
      'هذه الفئة لا تحتوي على كلمات كافية لهذا العدد من الجولات.';

  @override
  String get playerSetupErrorInsufficientQuestions =>
      'هذه الفئة لا تحتوي على أسئلة كافية لهذا العدد من اللاعبين.';

  @override
  String get matchSetupTitleLine1 => 'إعداد';

  @override
  String get matchSetupTitleLine2 => 'المباراة';

  @override
  String get matchSetupRulesBadge => '1–5 جولات · 1–3 أسئلة';

  @override
  String get matchSetupSubtitle => 'حدد القواعد قبل إضافة اللاعبين.';

  @override
  String get matchSetupQuestionsSection => 'أسئلة لكل لاعب';

  @override
  String get matchSetupQuestionsDescription =>
      'كم سؤالًا يجيب كل لاعب في كل جولة؟';

  @override
  String matchSetupQuestionsRecommendation(int recommended) {
    return 'لـ 3–4 لاعبين نوصي بـ $recommended؛ لـ 5 أو أكثر، 1 (حتى 3 إذا سمحت الفئة).';
  }

  @override
  String get matchSetupRoundsSection => 'جولات المباراة';

  @override
  String get matchSetupRoundsDescription => 'كم جولة ستكون لهذه المباراة؟';

  @override
  String matchSetupRoundsRecommended(int count) {
    return 'موصى به: $count جولات.';
  }

  @override
  String matchSetupRoundsValue(int count) {
    return 'الجولات: $count';
  }

  @override
  String matchSetupQuestionCountChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أسئلة',
      one: 'سؤال واحد',
    );
    return '$_temp0';
  }

  @override
  String matchSetupSummary(int roundCount, int questionCount) {
    String _temp0 = intl.Intl.pluralLogic(
      roundCount,
      locale: localeName,
      other: '$roundCount جولات',
      one: 'جولة واحدة',
    );
    String _temp1 = intl.Intl.pluralLogic(
      questionCount,
      locale: localeName,
      other: '$questionCount أسئلة',
      one: 'سؤال واحد',
    );
    return '$_temp0 · $_temp1 لكل لاعب';
  }

  @override
  String get matchSetupContinue => 'متابعة';

  @override
  String get startMatch => 'ابدأ المباراة';

  @override
  String get revealMyWord => 'اكشف دوري';

  @override
  String secretRevealRound(int roundNumber) {
    return 'الجولة $roundNumber';
  }

  @override
  String get secretRevealPassTo => 'مرّر إلى';

  @override
  String secretRevealPassToPlayer(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealPrivacyLine1 => 'تأكد أن لا أحد آخر';

  @override
  String get secretRevealPrivacyLine2 => 'ينظر إلى شاشتك.';

  @override
  String get secretRevealTopSecret => 'سري للغاية';

  @override
  String get secretRevealNextPlayer => 'اللاعب التالي';

  @override
  String get secretRevealStartQuestions => 'ابدأ الأسئلة';

  @override
  String get outOfLoopMessage => 'أنت خارج الحلقة — تصرف بشكل طبيعي.';

  @override
  String get doneAnswering => 'انتهيت من الإجابة';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return 'دور $playerName';
  }

  @override
  String get questionRoundSpeakUp => 'تحدث بصوت عالٍ!';

  @override
  String get questionRoundSpeakUpLine1 => 'أجب عن السؤال بصوت عالٍ';

  @override
  String get questionRoundSpeakUpLine2 => 'حتى يسمعك الجميع.';

  @override
  String get questionRoundDoneAnswering => 'انتهيت من الإجابة';

  @override
  String get questionRoundNextQuestion => 'السؤال التالي';

  @override
  String get questionRoundGoToVoting => 'انتقل إلى التصويت';

  @override
  String get questionRoundExitTitle => 'مغادرة المباراة؟';

  @override
  String get questionRoundExitMessage =>
      'العودة ستلغي المباراة وتعيدك إلى اختيار الفئة.';

  @override
  String get questionRoundExitConfirm => 'مغادرة المباراة';

  @override
  String get questionRoundExitStay => 'واصل اللعب';

  @override
  String get whoIsOutOfTheLoop => 'من خارج الحلقة؟';

  @override
  String get votingHeadlineWhoIs => 'من';

  @override
  String get votingHeadlineOutOf => 'خارج';

  @override
  String get votingHeadlineTheLoop => 'الحلقة؟';

  @override
  String get votingSubtitleLine1 => 'اعثر على المتلاعب! صوّت للاعب';

  @override
  String get votingSubtitleLine2 => 'الذي تعتقد أنه لا يعرف';

  @override
  String get votingSubtitleLine3 => 'الكلمة السرية.';

  @override
  String get votingVote => 'صوّت';

  @override
  String get votingYou => 'أنت';

  @override
  String get votingCannotVoteSelf => 'لا يمكنك التصويت لنفسك';

  @override
  String get confirmVotes => 'تأكيد الأصوات';

  @override
  String get roundResults => 'نتائج الجولة';

  @override
  String get roundResultsHeadlineAccent => 'نتائج';

  @override
  String get roundResultsHeadlineMain => 'الجولة';

  @override
  String get roundResultsOutPlayerLabel => 'اللاعب الخارج كان';

  @override
  String get roundResultsMajorityFound =>
      'وجدت المجموعة اللاعب الخارج بالأغلبية.';

  @override
  String get roundResultsMajorityEscaped =>
      'نجا اللاعب الخارج من تصويت الأغلبية.';

  @override
  String get roundResultsVoteTotals => 'مجموع الأصوات';

  @override
  String get roundResultsRoundPoints => 'نقاط الجولة';

  @override
  String roundResultsVoteCount(int count) {
    return '$count أصوات';
  }

  @override
  String roundResultsPointsGain(int points) {
    return '+$points';
  }

  @override
  String get roundResultsContinue => 'متابعة';

  @override
  String roundResultsGoToRound(int roundNumber) {
    return 'انتقل إلى الجولة $roundNumber';
  }

  @override
  String get roundResultsViewFinalScore => 'عرض النتيجة النهائية';

  @override
  String get guessWord => 'خمّن الكلمة';

  @override
  String get guessHeadlineAccent => 'خمّن';

  @override
  String get guessHeadlineMain => 'الكلمة';

  @override
  String guessPlayerTurn(String name) {
    return '$name، دورك';
  }

  @override
  String get guessInstructionLine1 => 'قل الكلمة السرية بصوت عالٍ.';

  @override
  String get guessInstructionLine2 => 'المجموعة تقرر إن';

  @override
  String get guessInstructionLine3 => 'أصبت.';

  @override
  String get guessCorrectButton => 'أصبت';

  @override
  String get guessWrongButton => 'أخطأت';

  @override
  String get correct => 'صحيح';

  @override
  String get wrong => 'خطأ';

  @override
  String get playAgain => 'العب مجددًا';

  @override
  String get newMatchDialogTitle => 'مباراة جديدة';

  @override
  String get newMatchDialogMessage =>
      'الإبقاء على نفس الفئة أم اختيار فئة جديدة؟';

  @override
  String get newMatchKeepCategory => 'الإبقاء على الفئة';

  @override
  String get newMatchChangeCategory => 'تغيير الفئة';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String resultsWinnerWins(String name) {
    return '$name يفوز!';
  }

  @override
  String get resultsTheMastermind => 'العقل المدبر';

  @override
  String get resultsSecretWordWas => 'الكلمة السرية كانت:';

  @override
  String resultsOutPlayerWas(String name) {
    return '$name كان خارج الحلقة!';
  }

  @override
  String get resultsLeaderboard => 'لوحة المتصدرين';

  @override
  String get settings => 'الإعدادات';

  @override
  String get settingsScreenTitle => 'الإعدادات';

  @override
  String get settingsSectionLanguage => 'اللغة';

  @override
  String get settingsSectionAudio => 'الصوت';

  @override
  String get settingsSectionAbout => 'حول';

  @override
  String get settingsMusic => 'الموسيقى';

  @override
  String get settingsSoundEffects => 'المؤثرات الصوتية';

  @override
  String get settingsTermsOfUse => 'شروط الاستخدام';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsAppVersionLabel => 'إصدار التطبيق';

  @override
  String get settingsAppVersionValue => 'v0.1.0';

  @override
  String get settingsLanguagePortuguese => 'البرتغالية';

  @override
  String get settingsLanguageEnglish => 'الإنجليزية';

  @override
  String get settingsLanguageSpanish => 'الإسبانية';

  @override
  String get settingsLanguageHindi => 'الهندية';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get language => 'اللغة';

  @override
  String get howToPlayScreenTitle => 'كيف تلعب';

  @override
  String get howToPlayKapow => 'بوم!';

  @override
  String get howToPlaySecretTitle => 'السر';

  @override
  String get howToPlaySecretBodyBefore =>
      'كل لاعب يرى الكلمة السرية، إلا واحدًا... وهو ';

  @override
  String get howToPlaySecretBodyHighlight => 'خارج الحلقة!';

  @override
  String get howToPlayQuestionTitle => 'السؤال';

  @override
  String get howToPlayQuestionBodyBefore =>
      'أجب عن أسئلة مضحكة حول الكلمة دون جعلها واضحة جدًا. ';

  @override
  String get howToPlayQuestionBodyEmphasis => 'كن ذكيًا!';

  @override
  String get howToPlayVoteTitle => 'التصويت';

  @override
  String get howToPlayVoteBodyBefore => 'حاول اكتشاف من لا يعرف شيئًا و';

  @override
  String get howToPlayVoteBodyHighlight => 'صوّت!';

  @override
  String get howToPlayVoteBodyAfter => ' أشر بثقة.';

  @override
  String get howToPlayOutcomeTitle => 'الخاتمة';

  @override
  String get howToPlayOutcomeBodyBefore =>
      'إذا خمّن لاعب «خارج الحلقة» الكلمة في النهاية، ';

  @override
  String get howToPlayOutcomeBodyHighlight => 'يفوز';

  @override
  String get howToPlayOutcomeBodyAfter => ' ويصبح العقل المدبر!';
}
