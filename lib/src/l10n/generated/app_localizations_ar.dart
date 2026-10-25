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
  String get classicFixtureNotice => 'عينة دون اتصال · ليست القائمة النهائية';

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
  String get classicCrew => 'Your crew';

  @override
  String get classicNames => 'Edit names';

  @override
  String get classicCategories => 'Categories';

  @override
  String get classicImpostors => 'Imposters';

  @override
  String get classicAuto => 'Auto (recommended)';

  @override
  String get classicTimer => 'Discussion timer';

  @override
  String get classicDuration => 'Duration';

  @override
  String get classicTroll => 'Troll mode';

  @override
  String get classicSave => 'Save names';

  @override
  String get classicConfirm => 'Confirm';

  @override
  String get classicClear => 'Clear';

  @override
  String get classicSelectFree => 'Select all free';

  @override
  String get classicSelectAll => 'Select all';

  @override
  String get classicAll => 'All';

  @override
  String get classicDone => 'Done';

  @override
  String get classicAdd => 'Add player';

  @override
  String get classicRemove => 'Remove player';

  @override
  String get classicPlayer => 'Player';

  @override
  String get classicHelp => 'How to play';

  @override
  String get classicSettings => 'Settings';

  @override
  String get classicPremium => 'Premium · demo';

  @override
  String get classicDemoBuy => 'Enable Premium demo';

  @override
  String get classicDemoNotice =>
      'Development demo. Premium is simulated, with no real purchase. Three free categories have English content. Full catalog arrives in stage 5; resuming after closing the app arrives in stage 4.';

  @override
  String get classicStart => 'Start game';

  @override
  String get classicTitle => 'Who is the impostor?';

  @override
  String get classicSubtitle => 'One phone. Your friends. A secret word.';

  @override
  String get classicOff => 'Off';

  @override
  String get classicMinutes => 'minutes';

  @override
  String get classicShare => 'Share · available in stage 7';

  @override
  String get classicRate => 'Rate us · available in stage 7';

  @override
  String get classicFooter =>
      'Talk, bluff and vote together. No screens needed for the discussion.';

  @override
  String get classicHelpSteps =>
      '1. Gather 3–20 players around one phone.\n2. Hold to see your role; release to hide it.\n3. Give clues about the secret word.\n4. Impostors bluff and blend in.\n5. Discuss and vote in person.\n6. Confirm the reveal to see the word and impostors.\n\nHint shows only the category. Troll may make everyone an impostor.';

  @override
  String get classicEnglish => 'Content language: English (demo)';

  @override
  String get classicClose => 'Close';

  @override
  String get classicHold => 'Hold here to see your role';

  @override
  String get classicRelease =>
      'Release to hide. Only pass the phone when the card is covered.';

  @override
  String get classicShowRole => 'Reveal role · accessible alternative';

  @override
  String get classicHideRole => 'Hide role';

  @override
  String get classicYouImpostor => 'You’re an impostor';

  @override
  String get classicYourWord => 'Secret word';

  @override
  String get classicNext => 'Next player';

  @override
  String get classicDiscuss => 'Start discussion';

  @override
  String get classicStarts => 'First to give a clue';

  @override
  String get classicInPerson =>
      'Give clues, bluff, discuss and vote in person. When everyone is ready, reveal the result together.';

  @override
  String get classicPause => 'Pause timer';

  @override
  String get classicResume => 'Resume timer';

  @override
  String get classicTimeUp => 'Time is up. Keep talking or reveal when ready.';

  @override
  String get classicReveal => 'Reveal result';

  @override
  String get classicRevealQuestion => 'Reveal the secret?';

  @override
  String get classicRevealWarning =>
      'Everyone will see the word and all impostors. Finish your vote first.';

  @override
  String get classicCancel => 'Cancel';

  @override
  String get classicEnd => 'End round';

  @override
  String get classicExitQuestion => 'End this round?';

  @override
  String get classicExitWarning =>
      'Return to setup without revealing any secrets. This round cannot be resumed.';

  @override
  String get classicResult => 'The impostors were…';

  @override
  String get classicTrollResult => 'Troll round — everyone!';

  @override
  String get classicAgain => 'Play again';

  @override
  String get classicEditGame => 'Edit game';

  @override
  String get classicContentMissing =>
      'Some selected categories have no playable English content yet. Choose the free categories to start.';
}
