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
  String get pickCategory => 'Elige una categoria';

  @override
  String get addPlayer => 'Agregar jugador';

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
