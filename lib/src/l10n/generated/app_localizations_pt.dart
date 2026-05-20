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
  String get addPlayerButton => 'ADICIONAR';

  @override
  String get playerSetupTitleLine1 => 'QUEM VAI';

  @override
  String get playerSetupTitleLine2 => 'JOGAR?';

  @override
  String get playerSetupPlayerCountBadge => '3-9 JOGADORES';

  @override
  String get playerNameHint => 'Nome do Jogador';

  @override
  String get playerSetupStartGame => 'COMEÇAR JOGO';

  @override
  String playerSetupRemovePlayer(String playerName) {
    return 'Remover $playerName';
  }

  @override
  String get playerSetupErrorEmptyName => 'O nome não pode ficar vazio.';

  @override
  String get playerSetupErrorDuplicateName =>
      'Os nomes dos jogadores devem ser únicos.';

  @override
  String get playerSetupErrorTooManyPlayers =>
      'Uma partida aceita até 9 jogadores.';

  @override
  String get playerSetupErrorTooFewPlayers =>
      'Adicione pelo menos 3 jogadores.';

  @override
  String get playerSetupErrorInvalidRoundCount => 'Número de rodadas inválido.';

  @override
  String get playerSetupErrorInvalidQuestions =>
      'Escolha entre 1 e 3 perguntas por jogador.';

  @override
  String get playerSetupErrorInsufficientWords =>
      'Esta categoria não tem palavras suficientes para tantas rodadas.';

  @override
  String get playerSetupErrorInsufficientQuestions =>
      'Esta categoria não tem perguntas suficientes para tantos jogadores.';

  @override
  String get matchSetupTitleLine1 => 'CONFIGURAR';

  @override
  String get matchSetupTitleLine2 => 'PARTIDA';

  @override
  String get matchSetupRulesBadge => '1–5 RODADAS · 1–3 PERGUNTAS';

  @override
  String get matchSetupSubtitle =>
      'Defina as regras antes de cadastrar os jogadores.';

  @override
  String get matchSetupQuestionsSection => 'PERGUNTAS POR JOGADOR';

  @override
  String get matchSetupQuestionsDescription =>
      'Quantas perguntas cada jogador responde nesta rodada?';

  @override
  String matchSetupQuestionsRecommendation(int recommended) {
    return 'Com 3–4 jogadores recomendamos $recommended; com 5 ou mais, 1 (até 3 se a categoria permitir).';
  }

  @override
  String get matchSetupRoundsSection => 'RODADAS NA PARTIDA';

  @override
  String get matchSetupRoundsDescription =>
      'Quantas rodadas esta partida terá?';

  @override
  String matchSetupRoundsRecommended(int count) {
    return 'Recomendado: $count rodadas.';
  }

  @override
  String matchSetupRoundsValue(int count) {
    return 'Rodadas: $count';
  }

  @override
  String matchSetupQuestionCountChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perguntas',
      one: '1 pergunta',
    );
    return '$_temp0';
  }

  @override
  String matchSetupSummary(int roundCount, int questionCount) {
    String _temp0 = intl.Intl.pluralLogic(
      roundCount,
      locale: localeName,
      other: '$roundCount rodadas',
      one: '1 rodada',
    );
    String _temp1 = intl.Intl.pluralLogic(
      questionCount,
      locale: localeName,
      other: '$questionCount perguntas',
      one: '1 pergunta',
    );
    return '$_temp0 · $_temp1 por jogador';
  }

  @override
  String get matchSetupContinue => 'CONTINUAR';

  @override
  String get startMatch => 'Iniciar partida';

  @override
  String get revealMyWord => 'REVELAR MEU PAPEL';

  @override
  String secretRevealRound(int roundNumber) {
    return 'RODADA $roundNumber';
  }

  @override
  String get secretRevealPassTo => 'PASSE PARA';

  @override
  String secretRevealPassToPlayer(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealPrivacyLine1 => 'Certifique-se de que ninguém mais';

  @override
  String get secretRevealPrivacyLine2 => 'está olhando para sua tela.';

  @override
  String get secretRevealTopSecret => 'TOP SEGREDO';

  @override
  String get secretRevealNextPlayer => 'PRÓXIMO JOGADOR';

  @override
  String get secretRevealStartQuestions => 'INICIAR PERGUNTAS';

  @override
  String get outOfLoopMessage =>
      'Você está FORA do círculo — aja naturalmente.';

  @override
  String get doneAnswering => 'Terminei de responder';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return 'Vez de $playerName';
  }

  @override
  String get questionRoundSpeakUp => 'FALE ALTO!';

  @override
  String get questionRoundSpeakUpLine1 =>
      'Responda à pergunta em voz alta para';

  @override
  String get questionRoundSpeakUpLine2 => 'todos ouvirem.';

  @override
  String get questionRoundTimeRemaining => 'TEMPO RESTANTE';

  @override
  String questionRoundTimeSeconds(int seconds) {
    return '${seconds}S';
  }

  @override
  String get questionRoundDoneAnswering => 'TERMINEI DE RESPONDER';

  @override
  String get questionRoundNextQuestion => 'PRÓXIMA PERGUNTA';

  @override
  String get questionRoundGoToVoting => 'IR PARA VOTAÇÃO';

  @override
  String get questionRoundTimerExpiredLine1 => 'O tempo acabou.';

  @override
  String get questionRoundTimerExpiredLine2 =>
      'Termine esta resposta quando estiver pronto.';

  @override
  String get questionRoundExitTitle => 'Cancelar partida?';

  @override
  String get questionRoundExitMessage =>
      'Se voltar agora, a partida sera cancelada e voltara a selecao de categorias.';

  @override
  String get questionRoundExitConfirm => 'CANCELAR PARTIDA';

  @override
  String get questionRoundExitStay => 'CONTINUAR JOGANDO';

  @override
  String get whoIsOutOfTheLoop => 'Quem esta fora do loop?';

  @override
  String get votingHeadlineWhoIs => 'QUEM ESTA';

  @override
  String get votingHeadlineOutOf => 'FORA DO';

  @override
  String get votingHeadlineTheLoop => 'LOOP?';

  @override
  String get votingSubtitleLine1 => 'Ache o impostor! Vote no jogador';

  @override
  String get votingSubtitleLine2 => 'que voce acha que nao sabe a palavra';

  @override
  String get votingSubtitleLine3 => 'secreta.';

  @override
  String get votingVote => 'VOTAR';

  @override
  String get votingYou => 'VOCE';

  @override
  String get votingCannotVoteSelf => 'NAO PODE VOTAR EM SI';

  @override
  String get votingTimeToVote => 'HORA DE VOTAR';

  @override
  String votingTimeSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get votingTimerExpiredLine1 => 'O tempo acabou.';

  @override
  String get votingTimerExpiredLine2 =>
      'Registre seu voto quando estiver pronto.';

  @override
  String get confirmVotes => 'CONFIRMAR VOTOS';

  @override
  String get roundResults => 'RESULTADO DA RODADA';

  @override
  String get roundResultsHeadlineAccent => 'RESULTADO';

  @override
  String get roundResultsHeadlineMain => 'DA RODADA';

  @override
  String get roundResultsOutPlayerLabel => 'O JOGADOR FORA ERA';

  @override
  String get roundResultsMajorityFound =>
      'O grupo encontrou o jogador fora por maioria.';

  @override
  String get roundResultsMajorityEscaped =>
      'O jogador fora escapou da votacao por maioria.';

  @override
  String get roundResultsVoteTotals => 'TOTAL DE VOTOS';

  @override
  String get roundResultsRoundPoints => 'PONTOS DA RODADA';

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
    return 'IR PARA RODADA $roundNumber';
  }

  @override
  String get roundResultsViewFinalScore => 'VER PLACAR FINAL';

  @override
  String get guessWord => 'ADIVINHE A PALAVRA';

  @override
  String get guessHeadlineAccent => 'ADIVINHE';

  @override
  String get guessHeadlineMain => 'A PALAVRA';

  @override
  String guessPlayerTurn(String name) {
    return 'Vez de $name';
  }

  @override
  String get guessInstructionLine1 => 'Diga a palavra secreta em voz alta.';

  @override
  String get guessInstructionLine2 => 'O grupo decide se voce';

  @override
  String get guessInstructionLine3 => 'acertou.';

  @override
  String get guessCorrectButton => 'ACERTOU';

  @override
  String get guessWrongButton => 'ERROU';

  @override
  String get correct => 'Acertou';

  @override
  String get wrong => 'Errou';

  @override
  String get playAgain => 'NOVA PARTIDA';

  @override
  String get backToHome => 'VOLTAR AO INÍCIO';

  @override
  String resultsWinnerWins(String name) {
    return '$name venceu!';
  }

  @override
  String get resultsTheMastermind => 'O MESTRE';

  @override
  String get resultsSecretWordWas => 'A PALAVRA SECRETA ERA:';

  @override
  String resultsOutPlayerWas(String name) {
    return '$name estava Fora do Loop!';
  }

  @override
  String get resultsLeaderboard => 'PLACAR';

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
  String get addPlayerButton => 'ADICIONAR';

  @override
  String get playerSetupTitleLine1 => 'QUEM VAI';

  @override
  String get playerSetupTitleLine2 => 'JOGAR?';

  @override
  String get playerSetupPlayerCountBadge => '3-9 JOGADORES';

  @override
  String get playerNameHint => 'Nome do Jogador';

  @override
  String get playerSetupStartGame => 'COMEÇAR JOGO';

  @override
  String playerSetupRemovePlayer(String playerName) {
    return 'Remover $playerName';
  }

  @override
  String get playerSetupErrorEmptyName => 'O nome não pode ficar vazio.';

  @override
  String get playerSetupErrorDuplicateName =>
      'Os nomes dos jogadores devem ser únicos.';

  @override
  String get playerSetupErrorTooManyPlayers =>
      'Uma partida aceita até 9 jogadores.';

  @override
  String get playerSetupErrorTooFewPlayers =>
      'Adicione pelo menos 3 jogadores.';

  @override
  String get playerSetupErrorInvalidRoundCount => 'Número de rodadas inválido.';

  @override
  String get playerSetupErrorInvalidQuestions =>
      'Escolha entre 1 e 3 perguntas por jogador.';

  @override
  String get playerSetupErrorInsufficientWords =>
      'Esta categoria não tem palavras suficientes para tantas rodadas.';

  @override
  String get playerSetupErrorInsufficientQuestions =>
      'Esta categoria não tem perguntas suficientes para tantos jogadores.';

  @override
  String get matchSetupTitleLine1 => 'CONFIGURAR';

  @override
  String get matchSetupTitleLine2 => 'PARTIDA';

  @override
  String get matchSetupRulesBadge => '1–5 RODADAS · 1–3 PERGUNTAS';

  @override
  String get matchSetupSubtitle =>
      'Defina as regras antes de cadastrar os jogadores.';

  @override
  String get matchSetupQuestionsSection => 'PERGUNTAS POR JOGADOR';

  @override
  String get matchSetupQuestionsDescription =>
      'Quantas perguntas cada jogador responde nesta rodada?';

  @override
  String matchSetupQuestionsRecommendation(int recommended) {
    return 'Com 3–4 jogadores recomendamos $recommended; com 5 ou mais, 1 (até 3 se a categoria permitir).';
  }

  @override
  String get matchSetupRoundsSection => 'RODADAS NA PARTIDA';

  @override
  String get matchSetupRoundsDescription =>
      'Quantas rodadas esta partida terá?';

  @override
  String matchSetupRoundsRecommended(int count) {
    return 'Recomendado: $count rodadas.';
  }

  @override
  String matchSetupRoundsValue(int count) {
    return 'Rodadas: $count';
  }

  @override
  String matchSetupQuestionCountChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perguntas',
      one: '1 pergunta',
    );
    return '$_temp0';
  }

  @override
  String matchSetupSummary(int roundCount, int questionCount) {
    String _temp0 = intl.Intl.pluralLogic(
      roundCount,
      locale: localeName,
      other: '$roundCount rodadas',
      one: '1 rodada',
    );
    String _temp1 = intl.Intl.pluralLogic(
      questionCount,
      locale: localeName,
      other: '$questionCount perguntas',
      one: '1 pergunta',
    );
    return '$_temp0 · $_temp1 por jogador';
  }

  @override
  String get matchSetupContinue => 'CONTINUAR';

  @override
  String get startMatch => 'Iniciar partida';

  @override
  String get revealMyWord => 'REVELAR MEU PAPEL';

  @override
  String secretRevealRound(int roundNumber) {
    return 'RODADA $roundNumber';
  }

  @override
  String get secretRevealPassTo => 'PASSE PARA';

  @override
  String secretRevealPassToPlayer(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealPrivacyLine1 => 'Certifique-se de que ninguém mais';

  @override
  String get secretRevealPrivacyLine2 => 'está olhando para sua tela.';

  @override
  String get secretRevealTopSecret => 'TOP SECREDO';

  @override
  String get secretRevealNextPlayer => 'PRÓXIMO JOGADOR';

  @override
  String get secretRevealStartQuestions => 'INICIAR PERGUNTAS';

  @override
  String get outOfLoopMessage =>
      'Você está FORA do círculo — aja naturalmente.';

  @override
  String get doneAnswering => 'Terminei de responder';

  @override
  String questionRoundPlayerTurn(String playerName) {
    return 'Vez de $playerName';
  }

  @override
  String get questionRoundSpeakUp => 'FALE ALTO!';

  @override
  String get questionRoundSpeakUpLine1 =>
      'Responda a pergunta em voz alta para';

  @override
  String get questionRoundSpeakUpLine2 => 'todos ouvirem.';

  @override
  String get questionRoundTimeRemaining => 'TEMPO RESTANTE';

  @override
  String questionRoundTimeSeconds(int seconds) {
    return '${seconds}S';
  }

  @override
  String get questionRoundDoneAnswering => 'TERMINEI DE RESPONDER';

  @override
  String get questionRoundNextQuestion => 'PRÓXIMA PERGUNTA';

  @override
  String get questionRoundGoToVoting => 'IR PARA VOTAÇÃO';

  @override
  String get questionRoundTimerExpiredLine1 => 'O tempo acabou.';

  @override
  String get questionRoundTimerExpiredLine2 =>
      'Finalize esta resposta quando estiver pronto.';

  @override
  String get questionRoundExitTitle => 'Cancelar partida?';

  @override
  String get questionRoundExitMessage =>
      'Se você voltar agora, a partida será cancelada e você retornará à seleção de categorias.';

  @override
  String get questionRoundExitConfirm => 'CANCELAR PARTIDA';

  @override
  String get questionRoundExitStay => 'CONTINUAR JOGANDO';

  @override
  String get whoIsOutOfTheLoop => 'Quem esta fora do loop?';

  @override
  String get votingHeadlineWhoIs => 'QUEM ESTA';

  @override
  String get votingHeadlineOutOf => 'FORA DO';

  @override
  String get votingHeadlineTheLoop => 'LOOP?';

  @override
  String get votingSubtitleLine1 => 'Ache o impostor! Vote no jogador';

  @override
  String get votingSubtitleLine2 => 'que voce acha que nao sabe a palavra';

  @override
  String get votingSubtitleLine3 => 'secreta.';

  @override
  String get votingVote => 'VOTAR';

  @override
  String get votingYou => 'VOCE';

  @override
  String get votingCannotVoteSelf => 'NAO PODE VOTAR EM SI';

  @override
  String get votingTimeToVote => 'HORA DE VOTAR';

  @override
  String votingTimeSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get votingTimerExpiredLine1 => 'O tempo acabou.';

  @override
  String get votingTimerExpiredLine2 =>
      'Registre seu voto quando estiver pronto.';

  @override
  String get confirmVotes => 'CONFIRMAR VOTOS';

  @override
  String get roundResults => 'RESULTADO DA RODADA';

  @override
  String get roundResultsHeadlineAccent => 'RESULTADO';

  @override
  String get roundResultsHeadlineMain => 'DA RODADA';

  @override
  String get roundResultsOutPlayerLabel => 'O JOGADOR FORA ERA';

  @override
  String get roundResultsMajorityFound =>
      'O grupo encontrou o jogador fora por maioria.';

  @override
  String get roundResultsMajorityEscaped =>
      'O jogador fora escapou da votacao por maioria.';

  @override
  String get roundResultsVoteTotals => 'TOTAL DE VOTOS';

  @override
  String get roundResultsRoundPoints => 'PONTOS DA RODADA';

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
    return 'IR PARA RODADA $roundNumber';
  }

  @override
  String get roundResultsViewFinalScore => 'VER PLACAR FINAL';

  @override
  String get guessWord => 'ADIVINHE A PALAVRA';

  @override
  String get guessHeadlineAccent => 'ADIVINHE';

  @override
  String get guessHeadlineMain => 'A PALAVRA';

  @override
  String guessPlayerTurn(String name) {
    return 'Vez de $name';
  }

  @override
  String get guessInstructionLine1 => 'Diga a palavra secreta em voz alta.';

  @override
  String get guessInstructionLine2 => 'O grupo decide se voce';

  @override
  String get guessInstructionLine3 => 'acertou.';

  @override
  String get guessCorrectButton => 'ACERTOU';

  @override
  String get guessWrongButton => 'ERROU';

  @override
  String get correct => 'Acertou';

  @override
  String get wrong => 'Errou';

  @override
  String get playAgain => 'NOVA PARTIDA';

  @override
  String get backToHome => 'VOLTAR AO INÍCIO';

  @override
  String resultsWinnerWins(String name) {
    return '$name venceu!';
  }

  @override
  String get resultsTheMastermind => 'O MESTRE';

  @override
  String get resultsSecretWordWas => 'A PALAVRA SECRETA ERA:';

  @override
  String resultsOutPlayerWas(String name) {
    return '$name estava Fora do Loop!';
  }

  @override
  String get resultsLeaderboard => 'PLACAR';

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
