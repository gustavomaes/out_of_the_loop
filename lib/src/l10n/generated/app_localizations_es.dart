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
      'Catálogo sin conexión · revisión editorial pendiente';

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
  String get classicCrew => 'Tu grupo';

  @override
  String get classicNames => 'Editar nombres';

  @override
  String get classicCategories => 'Categorías';

  @override
  String get classicImpostors => 'Impostores';

  @override
  String get classicAuto => 'Auto (recomendado)';

  @override
  String get classicTimer => 'Tiempo de discusión';

  @override
  String get classicDuration => 'Duración';

  @override
  String get classicTroll => 'Modo Troll';

  @override
  String get classicSave => 'Guardar nombres';

  @override
  String get classicConfirm => 'Confirmar';

  @override
  String get classicClear => 'Borrar';

  @override
  String get classicSelectFree => 'Seleccionar todas gratis';

  @override
  String get classicSelectAll => 'Seleccionar todas';

  @override
  String get classicAll => 'Todas';

  @override
  String get classicDone => 'Listo';

  @override
  String get classicAdd => 'Añadir jugador';

  @override
  String get classicRemove => 'Eliminar jugador';

  @override
  String get classicPlayer => 'Jugador';

  @override
  String get classicHelp => 'Cómo jugar';

  @override
  String get classicSettings => 'Ajustes';

  @override
  String get classicPremium => 'Premium';

  @override
  String get classicDemoBuy => 'Activar demo Premium';

  @override
  String get classicDemoNotice => 'Demostración con compras simuladas.';

  @override
  String get classicStart => 'Empezar juego';

  @override
  String get classicTitle => '¿Quién es el impostor?';

  @override
  String get classicSubtitle => 'Un teléfono. Tus amigos. Una palabra secreta.';

  @override
  String get classicOff => 'Desactivado';

  @override
  String get classicMinutes => 'minutos';

  @override
  String get classicShare => 'Compartir';

  @override
  String get classicRate => 'Valorar la app';

  @override
  String get classicFooter =>
      'Hablen, engañen y voten juntos, sin pantallas durante la discusión.';

  @override
  String get classicHelpSteps =>
      '1. Reúne 3–20 jugadores con un teléfono.\n2. Mantén pulsado para revelar tu papel y suelta para ocultar.\n3. Den pistas sobre la palabra.\n4. Los impostores engañan.\n5. Hablen y voten en persona.\n6. Confirmen para revelar palabra e impostores.\n\nLa pista muestra solo la categoría. Troll puede hacer que todos sean impostores.';

  @override
  String get classicEnglish => 'Contenido en inglés';

  @override
  String get classicClose => 'Cerrar';

  @override
  String get classicHold => 'Mantén pulsado para ver tu papel';

  @override
  String get classicRelease =>
      'Suelta para ocultar. Pasa el teléfono con la tarjeta cubierta.';

  @override
  String get classicShowRole => 'Revelar papel · alternativa accesible';

  @override
  String get classicHideRole => 'Ocultar papel';

  @override
  String get classicYouImpostor => 'Eres un impostor';

  @override
  String get classicYourWord => 'Palabra secreta';

  @override
  String get classicNext => 'Siguiente jugador';

  @override
  String get classicDiscuss => 'Iniciar discusión';

  @override
  String get classicStarts => 'Primero en dar una pista';

  @override
  String get classicInPerson =>
      'Den pistas, engañen, hablen y voten en persona. Después revelen el resultado juntos.';

  @override
  String get classicPause => 'Pausar tiempo';

  @override
  String get classicResume => 'Reanudar tiempo';

  @override
  String get classicTimeUp =>
      'Se acabó el tiempo. Sigan hablando o revelen cuando quieran.';

  @override
  String get classicReveal => 'Revelar resultado';

  @override
  String get classicRevealQuestion => '¿Revelar el secreto?';

  @override
  String get classicRevealWarning =>
      'Todos verán la palabra y los impostores. Terminen de votar primero.';

  @override
  String get classicCancel => 'Cancelar';

  @override
  String get classicEnd => 'Terminar ronda';

  @override
  String get classicExitQuestion => '¿Terminar esta ronda?';

  @override
  String get classicExitWarning =>
      'Volver a los ajustes sin revelar secretos. Esta ronda no se podrá reanudar.';

  @override
  String get classicResult => 'Los impostores eran…';

  @override
  String get classicTrollResult => '¡Ronda Troll — todos!';

  @override
  String get classicAgain => 'Jugar de nuevo';

  @override
  String get classicEditGame => 'Editar juego';

  @override
  String get classicContentMissing =>
      'Hay categorías sin contenido en inglés. Elige las gratuitas para empezar.';

  @override
  String get classicRecoveryTitle => 'Recuperar partida';

  @override
  String get classicFutureSave =>
      'Esta partida requiere una app más reciente. Reintenta o juega temporalmente sin reemplazarla.';

  @override
  String get classicRecoveryBody =>
      'No se pudo leer la partida. Reintenta o inicia otra conservando grupo e historial válidos. Se conservan compras y ajustes.';

  @override
  String get classicNewGame => 'Nueva partida';

  @override
  String get classicDiscardBody =>
      '¿Descartar solo la ronda guardada? Se conservan grupo, historial, ajustes y compras.';

  @override
  String get classicResumeTitle => 'Partida en curso';

  @override
  String get classicResumeBody =>
      'Reanuda con tarjetas cubiertas y tiempo pausado, o termina esta ronda.';

  @override
  String get classicWriteFailure =>
      'No se pudo guardar. Reintenta o continúa sabiendo que al reabrir puedes volver al último paso guardado.';

  @override
  String get classicContinueUnsaved => 'Continuar sin guardar';

  @override
  String get classicUnsavedNotice =>
      'El progreso no está guardado. Al reabrir puedes perder avances recientes.';

  @override
  String get classicResetHistory => 'Borrar historial de palabras';

  @override
  String get classicResetHistoryBody =>
      '¿Borrar solo el historial de palabras e impostores? Se conservan grupo, ajustes y compras.';

  @override
  String get classicResumeGame => 'Reanudar partida';

  @override
  String get classicAccessChanged =>
      'El acceso cambió. Selección actualizada; toca de nuevo para continuar.';

  @override
  String get classicHaptics => 'Vibración';

  @override
  String get classicSupport => 'Contactar con soporte';

  @override
  String get classicFeedbackNotice =>
      'Abre un correo editable. Tú decides enviarlo; la app no confirma la entrega.';

  @override
  String get classicLinkCopied => 'Enlace de la app copiado.';

  @override
  String get classicActionUnavailable =>
      'Esta acción no está configurada o no está disponible en este dispositivo.';

  @override
  String get classicActionFailed => 'No se pudo completar. Reintenta.';

  @override
  String get classicCatalogNotice =>
      '3 categorías gratis. Contenido extra en inglés; títulos y palabras siguen el idioma del contenido.';

  @override
  String get premiumSummary =>
      '20 categorías extra · 800 palabras adicionales en inglés';

  @override
  String get premiumRenewal =>
      'Suscripción anual o semanal. Se renueva automáticamente hasta cancelarla en la tienda.';

  @override
  String get premiumActive => 'Premium está activo.';

  @override
  String get premiumAnnual => 'Anual';

  @override
  String get premiumWeekly => 'Semanal';

  @override
  String get premiumUnavailable =>
      'Planes no disponibles. El juego gratis sigue disponible.';

  @override
  String get premiumRestore => 'Restaurar compras';

  @override
  String get premiumManage => 'Gestionar suscripción';

  @override
  String get premiumTerms => 'Términos de uso';

  @override
  String get premiumNone => 'No se encontraron compras.';

  @override
  String get premiumRestored => 'Compras restauradas.';

  @override
  String get premiumRefreshError =>
      'No se pudieron actualizar las compras. Reintenta.';

  @override
  String get premiumVerifying =>
      'Compra pendiente de verificar acceso. Restaura o reintenta.';

  @override
  String get premiumCancelled => 'Compra cancelada.';

  @override
  String get premiumPending => 'Pago pendiente de aprobación.';

  @override
  String get premiumBuyError => 'Compra no disponible. Reintenta.';

  @override
  String get premiumVerifyError =>
      'No se pudo verificar la compra. Restaura o reintenta.';
}
