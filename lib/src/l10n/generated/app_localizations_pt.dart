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
  String get homeTagline => 'Todos sabem. Menos um.';

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
  String secretRevealViewerLine1(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealViewerLine2 => 'vai ver a palavra';

  @override
  String get secretRevealHandPhoneLine => 'Passe o telemóvel só a esta pessoa.';

  @override
  String get secretRevealPrivacy =>
      'Certifique-se de que ninguém mais está a olhar para o ecrã.';

  @override
  String secretRevealConfirmTitle(String playerName) {
    return 'É $playerName?';
  }

  @override
  String get secretRevealConfirmMessage =>
      'Confirme que só quem vai ver a palavra está com o telemóvel.';

  @override
  String get secretRevealConfirmYes => 'SIM, REVELAR';

  @override
  String get secretRevealConfirmNo => 'AINDA NÃO';

  @override
  String get secretRevealTopSecret => 'TOP SEGREDO';

  @override
  String get secretRevealNextPlayer => 'PRÓXIMO JOGADOR';

  @override
  String get secretRevealFinished => 'TERMINEI';

  @override
  String get secretRevealStartQuestions => 'INICIAR PERGUNTAS';

  @override
  String get questionsReadyTitleLine1 => 'TODOS';

  @override
  String get questionsReadyTitleLine2 => 'PRONTOS?';

  @override
  String get questionsReadyBody =>
      'Quando todos já viram a palavra deles, iniciem a ronda de perguntas.';

  @override
  String get questionsReadyThemeLabel => 'TEMA';

  @override
  String get questionsReadyStartQuestions => 'INICIAR PERGUNTAS';

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
  String get questionRoundAnsweringNow => 'RESPONDENDO AGORA';

  @override
  String get questionRoundSpeakUp => 'FALE ALTO!';

  @override
  String get questionRoundSpeakUpLine1 =>
      'Responda à pergunta em voz alta para';

  @override
  String get questionRoundSpeakUpLine2 => 'todos ouvirem.';

  @override
  String get questionRoundDoneAnswering => 'TERMINEI DE RESPONDER';

  @override
  String get questionRoundNextQuestion => 'PRÓXIMA PERGUNTA';

  @override
  String get questionRoundGoToVoting => 'IR PARA VOTAÇÃO';

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
  String votingPlayerTurn(String playerName) {
    return 'Vez de $playerName votar';
  }

  @override
  String get votingNow => 'VOTANDO AGORA';

  @override
  String get votingCandidatesSection => 'ESCOLHA UM SUSPEITO';

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
  String get roundResultsGuessReminderTitle => 'NAO DIGA A PALAVRA!';

  @override
  String get roundResultsGuessReminderLine1 =>
      'O jogador fora vai tentar adivinhar.';

  @override
  String get roundResultsGuessReminderLine2 =>
      'Fiquem em silencio — nao falem a palavra nem deem dicas.';

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
  String get newMatchDialogTitle => 'NOVA PARTIDA';

  @override
  String get newMatchDialogMessage =>
      'Quer manter a mesma categoria ou escolher outra?';

  @override
  String get newMatchKeepCategory => 'MANTER CATEGORIA';

  @override
  String get newMatchChangeCategory => 'TROCAR CATEGORIA';

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
  String get settingsLanguageArabic => 'Árabe';

  @override
  String get language => 'Idioma';

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
      'No modo guiado, responde às perguntas da app. No modo livre, dá uma pista de uma palavra. ';

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

  @override
  String get reviewPromptTitle => 'Curtiu a partida?';

  @override
  String get reviewPromptMessage =>
      'Se a galera se divertiu, uma avaliação na loja ajuda o jogo a chegar em mais mesas.';

  @override
  String get reviewPromptRate => 'AVALIAR';

  @override
  String get reviewPromptLater => 'AGORA NÃO';

  @override
  String get gameModeLabel => 'Como vocês vão jogar?';

  @override
  String get guidedMode => 'Guiado';

  @override
  String get guidedModeDescription => 'Respondam às perguntas do app.';

  @override
  String get freeMode => 'Modo livre';

  @override
  String get freeModeDescription =>
      'Deem pistas de uma palavra e tentem disfarçar.';

  @override
  String get freeClueTitle => 'Uma palavra. Capriche na pista.';

  @override
  String get freeClueBody =>
      'Dê uma pista em voz alta sem dizer a palavra secreta. O impostor precisa disfarçar.';

  @override
  String get clueDone => 'Já dei minha pista';

  @override
  String get anotherLap => 'Mais uma volta';

  @override
  String get voteNow => 'Votar agora';

  @override
  String get cluesReady => 'Todos já deram uma pista.';

  @override
  String get savedGroupHint =>
      'O último grupo está pronto. Adiciona ou remove jogadores se quiseres.';

  @override
  String get historySection => 'Rodadas diferentes';

  @override
  String get historyDescription =>
      'Palavras e perguntas recentes são evitadas neste aparelho. Ao esgotar o pacote, as mais antigas voltam.';

  @override
  String get resetHistory => 'Reiniciar histórico de palavras';

  @override
  String get historyReset => 'Histórico de palavras reiniciado.';

  @override
  String get forgetGroup => 'Esquecer grupo salvo';

  @override
  String get groupForgotten => 'Grupo salvo removido.';

  @override
  String get gameNightPacks => 'Pacotes para jogar juntos';

  @override
  String get packsSubtitle =>
      'Novos assuntos para o próximo encontro. Conteúdo em inglês.';

  @override
  String get packPurchaseOnce => 'Compra única. Sem assinatura.';

  @override
  String get packOwned => 'Pronto para jogar';

  @override
  String get packPlay => 'Jogar este pacote';

  @override
  String get packBuy => 'Desbloquear pacote';

  @override
  String get packUnavailable =>
      'As compras estão indisponíveis no momento. Suas categorias gratuitas continuam disponíveis.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get purchaseFailed =>
      'Não foi possível concluir a compra. Tente novamente.';

  @override
  String get purchasePending =>
      'Sua compra aguarda aprovação. Você pode continuar nas categorias gratuitas.';

  @override
  String get purchaseRestored =>
      'Compras verificadas. Seus pacotes disponíveis aparecem abaixo.';

  @override
  String get purchaseSuccess => 'Seu pacote está pronto. Vamos jogar!';

  @override
  String get packEnglishOnly => 'Conteúdo em inglês';

  @override
  String get packBundleTitle => 'Coleção Game Night';

  @override
  String get packBundleDescription =>
      'Os três pacotes listados aqui. Uma compra para manter todos.';

  @override
  String roundsOnlySummary(int roundCount) {
    return '$roundCount rodadas · pistas de uma palavra';
  }

  @override
  String packWordCount(int count) {
    return '$count palavras · guiado e livre';
  }

  @override
  String get readyToPlay => 'Para jogar';

  @override
  String get explorePacks => 'Explorar pacotes';

  @override
  String get packEnglishContent => 'Pacote com conteúdo em inglês';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Continuar';

  @override
  String get onboardingStart => 'Começar partida';

  @override
  String get onboardingReplay => 'Rever tutorial interativo';

  @override
  String onboardingStep(int step) {
    return 'PASSO $step DE 3';
  }

  @override
  String get onboardingSecretTitle => 'Todos sabem. Menos um.';

  @override
  String get onboardingSecretBody =>
      'Junte de 3 a 9 pessoas. Todos recebem a mesma palavra secreta, exceto uma pessoa: quem está Fora do Loop precisa blefar!';

  @override
  String get onboardingPassTitle => 'Veja seu segredo e passe o celular.';

  @override
  String get onboardingPassBody =>
      'Toque no card para praticar. Na partida, veja seu papel sem mostrar aos outros, esconda a palavra e passe o celular para a próxima pessoa.';

  @override
  String get onboardingVoteTitle => 'Dê pistas. Blefe. Vote.';

  @override
  String get onboardingVoteBody =>
      'No modo guiado, responda às perguntas. No livre, dê uma pista de uma palavra. Depois, votem em quem está Fora do Loop. Se essa pessoa adivinhar a palavra no final, ela ganha!';

  @override
  String get onboardingWord => 'Pizza';

  @override
  String get onboardingOut => 'Fora do Loop';

  @override
  String get onboardingReveal => 'Toque para revelar';

  @override
  String get onboardingHide => 'Toque para esconder';

  @override
  String get onboardingVoteLabel => 'Quem está blefando?';

  @override
  String get onboardingSaveError => 'Não foi possível salvar. Tente novamente.';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Out of the Loop';

  @override
  String get homeTagline => 'Todo mundo sabe. Menos um.';

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
  String secretRevealViewerLine1(String playerName) {
    return '$playerName';
  }

  @override
  String get secretRevealViewerLine2 => 'vai ver a palavra';

  @override
  String get secretRevealHandPhoneLine =>
      'Passe o celular só para esta pessoa.';

  @override
  String get secretRevealPrivacy =>
      'Certifique-se de que ninguém mais está olhando para a tela.';

  @override
  String secretRevealConfirmTitle(String playerName) {
    return 'É $playerName?';
  }

  @override
  String get secretRevealConfirmMessage =>
      'Confirme que só quem vai ver a palavra está com o celular.';

  @override
  String get secretRevealConfirmYes => 'SIM, REVELAR';

  @override
  String get secretRevealConfirmNo => 'AINDA NÃO';

  @override
  String get secretRevealTopSecret => 'TOP SECREDO';

  @override
  String get secretRevealNextPlayer => 'PRÓXIMO JOGADOR';

  @override
  String get secretRevealFinished => 'TERMINEI';

  @override
  String get secretRevealStartQuestions => 'INICIAR PERGUNTAS';

  @override
  String get questionsReadyTitleLine1 => 'TODOS';

  @override
  String get questionsReadyTitleLine2 => 'PRONTOS?';

  @override
  String get questionsReadyBody =>
      'Quando todos já viram a palavra deles, iniciem a rodada de perguntas.';

  @override
  String get questionsReadyThemeLabel => 'TEMA';

  @override
  String get questionsReadyStartQuestions => 'INICIAR PERGUNTAS';

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
  String get questionRoundAnsweringNow => 'RESPONDENDO AGORA';

  @override
  String get questionRoundSpeakUp => 'FALE ALTO!';

  @override
  String get questionRoundSpeakUpLine1 =>
      'Responda a pergunta em voz alta para';

  @override
  String get questionRoundSpeakUpLine2 => 'todos ouvirem.';

  @override
  String get questionRoundDoneAnswering => 'TERMINEI DE RESPONDER';

  @override
  String get questionRoundNextQuestion => 'PRÓXIMA PERGUNTA';

  @override
  String get questionRoundGoToVoting => 'IR PARA VOTAÇÃO';

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
  String votingPlayerTurn(String playerName) {
    return 'Vez de $playerName votar';
  }

  @override
  String get votingNow => 'VOTANDO AGORA';

  @override
  String get votingCandidatesSection => 'ESCOLHA UM SUSPEITO';

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
  String get roundResultsGuessReminderTitle => 'NAO DIGA A PALAVRA!';

  @override
  String get roundResultsGuessReminderLine1 =>
      'O jogador fora vai tentar adivinhar.';

  @override
  String get roundResultsGuessReminderLine2 =>
      'Fiquem em silencio — nao falem a palavra nem deem dicas.';

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
  String get newMatchDialogTitle => 'NOVA PARTIDA';

  @override
  String get newMatchDialogMessage =>
      'Quer manter a mesma categoria ou escolher outra?';

  @override
  String get newMatchKeepCategory => 'MANTER CATEGORIA';

  @override
  String get newMatchChangeCategory => 'TROCAR CATEGORIA';

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
  String get settingsLanguageArabic => 'Árabe';

  @override
  String get language => 'Idioma';

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
      'No modo guiado, responda às perguntas do app. No modo livre, dê uma pista de uma palavra. ';

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

  @override
  String get reviewPromptTitle => 'Curtiu a partida?';

  @override
  String get reviewPromptMessage =>
      'Se a galera se divertiu, uma avaliação na loja ajuda o jogo a chegar em mais mesas.';

  @override
  String get reviewPromptRate => 'AVALIAR';

  @override
  String get reviewPromptLater => 'AGORA NÃO';

  @override
  String get gameModeLabel => 'Como vocês vão jogar?';

  @override
  String get guidedMode => 'Guiado';

  @override
  String get guidedModeDescription => 'Respondam às perguntas do app.';

  @override
  String get freeMode => 'Modo livre';

  @override
  String get freeModeDescription =>
      'Deem pistas de uma palavra e tentem disfarçar.';

  @override
  String get freeClueTitle => 'Uma palavra. Capriche na pista.';

  @override
  String get freeClueBody =>
      'Dê uma pista em voz alta sem dizer a palavra secreta. O impostor precisa disfarçar.';

  @override
  String get clueDone => 'Já dei minha pista';

  @override
  String get anotherLap => 'Mais uma volta';

  @override
  String get voteNow => 'Votar agora';

  @override
  String get cluesReady => 'Todos já deram uma pista.';

  @override
  String get savedGroupHint =>
      'Seu último grupo está pronto. Adicione ou remova jogadores se quiser.';

  @override
  String get historySection => 'Rodadas diferentes';

  @override
  String get historyDescription =>
      'Palavras e perguntas recentes são evitadas neste aparelho. Ao esgotar o pacote, as mais antigas voltam.';

  @override
  String get resetHistory => 'Reiniciar histórico de palavras';

  @override
  String get historyReset => 'Histórico de palavras reiniciado.';

  @override
  String get forgetGroup => 'Esquecer grupo salvo';

  @override
  String get groupForgotten => 'Grupo salvo removido.';

  @override
  String get gameNightPacks => 'Pacotes para jogar juntos';

  @override
  String get packsSubtitle =>
      'Novos assuntos para o próximo encontro. Conteúdo em inglês.';

  @override
  String get packPurchaseOnce => 'Compra única. Sem assinatura.';

  @override
  String get packOwned => 'Pronto para jogar';

  @override
  String get packPlay => 'Jogar este pacote';

  @override
  String get packBuy => 'Desbloquear pacote';

  @override
  String get packUnavailable =>
      'As compras estão indisponíveis no momento. Suas categorias gratuitas continuam disponíveis.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get purchaseFailed =>
      'Não foi possível concluir a compra. Tente novamente.';

  @override
  String get purchasePending =>
      'Sua compra aguarda aprovação. Você pode continuar nas categorias gratuitas.';

  @override
  String get purchaseRestored =>
      'Compras verificadas. Seus pacotes disponíveis aparecem abaixo.';

  @override
  String get purchaseSuccess => 'Seu pacote está pronto. Vamos jogar!';

  @override
  String get packEnglishOnly => 'Conteúdo em inglês';

  @override
  String get packBundleTitle => 'Coleção Game Night';

  @override
  String get packBundleDescription =>
      'Os três pacotes listados aqui. Uma compra para manter todos.';

  @override
  String roundsOnlySummary(int roundCount) {
    return '$roundCount rodadas · pistas de uma palavra';
  }

  @override
  String packWordCount(int count) {
    return '$count palavras · guiado e livre';
  }

  @override
  String get readyToPlay => 'Para jogar';

  @override
  String get explorePacks => 'Explorar pacotes';

  @override
  String get packEnglishContent => 'Pacote com conteúdo em inglês';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Continuar';

  @override
  String get onboardingStart => 'Começar partida';

  @override
  String get onboardingReplay => 'Rever tutorial interativo';

  @override
  String onboardingStep(int step) {
    return 'PASSO $step DE 3';
  }

  @override
  String get onboardingSecretTitle => 'Todos sabem. Menos um.';

  @override
  String get onboardingSecretBody =>
      'Junte de 3 a 9 pessoas. Todos recebem a mesma palavra secreta, exceto uma pessoa: quem está Fora do Loop precisa blefar!';

  @override
  String get onboardingPassTitle => 'Veja seu segredo e passe o celular.';

  @override
  String get onboardingPassBody =>
      'Toque no card para praticar. Na partida, veja seu papel sem mostrar aos outros, esconda a palavra e passe o celular para a próxima pessoa.';

  @override
  String get onboardingVoteTitle => 'Dê pistas. Blefe. Vote.';

  @override
  String get onboardingVoteBody =>
      'No modo guiado, responda às perguntas. No livre, dê uma pista de uma palavra. Depois, votem em quem está Fora do Loop. Se essa pessoa adivinhar a palavra no final, ela ganha!';

  @override
  String get onboardingWord => 'Pizza';

  @override
  String get onboardingOut => 'Fora do Loop';

  @override
  String get onboardingReveal => 'Toque para revelar';

  @override
  String get onboardingHide => 'Toque para esconder';

  @override
  String get onboardingVoteLabel => 'Quem está blefando?';

  @override
  String get onboardingSaveError => 'Não foi possível salvar. Tente novamente.';
}
