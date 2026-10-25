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
  String get homeTagline => 'الجميع يعرف. إلا واحدًا.';

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
  String secretRevealViewerLine1(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealViewerLine2 => 'سيرى كلمته';

  @override
  String get secretRevealHandPhoneLine => 'مرّر الهاتف لهذا اللاعب فقط.';

  @override
  String get secretRevealPrivacy => 'تأكد أن لا أحد آخر ينظر إلى الشاشة.';

  @override
  String secretRevealConfirmTitle(String playerName) {
    return 'هل هذا $playerName؟';
  }

  @override
  String get secretRevealConfirmMessage =>
      'أكّد أن من يمسك الهاتف هو من يجب أن يرى الكلمة فقط.';

  @override
  String get secretRevealConfirmYes => 'نعم، اكشف';

  @override
  String get secretRevealConfirmNo => 'ليس بعد';

  @override
  String get secretRevealTopSecret => 'سري للغاية';

  @override
  String get secretRevealNextPlayer => 'اللاعب التالي';

  @override
  String get secretRevealFinished => 'انتهيت';

  @override
  String get secretRevealStartQuestions => 'ابدأ الأسئلة';

  @override
  String get questionsReadyTitleLine1 => 'الجميع';

  @override
  String get questionsReadyTitleLine2 => 'جاهز؟';

  @override
  String get questionsReadyBody =>
      'عندما يرى الجميع كلمتهم، ابدأوا جولة الأسئلة.';

  @override
  String get questionsReadyThemeLabel => 'الموضوع';

  @override
  String get questionsReadyStartQuestions => 'ابدأ الأسئلة';

  @override
  String get outOfLoopMessage => 'أنت خارج الحلقة — تصرف بشكل طبيعي.';

  @override
  String get doneAnswering => 'انتهيت من الإجابة';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return 'دور $playerName';
  }

  @override
  String get questionRoundAnsweringNow => 'يجيب الآن';

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
  String votingPlayerTurn(String playerName) {
    return 'دور $playerName للتصويت';
  }

  @override
  String get votingNow => 'يصوّت الآن';

  @override
  String get votingCandidatesSection => 'اختر مشتبهاً';

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
  String get roundResultsGuessReminderTitle => 'لا تقل الكلمة!';

  @override
  String get roundResultsGuessReminderLine1 =>
      'سيحاول اللاعب الخارج تخمينها الآن.';

  @override
  String get roundResultsGuessReminderLine2 =>
      'ابقوا صامتين — لا تقولوا الكلمة ولا تعطوا تلميحات.';

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
      'في اللعب الموجّه، أجب عن أسئلة التطبيق. في اللعب الحر، قدّم تلميحًا من كلمة واحدة. ';

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

  @override
  String get reviewPromptTitle => 'هل استمتعتم بالمباراة؟';

  @override
  String get reviewPromptMessage =>
      'إذا استمتعت المجموعة، فتقييم في المتجر يساعد اللعبة على الوصول إلى المزيد من الطاولات.';

  @override
  String get reviewPromptRate => 'قيّم التطبيق';

  @override
  String get reviewPromptLater => 'ليس الآن';

  @override
  String get gameModeLabel => 'كيف ستلعبون؟';

  @override
  String get guidedMode => 'موجّه';

  @override
  String get guidedModeDescription => 'أجيبوا عن أسئلة التطبيق.';

  @override
  String get freeMode => 'لعب حر';

  @override
  String get freeModeDescription =>
      'قدّموا تلميحات من كلمة واحدة وحاولوا التمويه.';

  @override
  String get freeClueTitle => 'كلمة واحدة. اخترها بعناية.';

  @override
  String get freeClueBody =>
      'قل تلميحًا دون ذكر الكلمة السرية. على المتسلل الاندماج.';

  @override
  String get clueDone => 'قدّمت تلميحي';

  @override
  String get anotherLap => 'جولة أخرى';

  @override
  String get voteNow => 'صوّتوا الآن';

  @override
  String get cluesReady => 'قدّم الجميع تلميحًا.';

  @override
  String get savedGroupHint => 'مجموعتك السابقة جاهزة. عدّل الأسماء لتغييرها.';

  @override
  String get historySection => 'جولات جديدة';

  @override
  String get historyDescription =>
      'نتجنب الكلمات والأسئلة الحديثة. عند نفاد الحزمة، تعود الأقدم.';

  @override
  String get resetHistory => 'إعادة ضبط سجل الكلمات';

  @override
  String get historyReset => 'تمت إعادة ضبط سجل الكلمات.';

  @override
  String get forgetGroup => 'نسيان المجموعة المحفوظة';

  @override
  String get groupForgotten => 'تم حذف المجموعة المحفوظة.';

  @override
  String get gameNightPacks => 'حزم ليلة الألعاب';

  @override
  String get packsSubtitle =>
      'مواضيع جديدة للقائكم القادم. المحتوى بالإنجليزية.';

  @override
  String get packPurchaseOnce => 'شراء لمرة واحدة. دون اشتراك.';

  @override
  String get packOwned => 'جاهز للعب';

  @override
  String get packPlay => 'العب بهذه الحزمة';

  @override
  String get packBuy => 'افتح الحزمة';

  @override
  String get packUnavailable =>
      'الشراء غير متاح حاليًا. الفئات المجانية لا تزال متاحة.';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get purchaseFailed => 'تعذّر إتمام الشراء. حاول مجددًا.';

  @override
  String get purchasePending =>
      'عملية الشراء بانتظار الموافقة. يمكنك مواصلة اللعب مجانًا.';

  @override
  String get purchaseRestored => 'تم التحقق من المشتريات. الحزم المتاحة أدناه.';

  @override
  String get purchaseSuccess => 'حزمتك جاهزة. لنلعب!';

  @override
  String get packEnglishOnly => 'محتوى بالإنجليزية';

  @override
  String get packBundleTitle => 'مجموعة ليلة الألعاب';

  @override
  String get packBundleDescription =>
      'الحزم الثلاث المعروضة هنا بعملية شراء واحدة.';

  @override
  String roundsOnlySummary(int roundCount) {
    return '$roundCount جولات · تلميحات من كلمة واحدة';
  }

  @override
  String packWordCount(int count) {
    return '$count كلمة · لعب موجّه وحر';
  }

  @override
  String get readyToPlay => 'جاهز للعب';

  @override
  String get explorePacks => 'استكشف الحزم';

  @override
  String get packEnglishContent => 'حزمة بمحتوى باللغة الإنجليزية';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'متابعة';

  @override
  String get onboardingStart => 'بدء جولة';

  @override
  String get onboardingReplay => 'إعادة الشرح التفاعلي';

  @override
  String onboardingStep(int step) {
    return 'الخطوة $step من 3';
  }

  @override
  String get onboardingSecretTitle => 'الجميع يعرف. إلا واحدًا.';

  @override
  String get onboardingSecretBody =>
      'اجمع من 3 إلى 9 أشخاص. يحصل الجميع على الكلمة السرية نفسها باستثناء شخص واحد: على اللاعب خارج الحلقة أن يتظاهر بمعرفتها!';

  @override
  String get onboardingPassTitle => 'شاهد سرك ومرر الهاتف.';

  @override
  String get onboardingPassBody =>
      'اضغط على البطاقة للتدريب. في اللعبة، شاهد دورك وحدك ثم أخفِ الكلمة ومرر الهاتف إلى اللاعب التالي.';

  @override
  String get onboardingVoteTitle => 'أعطِ تلميحات. خادع. صوّت.';

  @override
  String get onboardingVoteBody =>
      'في الوضع الموجّه، أجب عن الأسئلة. في الوضع الحر، أعطِ تلميحًا من كلمة واحدة. ثم صوّتوا لمن هو خارج الحلقة. إذا خمن ذلك اللاعب الكلمة في النهاية، يفوز!';

  @override
  String get onboardingWord => 'بيتزا';

  @override
  String get onboardingOut => 'خارج الحلقة';

  @override
  String get onboardingReveal => 'اضغط للكشف';

  @override
  String get onboardingHide => 'اضغط للإخفاء';

  @override
  String get onboardingVoteLabel => 'من يخادع؟';

  @override
  String get onboardingSaveError => 'تعذر الحفظ. حاول مرة أخرى.';

  @override
  String get classicDevTitle => 'Classic · تطوير';

  @override
  String get classicFixtureNotice =>
      'قائمة دون اتصال · المراجعة التحريرية معلقة';

  @override
  String get classicHint => 'تلميح الفئة';

  @override
  String get classicSheet => 'لوحة المكونات';

  @override
  String get classicUnavailable => 'اللعبة متاحة في المرحلة 3';

  @override
  String get classicLoading => 'جارٍ التحميل';

  @override
  String get classicError => 'خطأ تجريبي';

  @override
  String get classicRetry => 'إعادة المحاولة';

  @override
  String get classicCrew => 'مجموعتك';

  @override
  String get classicNames => 'تعديل الأسماء';

  @override
  String get classicCategories => 'الفئات';

  @override
  String get classicImpostors => 'المحتالون';

  @override
  String get classicAuto => 'تلقائي (موصى به)';

  @override
  String get classicTimer => 'مؤقت النقاش';

  @override
  String get classicDuration => 'المدة';

  @override
  String get classicTroll => 'وضع المقلب';

  @override
  String get classicSave => 'حفظ الأسماء';

  @override
  String get classicConfirm => 'تأكيد';

  @override
  String get classicClear => 'مسح';

  @override
  String get classicSelectFree => 'تحديد كل المجاني';

  @override
  String get classicSelectAll => 'تحديد الكل';

  @override
  String get classicAll => 'الكل';

  @override
  String get classicDone => 'تم';

  @override
  String get classicAdd => 'إضافة لاعب';

  @override
  String get classicRemove => 'إزالة لاعب';

  @override
  String get classicPlayer => 'لاعب';

  @override
  String get classicHelp => 'طريقة اللعب';

  @override
  String get classicSettings => 'الإعدادات';

  @override
  String get classicPremium => 'Premium';

  @override
  String get classicDemoBuy => 'تفعيل عرض Premium التجريبي';

  @override
  String get classicDemoNotice => 'عرض تطوير بمشتريات تجريبية.';

  @override
  String get classicStart => 'بدء اللعبة';

  @override
  String get classicTitle => 'من هو المحتال؟';

  @override
  String get classicSubtitle => 'هاتف واحد. أصدقاؤك. كلمة سرية.';

  @override
  String get classicOff => 'إيقاف';

  @override
  String get classicMinutes => 'دقائق';

  @override
  String get classicShare => 'مشاركة';

  @override
  String get classicRate => 'تقييم التطبيق';

  @override
  String get classicFooter =>
      'تحدثوا وخادعوا وصوتوا معًا دون الحاجة للشاشة أثناء النقاش.';

  @override
  String get classicHelpSteps =>
      '1. اجمعوا 3–20 لاعبًا مع هاتف واحد.\n2. اضغط مطولًا لكشف الدور وارفع إصبعك لإخفائه.\n3. قدموا تلميحات عن الكلمة.\n4. يخادع المحتالون.\n5. ناقشوا وصوتوا وجهًا لوجه.\n6. أكدوا لكشف الكلمة والمحتالين.\n\nالتلميح يعرض الفئة فقط. قد يجعل المقلب الجميع محتالين.';

  @override
  String get classicEnglish => 'المحتوى باللغة الإنجليزية';

  @override
  String get classicClose => 'إغلاق';

  @override
  String get classicHold => 'اضغط مطولًا هنا لرؤية دورك';

  @override
  String get classicRelease =>
      'ارفع إصبعك للإخفاء. مرر الهاتف فقط بعد تغطية البطاقة.';

  @override
  String get classicShowRole => 'كشف الدور · خيار ميسر';

  @override
  String get classicHideRole => 'إخفاء الدور';

  @override
  String get classicYouImpostor => 'أنت محتال';

  @override
  String get classicYourWord => 'الكلمة السرية';

  @override
  String get classicNext => 'اللاعب التالي';

  @override
  String get classicDiscuss => 'بدء النقاش';

  @override
  String get classicStarts => 'أول من يعطي تلميحًا';

  @override
  String get classicInPerson =>
      'قدموا تلميحات وخادعوا وناقشوا وصوتوا وجهًا لوجه. ثم اكشفوا النتيجة معًا.';

  @override
  String get classicPause => 'إيقاف المؤقت مؤقتًا';

  @override
  String get classicResume => 'استئناف المؤقت';

  @override
  String get classicTimeUp =>
      'انتهى الوقت. واصلوا الحديث أو اكشفوا النتيجة عندما تستعدون.';

  @override
  String get classicReveal => 'كشف النتيجة';

  @override
  String get classicRevealQuestion => 'كشف السر؟';

  @override
  String get classicRevealWarning =>
      'سيرى الجميع الكلمة والمحتالين. أنهوا التصويت أولًا.';

  @override
  String get classicCancel => 'إلغاء';

  @override
  String get classicEnd => 'إنهاء الجولة';

  @override
  String get classicExitQuestion => 'إنهاء هذه الجولة؟';

  @override
  String get classicExitWarning =>
      'العودة للإعداد دون كشف الأسرار. لا يمكن استئناف هذه الجولة.';

  @override
  String get classicResult => 'المحتالون هم…';

  @override
  String get classicTrollResult => 'جولة المقلب — الجميع!';

  @override
  String get classicAgain => 'العبوا مجددًا';

  @override
  String get classicEditGame => 'تعديل اللعبة';

  @override
  String get classicContentMissing =>
      'بعض الفئات بلا محتوى إنجليزي متاح. اختر الفئات المجانية للبدء.';

  @override
  String get classicRecoveryTitle => 'استعادة اللعبة المحفوظة';

  @override
  String get classicFutureSave =>
      'يتطلب هذا الحفظ تطبيقًا أحدث. أعد المحاولة أو العب مؤقتًا دون استبداله.';

  @override
  String get classicRecoveryBody =>
      'تعذرت قراءة اللعبة المحفوظة. أعد المحاولة أو ابدأ لعبة جديدة بالمجموعة والسجل الصالحين. تبقى المشتريات والإعدادات.';

  @override
  String get classicNewGame => 'لعبة جديدة';

  @override
  String get classicDiscardBody =>
      'تجاهل الجولة المحفوظة فقط؟ ستبقى المجموعة والسجل والإعدادات والمشتريات.';

  @override
  String get classicResumeTitle => 'لعبة جارية';

  @override
  String get classicResumeBody =>
      'استأنف ببطاقات مغطاة ومؤقت متوقف أو أنهِ الجولة.';

  @override
  String get classicWriteFailure =>
      'تعذر الحفظ. أعد المحاولة أو تابع مع العلم أن إعادة الفتح قد تعيدك إلى آخر خطوة محفوظة.';

  @override
  String get classicContinueUnsaved => 'المتابعة دون حفظ';

  @override
  String get classicUnsavedNotice =>
      'التقدم غير محفوظ. قد تفقد التقدم الأخير عند إعادة الفتح.';

  @override
  String get classicResetHistory => 'مسح سجل الكلمات';

  @override
  String get classicResetHistoryBody =>
      'مسح سجل الكلمات والمحتالين فقط؟ ستبقى المجموعة والإعدادات والمشتريات.';

  @override
  String get classicResumeGame => 'استئناف اللعبة';

  @override
  String get classicAccessChanged =>
      'تغير الوصول. تم تحديث الاختيار؛ اضغط مجددًا للمتابعة.';

  @override
  String get classicHaptics => 'الاهتزاز';

  @override
  String get classicSupport => 'التواصل مع الدعم';

  @override
  String get classicFeedbackNotice =>
      'يفتح رسالة بريد قابلة للتعديل. أنت تقرر إرسالها؛ لا يمكن للتطبيق تأكيد وصولها.';

  @override
  String get classicLinkCopied => 'تم نسخ رابط التطبيق.';

  @override
  String get classicActionUnavailable =>
      'هذا الإجراء غير مهيأ أو غير متاح على هذا الجهاز.';

  @override
  String get classicActionFailed => 'تعذر إكمال الإجراء. أعد المحاولة.';

  @override
  String get classicCatalogNotice =>
      '3 فئات مجانية. المحتوى الإضافي بالإنجليزية؛ تتبع العناوين والكلمات لغة المحتوى.';

  @override
  String get premiumSummary => '20 فئة إضافية · 800 كلمة إنجليزية إضافية';

  @override
  String get premiumRenewal =>
      'اشتراك سنوي أو أسبوعي. يتجدد تلقائيًا ما لم يُلغَ في إعدادات المتجر.';

  @override
  String get premiumActive => 'Premium مفعّل.';

  @override
  String get premiumAnnual => 'سنوي';

  @override
  String get premiumWeekly => 'أسبوعي';

  @override
  String get premiumUnavailable =>
      'خطط المتجر غير متاحة. يبقى اللعب المجاني متاحًا.';

  @override
  String get premiumRestore => 'استعادة المشتريات';

  @override
  String get premiumManage => 'إدارة الاشتراك';

  @override
  String get premiumTerms => 'شروط الاستخدام';

  @override
  String get premiumNone => 'لم يتم العثور على مشتريات.';

  @override
  String get premiumRestored => 'تمت استعادة المشتريات.';

  @override
  String get premiumRefreshError => 'تعذر تحديث المشتريات. أعد المحاولة.';

  @override
  String get premiumVerifying =>
      'الشراء ينتظر التحقق من الوصول. استعد المشتريات أو أعد المحاولة.';

  @override
  String get premiumCancelled => 'تم إلغاء الشراء.';

  @override
  String get premiumPending => 'الدفع بانتظار الموافقة.';

  @override
  String get premiumBuyError => 'الشراء غير متاح. أعد المحاولة.';

  @override
  String get premiumVerifyError =>
      'تعذر التحقق من الشراء. استعد المشتريات أو أعد المحاولة.';
}
