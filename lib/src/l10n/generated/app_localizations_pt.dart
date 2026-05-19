// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Out of the Loop';

  @override
  String get startGame => 'JOGAR';

  @override
  String get navPlay => 'INÍCIO';

  @override
  String get navCategories => 'CATEGORIAS';

  @override
  String get navProfile => 'PERFIL';

  @override
  String get howToPlay => 'COMO JOGAR';

  @override
  String get pickCategory => 'Escolha uma categoria';

  @override
  String get pickCategorySubtitle =>
      'Escolha seu campo de batalha. O loop aguarda.';

  @override
  String get categoryFoodAndDrink => 'Comida e Bebida';

  @override
  String get categoryTravel => 'Viagem';

  @override
  String get categoryMovies => 'Filmes';

  @override
  String get categoryAnimals => 'Animais';

  @override
  String get categorySports => 'Esportes';

  @override
  String get categoryTech => 'Tecnologia';

  @override
  String get categoriesLoadError => 'Não foi possível carregar as categorias.';

  @override
  String get addPlayer => 'Adicionar jogador';

  @override
  String get startMatch => 'Iniciar partida';

  @override
  String get revealMyWord => 'Visualizar minha palavra';

  @override
  String get outOfLoopMessage =>
      'Voce esta FORA do circulo - aja naturalmente.';

  @override
  String get doneAnswering => 'Terminei de responder';

  @override
  String get whoIsOutOfTheLoop => 'Quem esta fora do loop?';

  @override
  String get confirmVotes => 'Confirmar votos';

  @override
  String get roundResults => 'Resultado da rodada';

  @override
  String get guessWord => 'Adivinhe a palavra';

  @override
  String get correct => 'Acertou';

  @override
  String get wrong => 'Errou';

  @override
  String get playAgain => 'Nova partida';

  @override
  String get backToHome => 'Voltar ao inicio';

  @override
  String get settings => 'Configuracoes';

  @override
  String get settingsScreenTitle => 'CONFIGURAÇÕES';

  @override
  String get settingsSectionLanguage => 'IDIOMA';

  @override
  String get settingsSectionAudio => 'ÁUDIO';

  @override
  String get settingsSectionTimer => 'TIMER';

  @override
  String get settingsSectionAbout => 'SOBRE';

  @override
  String get settingsMusic => 'Música';

  @override
  String get settingsSoundEffects => 'Efeitos Sonoros';

  @override
  String get settingsTermsOfUse => 'Termos de Uso';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsAppVersionLabel => 'Versão do App';

  @override
  String get settingsAppVersionValue => 'v0.1.0';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsLanguageHindi => 'Hindi';

  @override
  String get settingsUseTimer => 'Usar timer';

  @override
  String settingsTimerSeconds(int seconds) {
    return '$seconds segundos por turno';
  }

  @override
  String get language => 'Idioma';

  @override
  String get timer => 'Timer';

  @override
  String get howToPlayScreenTitle => 'COMO JOGAR';

  @override
  String get howToPlayKapow => 'KA-POW!';

  @override
  String get howToPlaySecretTitle => 'O SEGREDO';

  @override
  String get howToPlaySecretBodyBefore =>
      'Cada jogador vê a palavra secreta, exceto um... que está ';

  @override
  String get howToPlaySecretBodyHighlight => 'Fora do Loop!';

  @override
  String get howToPlayQuestionTitle => 'A PERGUNTA';

  @override
  String get howToPlayQuestionBodyBefore =>
      'Responda perguntas engraçadas sobre a palavra sem dar na cara o que é. ';

  @override
  String get howToPlayQuestionBodyEmphasis => 'Seja esperto!';

  @override
  String get howToPlayVoteTitle => 'A VOTAÇÃO';

  @override
  String get howToPlayVoteBodyBefore =>
      'Tente descobrir quem não sabe de nada e ';

  @override
  String get howToPlayVoteBodyHighlight => 'VOTE!';

  @override
  String get howToPlayVoteBodyAfter => ' Aponte o dedo sem medo.';

  @override
  String get howToPlayOutcomeTitle => 'O DESFECHO';

  @override
  String get howToPlayOutcomeBodyBefore =>
      'Se o Fora do Loop adivinhar a palavra no final, ';

  @override
  String get howToPlayOutcomeBodyHighlight => 'ele ganha';

  @override
  String get howToPlayOutcomeBodyAfter => ' e vira o mestre!';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Out of the Loop';

  @override
  String get startGame => 'JOGAR';

  @override
  String get navPlay => 'INÍCIO';

  @override
  String get navCategories => 'CATEGORIAS';

  @override
  String get navProfile => 'PERFIL';

  @override
  String get howToPlay => 'COMO JOGAR';

  @override
  String get pickCategory => 'Escolha uma categoria';

  @override
  String get pickCategorySubtitle =>
      'Escolha seu campo de batalha. O loop aguarda.';

  @override
  String get categoryFoodAndDrink => 'Comida e Bebida';

  @override
  String get categoryTravel => 'Viagem';

  @override
  String get categoryMovies => 'Filmes';

  @override
  String get categoryAnimals => 'Animais';

  @override
  String get categorySports => 'Esportes';

  @override
  String get categoryTech => 'Tecnologia';

  @override
  String get categoriesLoadError => 'Não foi possível carregar as categorias.';

  @override
  String get addPlayer => 'Adicionar jogador';

  @override
  String get startMatch => 'Iniciar partida';

  @override
  String get revealMyWord => 'Visualizar minha palavra';

  @override
  String get outOfLoopMessage =>
      'Voce esta FORA do circulo - aja naturalmente.';

  @override
  String get doneAnswering => 'Terminei de responder';

  @override
  String get whoIsOutOfTheLoop => 'Quem esta fora do loop?';

  @override
  String get confirmVotes => 'Confirmar votos';

  @override
  String get roundResults => 'Resultado da rodada';

  @override
  String get guessWord => 'Adivinhe a palavra';

  @override
  String get correct => 'Acertou';

  @override
  String get wrong => 'Errou';

  @override
  String get playAgain => 'Nova partida';

  @override
  String get backToHome => 'Voltar ao inicio';

  @override
  String get settings => 'Configuracoes';

  @override
  String get settingsScreenTitle => 'CONFIGURAÇÕES';

  @override
  String get settingsSectionLanguage => 'IDIOMA';

  @override
  String get settingsSectionAudio => 'ÁUDIO';

  @override
  String get settingsSectionTimer => 'TIMER';

  @override
  String get settingsSectionAbout => 'SOBRE';

  @override
  String get settingsMusic => 'Música';

  @override
  String get settingsSoundEffects => 'Efeitos Sonoros';

  @override
  String get settingsTermsOfUse => 'Termos de Uso';

  @override
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsAppVersionLabel => 'Versão do App';

  @override
  String get settingsAppVersionValue => 'v0.1.0';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsLanguageHindi => 'Hindi';

  @override
  String get settingsUseTimer => 'Usar timer';

  @override
  String settingsTimerSeconds(int seconds) {
    return '$seconds segundos por turno';
  }

  @override
  String get language => 'Idioma';

  @override
  String get timer => 'Timer';

  @override
  String get howToPlayScreenTitle => 'COMO JOGAR';

  @override
  String get howToPlayKapow => 'KA-POW!';

  @override
  String get howToPlaySecretTitle => 'O SEGREDO';

  @override
  String get howToPlaySecretBodyBefore =>
      'Cada jogador vê a palavra secreta, exceto um... que está ';

  @override
  String get howToPlaySecretBodyHighlight => 'Fora do Loop!';

  @override
  String get howToPlayQuestionTitle => 'A PERGUNTA';

  @override
  String get howToPlayQuestionBodyBefore =>
      'Responda perguntas engraçadas sobre a palavra sem dar na cara o que é. ';

  @override
  String get howToPlayQuestionBodyEmphasis => 'Seja esperto!';

  @override
  String get howToPlayVoteTitle => 'A VOTAÇÃO';

  @override
  String get howToPlayVoteBodyBefore =>
      'Tente descobrir quem não sabe de nada e ';

  @override
  String get howToPlayVoteBodyHighlight => 'VOTE!';

  @override
  String get howToPlayVoteBodyAfter => ' Aponte o dedo sem medo.';

  @override
  String get howToPlayOutcomeTitle => 'O DESFECHO';

  @override
  String get howToPlayOutcomeBodyBefore =>
      'Se o Fora do Loop adivinhar a palavra no final, ';

  @override
  String get howToPlayOutcomeBodyHighlight => 'ele ganha';

  @override
  String get howToPlayOutcomeBodyAfter => ' e vira o mestre!';
}
