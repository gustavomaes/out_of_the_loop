// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Out of the Loop';

  @override
  String get homeTagline => 'Todos lo saben. Menos uno.';

  @override
  String get startGame => 'INICIAR JUEGO';

  @override
  String get navPlay => 'JUGAR';

  @override
  String get navCategories => 'CATEGORÍAS';

  @override
  String get navProfile => 'PERFIL';

  @override
  String get howToPlay => 'CÓMO JUGAR';

  @override
  String get pickCategory => 'Elige una categoría';

  @override
  String get pickCategorySubtitle =>
      'Elige tu campo de batalla. El loop te espera.';

  @override
  String get categoryFoodAndDrink => 'Comida y Bebida';

  @override
  String get categoryTravel => 'Viajes';

  @override
  String get categoryMovies => 'Películas';

  @override
  String get categoryAnimals => 'Animales';

  @override
  String get categorySports => 'Deportes';

  @override
  String get categoryTech => 'Tecnología';

  @override
  String get categoriesLoadError => 'No se pudieron cargar las categorías.';

  @override
  String get addPlayer => 'Agregar jugador';

  @override
  String get addPlayerButton => 'AGREGAR';

  @override
  String get playerSetupTitleLine1 => '¿QUIÉN';

  @override
  String get playerSetupTitleLine2 => 'JUEGA?';

  @override
  String get playerSetupPlayerCountBadge => '3-9 JUGADORES';

  @override
  String get playerNameHint => 'Nombre del jugador';

  @override
  String get playerSetupStartGame => 'EMPEZAR JUEGO';

  @override
  String playerSetupRemovePlayer(String playerName) {
    return 'Eliminar a $playerName';
  }

  @override
  String get playerSetupErrorEmptyName => 'El nombre no puede estar vacío.';

  @override
  String get playerSetupErrorDuplicateName =>
      'Los nombres de los jugadores deben ser únicos.';

  @override
  String get playerSetupErrorTooManyPlayers =>
      'Una partida admite hasta 9 jugadores.';

  @override
  String get playerSetupErrorTooFewPlayers => 'Agrega al menos 3 jugadores.';

  @override
  String get playerSetupErrorInvalidRoundCount => 'Número de rondas no válido.';

  @override
  String get playerSetupErrorInvalidQuestions =>
      'Elige entre 1 y 3 preguntas por jugador.';

  @override
  String get playerSetupErrorInsufficientWords =>
      'Esta categoría no tiene suficientes palabras para tantas rondas.';

  @override
  String get playerSetupErrorInsufficientQuestions =>
      'Esta categoría no tiene suficientes preguntas para tantos jugadores.';

  @override
  String get matchSetupTitleLine1 => 'CONFIGURAR';

  @override
  String get matchSetupTitleLine2 => 'PARTIDA';

  @override
  String get matchSetupRulesBadge => '1–5 RONDAS · 1–3 PREGUNTAS';

  @override
  String get matchSetupSubtitle =>
      'Define las reglas antes de registrar a los jugadores.';

  @override
  String get matchSetupQuestionsSection => 'PREGUNTAS POR JUGADOR';

  @override
  String get matchSetupQuestionsDescription =>
      '¿Cuántas preguntas responde cada jugador en esta ronda?';

  @override
  String matchSetupQuestionsRecommendation(int recommended) {
    return 'Con 3–4 jugadores recomendamos $recommended; con 5 o más, 1 (hasta 3 si la categoría lo permite).';
  }

  @override
  String get matchSetupRoundsSection => 'RONDAS EN LA PARTIDA';

  @override
  String get matchSetupRoundsDescription =>
      '¿Cuántas rondas tendrá esta partida?';

  @override
  String matchSetupRoundsRecommended(int count) {
    return 'Recomendado: $count rondas.';
  }

  @override
  String matchSetupRoundsValue(int count) {
    return 'Rondas: $count';
  }

  @override
  String matchSetupQuestionCountChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count preguntas',
      one: '1 pregunta',
    );
    return '$_temp0';
  }

  @override
  String matchSetupSummary(int roundCount, int questionCount) {
    String _temp0 = intl.Intl.pluralLogic(
      roundCount,
      locale: localeName,
      other: '$roundCount rondas',
      one: '1 ronda',
    );
    String _temp1 = intl.Intl.pluralLogic(
      questionCount,
      locale: localeName,
      other: '$questionCount preguntas',
      one: '1 pregunta',
    );
    return '$_temp0 · $_temp1 por jugador';
  }

  @override
  String get matchSetupContinue => 'CONTINUAR';

  @override
  String get startMatch => 'Iniciar partida';

  @override
  String get revealMyWord => 'REVELAR MI PAPEL';

  @override
  String secretRevealRound(int roundNumber) {
    return 'RONDA $roundNumber';
  }

  @override
  String get secretRevealPassTo => 'PASA A';

  @override
  String secretRevealPassToPlayer(String playerName) {
    return '$playerName';
  }

  @override
  String secretRevealViewerLine1(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealViewerLine2 => 'verá su palabra';

  @override
  String get secretRevealHandPhoneLine => 'Pasa el móvil solo a esta persona.';

  @override
  String get secretRevealPrivacy =>
      'Asegúrate de que nadie más esté mirando la pantalla.';

  @override
  String secretRevealConfirmTitle(String playerName) {
    return '¿Es $playerName?';
  }

  @override
  String get secretRevealConfirmMessage =>
      'Confirma que solo quien debe ver la palabra tiene el móvil.';

  @override
  String get secretRevealConfirmYes => 'SÍ, REVELAR';

  @override
  String get secretRevealConfirmNo => 'AÚN NO';

  @override
  String get secretRevealTopSecret => 'TOP SECRETO';

  @override
  String get secretRevealNextPlayer => 'SIGUIENTE JUGADOR';

  @override
  String get secretRevealFinished => 'LISTO';

  @override
  String get secretRevealStartQuestions => 'INICIAR PREGUNTAS';

  @override
  String get questionsReadyTitleLine1 => '¿TODOS';

  @override
  String get questionsReadyTitleLine2 => 'LISTOS?';

  @override
  String get questionsReadyBody =>
      'Cuando todos hayan visto su palabra, empiecen la ronda de preguntas.';

  @override
  String get questionsReadyThemeLabel => 'TEMA';

  @override
  String get questionsReadyStartQuestions => 'INICIAR PREGUNTAS';

  @override
  String get outOfLoopMessage =>
      'Estás FUERA del círculo — actúa con naturalidad.';

  @override
  String get doneAnswering => 'Termine de responder';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return 'Turno de $playerName';
  }

  @override
  String get questionRoundAnsweringNow => 'RESPONDIENDO AHORA';

  @override
  String get questionRoundSpeakUp => '¡HABLA EN VOZ ALTA!';

  @override
  String get questionRoundSpeakUpLine1 =>
      'Responde la pregunta en voz alta para que';

  @override
  String get questionRoundSpeakUpLine2 => 'todos te escuchen.';

  @override
  String get questionRoundDoneAnswering => 'TERMINÉ DE RESPONDER';

  @override
  String get questionRoundNextQuestion => 'SIGUIENTE PREGUNTA';

  @override
  String get questionRoundGoToVoting => 'IR A VOTAR';

  @override
  String get questionRoundExitTitle => '¿Cancelar la partida?';

  @override
  String get questionRoundExitMessage =>
      'Si vuelves ahora, la partida se cancelará y regresarás a la selección de categorías.';

  @override
  String get questionRoundExitConfirm => 'CANCELAR PARTIDA';

  @override
  String get questionRoundExitStay => 'SEGUIR JUGANDO';

  @override
  String get whoIsOutOfTheLoop => 'Quien esta fuera del loop?';

  @override
  String get votingHeadlineWhoIs => 'QUIEN ESTA';

  @override
  String get votingHeadlineOutOf => 'FUERA DEL';

  @override
  String get votingHeadlineTheLoop => 'LOOP?';

  @override
  String get votingSubtitleLine1 => 'Encuentra al impostor! Vota al jugador';

  @override
  String get votingSubtitleLine2 => 'que crees que no conoce la palabra';

  @override
  String get votingSubtitleLine3 => 'secreta.';

  @override
  String get votingVote => 'VOTAR';

  @override
  String get votingYou => 'TU';

  @override
  String get votingCannotVoteSelf => 'NO PUEDES VOTARTE';

  @override
  String votingPlayerTurn(String playerName) {
    return 'Turno de $playerName para votar';
  }

  @override
  String get votingNow => 'VOTANDO AHORA';

  @override
  String get votingCandidatesSection => 'ELIGE UN SOSPECHOSO';

  @override
  String get confirmVotes => 'CONFIRMAR VOTOS';

  @override
  String get roundResults => 'RESULTADOS DE LA RONDA';

  @override
  String get roundResultsHeadlineAccent => 'RESULTADOS';

  @override
  String get roundResultsHeadlineMain => 'DE LA RONDA';

  @override
  String get roundResultsOutPlayerLabel => 'EL JUGADOR FUERA ERA';

  @override
  String get roundResultsMajorityFound =>
      'El grupo encontro al jugador fuera por mayoria.';

  @override
  String get roundResultsMajorityEscaped =>
      'El jugador fuera escapo de la votacion por mayoria.';

  @override
  String get roundResultsGuessReminderTitle => 'NO DIGAS LA PALABRA!';

  @override
  String get roundResultsGuessReminderLine1 =>
      'El jugador fuera intentara adivinar.';

  @override
  String get roundResultsGuessReminderLine2 =>
      'Quedense en silencio — no digan la palabra ni den pistas.';

  @override
  String get roundResultsVoteTotals => 'TOTAL DE VOTOS';

  @override
  String get roundResultsRoundPoints => 'PUNTOS DE LA RONDA';

  @override
  String roundResultsVoteCount(int count) {
    return '$count votos';
  }

  @override
  String roundResultsPointsGain(int points) {
    return '+$points';
  }

  @override
  String get roundResultsContinue => 'CONTINUAR';

  @override
  String roundResultsGoToRound(int roundNumber) {
    return 'IR A RONDA $roundNumber';
  }

  @override
  String get roundResultsViewFinalScore => 'VER CLASIFICACION FINAL';

  @override
  String get guessWord => 'ADIVINA LA PALABRA';

  @override
  String get guessHeadlineAccent => 'ADIVINA';

  @override
  String get guessHeadlineMain => 'LA PALABRA';

  @override
  String guessPlayerTurn(String name) {
    return 'Turno de $name';
  }

  @override
  String get guessInstructionLine1 => 'Di la palabra secreta en voz alta.';

  @override
  String get guessInstructionLine2 => 'El grupo decide si';

  @override
  String get guessInstructionLine3 => 'acertaste.';

  @override
  String get guessCorrectButton => 'ACERTO';

  @override
  String get guessWrongButton => 'FALLO';

  @override
  String get correct => 'Correcto';

  @override
  String get wrong => 'Incorrecto';

  @override
  String get playAgain => 'JUGAR DE NUEVO';

  @override
  String get newMatchDialogTitle => 'NUEVA PARTIDA';

  @override
  String get newMatchDialogMessage =>
      '¿Mantener la misma categoría o elegir otra?';

  @override
  String get newMatchKeepCategory => 'MANTENER CATEGORÍA';

  @override
  String get newMatchChangeCategory => 'CAMBIAR CATEGORÍA';

  @override
  String get backToHome => 'VOLVER AL INICIO';

  @override
  String resultsWinnerWins(String name) {
    return '¡$name gana!';
  }

  @override
  String get resultsTheMastermind => 'EL CEREBRO';

  @override
  String get resultsSecretWordWas => 'LA PALABRA SECRETA ERA:';

  @override
  String resultsOutPlayerWas(String name) {
    return '¡$name estaba fuera del loop!';
  }

  @override
  String get resultsLeaderboard => 'CLASIFICACIÓN';

  @override
  String get settings => 'Configuracion';

  @override
  String get settingsScreenTitle => 'CONFIGURACIÓN';

  @override
  String get settingsSectionLanguage => 'IDIOMA';

  @override
  String get settingsSectionAudio => 'AUDIO';

  @override
  String get settingsSectionAbout => 'ACERCA DE';

  @override
  String get settingsMusic => 'Música';

  @override
  String get settingsSoundEffects => 'Efectos de sonido';

  @override
  String get settingsTermsOfUse => 'Términos de uso';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsAppVersionLabel => 'Versión de la app';

  @override
  String get settingsAppVersionValue => 'v0.1.0';

  @override
  String get settingsLanguagePortuguese => 'Portugués';

  @override
  String get settingsLanguageEnglish => 'Inglés';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsLanguageHindi => 'Hindi';

  @override
  String get settingsLanguageArabic => 'Árabe';

  @override
  String get language => 'Idioma';

  @override
  String get howToPlayScreenTitle => 'CÓMO JUGAR';

  @override
  String get howToPlayKapow => '¡PUM!';

  @override
  String get howToPlaySecretTitle => 'EL SECRETO';

  @override
  String get howToPlaySecretBodyBefore =>
      'Cada jugador ve la palabra secreta, excepto uno... que está ';

  @override
  String get howToPlaySecretBodyHighlight => '¡Fuera del Loop!';

  @override
  String get howToPlayQuestionTitle => 'LA PREGUNTA';

  @override
  String get howToPlayQuestionBodyBefore =>
      'En modo guiado, responde las preguntas de la app. En modo libre, da una pista de una palabra. ';

  @override
  String get howToPlayQuestionBodyEmphasis => '¡Sé listo!';

  @override
  String get howToPlayVoteTitle => 'LA VOTACIÓN';

  @override
  String get howToPlayVoteBodyBefore =>
      'Intenta descubrir quién no sabe nada y ';

  @override
  String get howToPlayVoteBodyHighlight => '¡VOTA!';

  @override
  String get howToPlayVoteBodyAfter => ' Señala sin miedo.';

  @override
  String get howToPlayOutcomeTitle => 'EL DESENLACE';

  @override
  String get howToPlayOutcomeBodyBefore =>
      'Si el Fuera del Loop adivina la palabra al final, ';

  @override
  String get howToPlayOutcomeBodyHighlight => 'gana';

  @override
  String get howToPlayOutcomeBodyAfter => ' ¡y se convierte en el cerebro!';

  @override
  String get reviewPromptTitle => '¿Les gustó la partida?';

  @override
  String get reviewPromptMessage =>
      'Si la mesa se divirtió, una reseña en la tienda ayuda a que el juego llegue a más personas.';

  @override
  String get reviewPromptRate => 'VALORAR';

  @override
  String get reviewPromptLater => 'AHORA NO';

  @override
  String get gameModeLabel => '¿Cómo van a jugar?';

  @override
  String get guidedMode => 'Guiado';

  @override
  String get guidedModeDescription => 'Respondan las preguntas de la app.';

  @override
  String get freeMode => 'Modo libre';

  @override
  String get freeModeDescription =>
      'Den pistas de una palabra e intenten disimular.';

  @override
  String get freeClueTitle => 'Una palabra. Elige bien.';

  @override
  String get freeClueBody =>
      'Da una pista sin decir la palabra secreta. El impostor debe disimular.';

  @override
  String get clueDone => 'Ya di mi pista';

  @override
  String get anotherLap => 'Otra vuelta';

  @override
  String get voteNow => 'Votar ahora';

  @override
  String get cluesReady => 'Todos dieron una pista.';

  @override
  String get savedGroupHint =>
      'Tu último grupo está listo. Edita los nombres para cambiarlo.';

  @override
  String get historySection => 'Rondas nuevas';

  @override
  String get historyDescription =>
      'Se evitan palabras y preguntas recientes. Al agotar el paquete, vuelven las más antiguas.';

  @override
  String get resetHistory => 'Reiniciar historial de palabras';

  @override
  String get historyReset => 'Historial reiniciado.';

  @override
  String get forgetGroup => 'Olvidar grupo guardado';

  @override
  String get groupForgotten => 'Grupo guardado eliminado.';

  @override
  String get gameNightPacks => 'Paquetes para jugar juntos';

  @override
  String get packsSubtitle =>
      'Temas nuevos para tu próxima reunión. Contenido en inglés.';

  @override
  String get packPurchaseOnce => 'Compra única. Sin suscripción.';

  @override
  String get packOwned => 'Listo para jugar';

  @override
  String get packPlay => 'Jugar este paquete';

  @override
  String get packBuy => 'Desbloquear paquete';

  @override
  String get packUnavailable =>
      'Las compras no están disponibles ahora. Las categorías gratis siguen disponibles.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get purchaseFailed =>
      'No se pudo completar la compra. Inténtalo de nuevo.';

  @override
  String get purchasePending =>
      'Tu compra espera aprobación. Puedes seguir jugando gratis.';

  @override
  String get purchaseRestored =>
      'Compras verificadas. Tus paquetes disponibles aparecen abajo.';

  @override
  String get purchaseSuccess => 'Tu paquete está listo. ¡A jugar!';

  @override
  String get packEnglishOnly => 'Contenido en inglés';

  @override
  String get packBundleTitle => 'Colección Game Night';

  @override
  String get packBundleDescription =>
      'Los tres paquetes mostrados aquí con una sola compra.';

  @override
  String roundsOnlySummary(int roundCount) {
    return '$roundCount rondas · pistas de una palabra';
  }

  @override
  String packWordCount(int count) {
    return '$count palabras · guiado y libre';
  }

  @override
  String get readyToPlay => 'Para jugar';

  @override
  String get explorePacks => 'Explorar paquetes';

  @override
  String get packEnglishContent => 'Paquete con contenido en inglés';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Continuar';

  @override
  String get onboardingStart => 'Empezar partida';

  @override
  String get onboardingReplay => 'Repetir tutorial interactivo';

  @override
  String onboardingStep(int step) {
    return 'PASO $step DE 3';
  }

  @override
  String get onboardingSecretTitle => 'Todos lo saben. Menos uno.';

  @override
  String get onboardingSecretBody =>
      'Reúne de 3 a 9 personas. Todos reciben la misma palabra secreta, excepto una persona: ¡quien está Fuera del Loop tiene que fingir!';

  @override
  String get onboardingPassTitle => 'Mira tu secreto y pasa el móvil.';

  @override
  String get onboardingPassBody =>
      'Toca la tarjeta para practicar. En la partida, mira tu rol en privado, oculta la palabra y pasa el móvil a la siguiente persona.';

  @override
  String get onboardingVoteTitle => 'Da pistas. Finge. Vota.';

  @override
  String get onboardingVoteBody =>
      'En el modo guiado, responde preguntas. En el libre, da una pista de una palabra. Después, voten por quien está Fuera del Loop. ¡Si esa persona adivina la palabra al final, gana!';

  @override
  String get onboardingWord => 'Pizza';

  @override
  String get onboardingOut => 'Fuera del Loop';

  @override
  String get onboardingReveal => 'Toca para revelar';

  @override
  String get onboardingHide => 'Toca para ocultar';

  @override
  String get onboardingVoteLabel => '¿Quién está fingiendo?';

  @override
  String get onboardingSaveError => 'No se pudo guardar. Inténtalo de nuevo.';

  @override
  String get classicDevTitle => 'Classic · desarrollo';

  @override
  String get classicFixtureNotice =>
      'Datos locales de prueba · no es el catálogo final';

  @override
  String get classicHint => 'Pista de categoría';

  @override
  String get classicSheet => 'Panel de componentes';

  @override
  String get classicUnavailable => 'Juego disponible en la etapa 3';

  @override
  String get classicLoading => 'Cargando';

  @override
  String get classicError => 'Error de ejemplo';

  @override
  String get classicRetry => 'Reintentar';

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
