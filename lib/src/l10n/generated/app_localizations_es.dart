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
  String get revealMyWord => 'Revelar mi palabra';

  @override
  String get outOfLoopMessage =>
      'Estas FUERA del circulo - actua con naturalidad.';

  @override
  String get doneAnswering => 'Termine de responder';

  @override
  String get whoIsOutOfTheLoop => 'Quien esta fuera del loop?';

  @override
  String get confirmVotes => 'Confirmar votos';

  @override
  String get roundResults => 'Resultados de la ronda';

  @override
  String get guessWord => 'Adivina la palabra';

  @override
  String get correct => 'Correcto';

  @override
  String get wrong => 'Incorrecto';

  @override
  String get playAgain => 'Jugar de nuevo';

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get settings => 'Configuracion';

  @override
  String get settingsScreenTitle => 'CONFIGURACIÓN';

  @override
  String get settingsSectionLanguage => 'IDIOMA';

  @override
  String get settingsSectionAudio => 'AUDIO';

  @override
  String get settingsSectionTimer => 'TEMPORIZADOR';

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
  String get settingsUseTimer => 'Usar temporizador';

  @override
  String settingsTimerSeconds(int seconds) {
    return '$seconds segundos por turno';
  }

  @override
  String get language => 'Idioma';

  @override
  String get timer => 'Timer';

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
      'Responde preguntas divertidas sobre la palabra sin revelarla del todo. ';

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
}
