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
  String get homeTagline => 'Everyone knows. Except one.';

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
  String secretRevealViewerLine1(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealViewerLine2 => 'will see their word';

  @override
  String get secretRevealHandPhoneLine => 'Hand the phone only to this player.';

  @override
  String get secretRevealPrivacy =>
      'Make sure nobody else is looking at the screen.';

  @override
  String secretRevealConfirmTitle(String playerName) {
    return 'Is it $playerName?';
  }

  @override
  String get secretRevealConfirmMessage =>
      'Confirm only the person who should see the word is holding the phone.';

  @override
  String get secretRevealConfirmYes => 'YES, REVEAL';

  @override
  String get secretRevealConfirmNo => 'NOT YET';

  @override
  String get secretRevealTopSecret => 'TOP SECRET';

  @override
  String get secretRevealNextPlayer => 'NEXT PLAYER';

  @override
  String get secretRevealFinished => 'I\'M DONE';

  @override
  String get secretRevealStartQuestions => 'START QUESTIONS';

  @override
  String get questionsReadyTitleLine1 => 'EVERYONE';

  @override
  String get questionsReadyTitleLine2 => 'READY?';

  @override
  String get questionsReadyBody =>
      'When everyone has seen their word, start the question round.';

  @override
  String get questionsReadyThemeLabel => 'THEME';

  @override
  String get questionsReadyStartQuestions => 'START QUESTIONS';

  @override
  String get outOfLoopMessage => 'You are OUT of the loop - act naturally.';

  @override
  String get doneAnswering => 'Done answering';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return '$playerName\'s turn';
  }

  @override
  String get questionRoundAnsweringNow => 'ANSWERING NOW';

  @override
  String get questionRoundSpeakUp => 'SPEAK UP!';

  @override
  String get questionRoundSpeakUpLine1 => 'Answer the question aloud so';

  @override
  String get questionRoundSpeakUpLine2 => 'everyone can hear you.';

  @override
  String get questionRoundDoneAnswering => 'DONE ANSWERING';

  @override
  String get questionRoundNextQuestion => 'NEXT QUESTION';

  @override
  String get questionRoundGoToVoting => 'GO TO VOTING';

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
  String votingPlayerTurn(String playerName) {
    return '$playerName\'s turn to vote';
  }

  @override
  String get votingNow => 'VOTING NOW';

  @override
  String get votingCandidatesSection => 'PICK A SUSPECT';

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
  String get roundResultsGuessReminderTitle => 'DON\'T SAY THE WORD!';

  @override
  String get roundResultsGuessReminderLine1 =>
      'The out player gets to guess now.';

  @override
  String get roundResultsGuessReminderLine2 =>
      'Stay quiet — don\'t say the word or give hints.';

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
  String get newMatchDialogTitle => 'NEW MATCH';

  @override
  String get newMatchDialogMessage =>
      'Keep the same category or pick a new one?';

  @override
  String get newMatchKeepCategory => 'KEEP CATEGORY';

  @override
  String get newMatchChangeCategory => 'CHANGE CATEGORY';

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
  String get settingsLanguageArabic => 'Arabic';

  @override
  String get language => 'Language';

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
      'In Guided mode, answer the app’s questions. In Free play, give a one-word clue. ';

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

  @override
  String get reviewPromptTitle => 'Enjoyed the match?';

  @override
  String get reviewPromptMessage =>
      'If the table had fun, a store review helps the game reach more people.';

  @override
  String get reviewPromptRate => 'RATE THE APP';

  @override
  String get reviewPromptLater => 'NOT NOW';

  @override
  String get gameModeLabel => 'How will you play?';

  @override
  String get guidedMode => 'Guided';

  @override
  String get guidedModeDescription => 'Answer questions picked by the app.';

  @override
  String get freeMode => 'Free play';

  @override
  String get freeModeDescription =>
      'Give one-word clues and bluff your way through.';

  @override
  String get freeClueTitle => 'One word. Make it count.';

  @override
  String get freeClueBody =>
      'Say a clue out loud without saying the secret word. The imposter has to blend in.';

  @override
  String get clueDone => 'Clue given';

  @override
  String get anotherLap => 'One more lap';

  @override
  String get voteNow => 'Vote now';

  @override
  String get cluesReady => 'Everyone has given a clue.';

  @override
  String get savedGroupHint =>
      'Your last group is ready. Add or remove players as needed.';

  @override
  String get historySection => 'Fresh rounds';

  @override
  String get historyDescription =>
      'Recent words and questions are avoided on this device. When a pack runs out, the oldest words return.';

  @override
  String get resetHistory => 'Reset word history';

  @override
  String get historyReset => 'Word history reset.';

  @override
  String get forgetGroup => 'Forget saved group';

  @override
  String get groupForgotten => 'Saved group removed.';

  @override
  String get gameNightPacks => 'Game night packs';

  @override
  String get packsSubtitle =>
      'Fresh topics for your next hangout. English content.';

  @override
  String get packPurchaseOnce => 'One-time purchase. No subscription.';

  @override
  String get packOwned => 'Ready to play';

  @override
  String get packPlay => 'Play this pack';

  @override
  String get packBuy => 'Unlock pack';

  @override
  String get packUnavailable =>
      'Purchases are unavailable right now. Your free categories are still ready to play.';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get purchaseFailed =>
      'We could not complete that purchase. Please try again.';

  @override
  String get purchasePending =>
      'Your purchase is pending approval. You can keep playing free categories.';

  @override
  String get purchaseRestored =>
      'Purchases checked. Your available packs are shown below.';

  @override
  String get purchaseSuccess => 'Your pack is ready. Let’s play!';

  @override
  String get packEnglishOnly => 'English content';

  @override
  String get packBundleTitle => 'Game Night Collection';

  @override
  String get packBundleDescription =>
      'All three packs listed here. Keep them with a single purchase.';

  @override
  String roundsOnlySummary(int roundCount) {
    return '$roundCount rounds · one-word clues';
  }

  @override
  String packWordCount(int count) {
    return '$count words · guided and free play';
  }

  @override
  String get readyToPlay => 'Ready to play';

  @override
  String get explorePacks => 'Explore packs';

  @override
  String get packEnglishContent => 'Pack with English content';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Continue';

  @override
  String get onboardingStart => 'Start a game';

  @override
  String get onboardingReplay => 'Replay interactive tutorial';

  @override
  String onboardingStep(int step) {
    return 'STEP $step OF 3';
  }

  @override
  String get onboardingSecretTitle => 'Everyone knows. Except one.';

  @override
  String get onboardingSecretBody =>
      'Gather 3 to 9 people. Everyone gets the same secret word except one person: the player Out of the Loop has to bluff!';

  @override
  String get onboardingPassTitle => 'Peek, hide, and pass the phone.';

  @override
  String get onboardingPassBody =>
      'Tap the card to practice. In a real game, check your role privately, hide the word, and pass the phone to the next person.';

  @override
  String get onboardingVoteTitle => 'Give clues. Bluff. Vote.';

  @override
  String get onboardingVoteBody =>
      'In guided mode, answer questions. In free mode, give a one-word clue. Then vote for who is Out of the Loop. If that player guesses the word at the end, they win!';

  @override
  String get onboardingWord => 'Pizza';

  @override
  String get onboardingOut => 'Out of the Loop';

  @override
  String get onboardingReveal => 'Tap to reveal';

  @override
  String get onboardingHide => 'Tap to hide';

  @override
  String get onboardingVoteLabel => 'Who is bluffing?';

  @override
  String get onboardingSaveError => 'Could not save. Please try again.';

  @override
  String get classicDevTitle => 'Classic · development';

  @override
  String get classicFixtureNotice =>
      'Offline catalog · editorial review pending';

  @override
  String get classicHint => 'Category hint';

  @override
  String get classicSheet => 'Component sheet';

  @override
  String get classicUnavailable => 'Game available in stage 3';

  @override
  String get classicLoading => 'Loading';

  @override
  String get classicError => 'Example error';

  @override
  String get classicRetry => 'Retry';

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

  @override
  String get classicRecoveryTitle => 'Saved game recovery';

  @override
  String get classicFutureSave =>
      'This save needs a newer app. You can retry or play temporarily without replacing it.';

  @override
  String get classicRecoveryBody =>
      'The saved game could not be read. Retry or start a new game with the valid group and history. Purchases and settings are preserved.';

  @override
  String get classicNewGame => 'New game';

  @override
  String get classicDiscardBody =>
      'Discard only the saved round? Your group, history, settings and purchases will stay.';

  @override
  String get classicResumeTitle => 'Game in progress';

  @override
  String get classicResumeBody =>
      'Resume with cards covered and the timer paused, or end this round.';

  @override
  String get classicWriteFailure =>
      'The game could not be saved. Retry, or continue knowing reopening may return to the last saved transition.';

  @override
  String get classicContinueUnsaved => 'Continue without saving';

  @override
  String get classicUnsavedNotice =>
      'Progress is not saved. Reopening may lose recent progress.';

  @override
  String get classicResetHistory => 'Reset word history';

  @override
  String get classicResetHistoryBody =>
      'Clear only word and impostor history? Your group, settings and purchases will stay.';

  @override
  String get classicResumeGame => 'Resume game';
}
