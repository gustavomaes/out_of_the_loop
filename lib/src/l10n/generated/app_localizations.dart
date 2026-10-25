import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// Application title used by the app shell.
  ///
  /// In pt_BR, this message translates to:
  /// **'Out of the Loop'**
  String get appTitle;

  /// No description provided for @homeTagline.
  ///
  /// In pt_BR, this message translates to:
  /// **'Todo mundo sabe. Menos um.'**
  String get homeTagline;

  /// No description provided for @startGame.
  ///
  /// In pt_BR, this message translates to:
  /// **'JOGAR'**
  String get startGame;

  /// No description provided for @navPlay.
  ///
  /// In pt_BR, this message translates to:
  /// **'INÍCIO'**
  String get navPlay;

  /// No description provided for @navCategories.
  ///
  /// In pt_BR, this message translates to:
  /// **'CATEGORIAS'**
  String get navCategories;

  /// No description provided for @navProfile.
  ///
  /// In pt_BR, this message translates to:
  /// **'PERFIL'**
  String get navProfile;

  /// No description provided for @howToPlay.
  ///
  /// In pt_BR, this message translates to:
  /// **'COMO JOGAR'**
  String get howToPlay;

  /// No description provided for @pickCategory.
  ///
  /// In pt_BR, this message translates to:
  /// **'Escolha uma categoria'**
  String get pickCategory;

  /// No description provided for @pickCategorySubtitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Escolha seu campo de batalha. O loop aguarda.'**
  String get pickCategorySubtitle;

  /// No description provided for @categoryFoodAndDrink.
  ///
  /// In pt_BR, this message translates to:
  /// **'Comida e Bebida'**
  String get categoryFoodAndDrink;

  /// No description provided for @categoryTravel.
  ///
  /// In pt_BR, this message translates to:
  /// **'Viagem'**
  String get categoryTravel;

  /// No description provided for @categoryMovies.
  ///
  /// In pt_BR, this message translates to:
  /// **'Filmes'**
  String get categoryMovies;

  /// No description provided for @categoryAnimals.
  ///
  /// In pt_BR, this message translates to:
  /// **'Animais'**
  String get categoryAnimals;

  /// No description provided for @categorySports.
  ///
  /// In pt_BR, this message translates to:
  /// **'Esportes'**
  String get categorySports;

  /// No description provided for @categoryTech.
  ///
  /// In pt_BR, this message translates to:
  /// **'Tecnologia'**
  String get categoryTech;

  /// No description provided for @categoriesLoadError.
  ///
  /// In pt_BR, this message translates to:
  /// **'Não foi possível carregar as categorias.'**
  String get categoriesLoadError;

  /// No description provided for @addPlayer.
  ///
  /// In pt_BR, this message translates to:
  /// **'Adicionar jogador'**
  String get addPlayer;

  /// No description provided for @addPlayerButton.
  ///
  /// In pt_BR, this message translates to:
  /// **'ADICIONAR'**
  String get addPlayerButton;

  /// No description provided for @playerSetupTitleLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'QUEM VAI'**
  String get playerSetupTitleLine1;

  /// No description provided for @playerSetupTitleLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'JOGAR?'**
  String get playerSetupTitleLine2;

  /// No description provided for @playerSetupPlayerCountBadge.
  ///
  /// In pt_BR, this message translates to:
  /// **'3-9 JOGADORES'**
  String get playerSetupPlayerCountBadge;

  /// No description provided for @playerNameHint.
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome do Jogador'**
  String get playerNameHint;

  /// No description provided for @playerSetupStartGame.
  ///
  /// In pt_BR, this message translates to:
  /// **'COMEÇAR JOGO'**
  String get playerSetupStartGame;

  /// No description provided for @playerSetupRemovePlayer.
  ///
  /// In pt_BR, this message translates to:
  /// **'Remover {playerName}'**
  String playerSetupRemovePlayer(String playerName);

  /// No description provided for @playerSetupErrorEmptyName.
  ///
  /// In pt_BR, this message translates to:
  /// **'O nome não pode ficar vazio.'**
  String get playerSetupErrorEmptyName;

  /// No description provided for @playerSetupErrorDuplicateName.
  ///
  /// In pt_BR, this message translates to:
  /// **'Os nomes dos jogadores devem ser únicos.'**
  String get playerSetupErrorDuplicateName;

  /// No description provided for @playerSetupErrorTooManyPlayers.
  ///
  /// In pt_BR, this message translates to:
  /// **'Uma partida aceita até 9 jogadores.'**
  String get playerSetupErrorTooManyPlayers;

  /// No description provided for @playerSetupErrorTooFewPlayers.
  ///
  /// In pt_BR, this message translates to:
  /// **'Adicione pelo menos 3 jogadores.'**
  String get playerSetupErrorTooFewPlayers;

  /// No description provided for @playerSetupErrorInvalidRoundCount.
  ///
  /// In pt_BR, this message translates to:
  /// **'Número de rodadas inválido.'**
  String get playerSetupErrorInvalidRoundCount;

  /// No description provided for @playerSetupErrorInvalidQuestions.
  ///
  /// In pt_BR, this message translates to:
  /// **'Escolha entre 1 e 3 perguntas por jogador.'**
  String get playerSetupErrorInvalidQuestions;

  /// No description provided for @playerSetupErrorInsufficientWords.
  ///
  /// In pt_BR, this message translates to:
  /// **'Esta categoria não tem palavras suficientes para tantas rodadas.'**
  String get playerSetupErrorInsufficientWords;

  /// No description provided for @playerSetupErrorInsufficientQuestions.
  ///
  /// In pt_BR, this message translates to:
  /// **'Esta categoria não tem perguntas suficientes para tantos jogadores.'**
  String get playerSetupErrorInsufficientQuestions;

  /// No description provided for @matchSetupTitleLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'CONFIGURAR'**
  String get matchSetupTitleLine1;

  /// No description provided for @matchSetupTitleLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'PARTIDA'**
  String get matchSetupTitleLine2;

  /// No description provided for @matchSetupRulesBadge.
  ///
  /// In pt_BR, this message translates to:
  /// **'1–5 RODADAS · 1–3 PERGUNTAS'**
  String get matchSetupRulesBadge;

  /// No description provided for @matchSetupSubtitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Defina as regras antes de cadastrar os jogadores.'**
  String get matchSetupSubtitle;

  /// No description provided for @matchSetupQuestionsSection.
  ///
  /// In pt_BR, this message translates to:
  /// **'PERGUNTAS POR JOGADOR'**
  String get matchSetupQuestionsSection;

  /// No description provided for @matchSetupQuestionsDescription.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quantas perguntas cada jogador responde nesta rodada?'**
  String get matchSetupQuestionsDescription;

  /// No description provided for @matchSetupQuestionsRecommendation.
  ///
  /// In pt_BR, this message translates to:
  /// **'Com 3–4 jogadores recomendamos {recommended}; com 5 ou mais, 1 (até 3 se a categoria permitir).'**
  String matchSetupQuestionsRecommendation(int recommended);

  /// No description provided for @matchSetupRoundsSection.
  ///
  /// In pt_BR, this message translates to:
  /// **'RODADAS NA PARTIDA'**
  String get matchSetupRoundsSection;

  /// No description provided for @matchSetupRoundsDescription.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quantas rodadas esta partida terá?'**
  String get matchSetupRoundsDescription;

  /// No description provided for @matchSetupRoundsRecommended.
  ///
  /// In pt_BR, this message translates to:
  /// **'Recomendado: {count} rodadas.'**
  String matchSetupRoundsRecommended(int count);

  /// No description provided for @matchSetupRoundsValue.
  ///
  /// In pt_BR, this message translates to:
  /// **'Rodadas: {count}'**
  String matchSetupRoundsValue(int count);

  /// No description provided for @matchSetupQuestionCountChip.
  ///
  /// In pt_BR, this message translates to:
  /// **'{count, plural, =1{1 pergunta} other{{count} perguntas}}'**
  String matchSetupQuestionCountChip(int count);

  /// No description provided for @matchSetupSummary.
  ///
  /// In pt_BR, this message translates to:
  /// **'{roundCount, plural, =1{1 rodada} other{{roundCount} rodadas}} · {questionCount, plural, =1{1 pergunta} other{{questionCount} perguntas}} por jogador'**
  String matchSetupSummary(int roundCount, int questionCount);

  /// No description provided for @matchSetupContinue.
  ///
  /// In pt_BR, this message translates to:
  /// **'CONTINUAR'**
  String get matchSetupContinue;

  /// No description provided for @startMatch.
  ///
  /// In pt_BR, this message translates to:
  /// **'Iniciar partida'**
  String get startMatch;

  /// No description provided for @revealMyWord.
  ///
  /// In pt_BR, this message translates to:
  /// **'REVELAR MEU PAPEL'**
  String get revealMyWord;

  /// No description provided for @secretRevealRound.
  ///
  /// In pt_BR, this message translates to:
  /// **'RODADA {roundNumber}'**
  String secretRevealRound(int roundNumber);

  /// No description provided for @secretRevealPassTo.
  ///
  /// In pt_BR, this message translates to:
  /// **'PASSE PARA'**
  String get secretRevealPassTo;

  /// No description provided for @secretRevealPassToPlayer.
  ///
  /// In pt_BR, this message translates to:
  /// **'{playerName}'**
  String secretRevealPassToPlayer(String playerName);

  /// No description provided for @secretRevealViewerLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'{playerName}'**
  String secretRevealViewerLine1(String playerName);

  /// No description provided for @secretRevealViewerLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'vai ver a palavra'**
  String get secretRevealViewerLine2;

  /// No description provided for @secretRevealHandPhoneLine.
  ///
  /// In pt_BR, this message translates to:
  /// **'Passe o celular só para esta pessoa.'**
  String get secretRevealHandPhoneLine;

  /// No description provided for @secretRevealPrivacy.
  ///
  /// In pt_BR, this message translates to:
  /// **'Certifique-se de que ninguém mais está olhando para a tela.'**
  String get secretRevealPrivacy;

  /// No description provided for @secretRevealConfirmTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'É {playerName}?'**
  String secretRevealConfirmTitle(String playerName);

  /// No description provided for @secretRevealConfirmMessage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Confirme que só quem vai ver a palavra está com o celular.'**
  String get secretRevealConfirmMessage;

  /// No description provided for @secretRevealConfirmYes.
  ///
  /// In pt_BR, this message translates to:
  /// **'SIM, REVELAR'**
  String get secretRevealConfirmYes;

  /// No description provided for @secretRevealConfirmNo.
  ///
  /// In pt_BR, this message translates to:
  /// **'AINDA NÃO'**
  String get secretRevealConfirmNo;

  /// No description provided for @secretRevealTopSecret.
  ///
  /// In pt_BR, this message translates to:
  /// **'TOP SECREDO'**
  String get secretRevealTopSecret;

  /// No description provided for @secretRevealNextPlayer.
  ///
  /// In pt_BR, this message translates to:
  /// **'PRÓXIMO JOGADOR'**
  String get secretRevealNextPlayer;

  /// No description provided for @secretRevealFinished.
  ///
  /// In pt_BR, this message translates to:
  /// **'TERMINEI'**
  String get secretRevealFinished;

  /// No description provided for @secretRevealStartQuestions.
  ///
  /// In pt_BR, this message translates to:
  /// **'INICIAR PERGUNTAS'**
  String get secretRevealStartQuestions;

  /// No description provided for @questionsReadyTitleLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'TODOS'**
  String get questionsReadyTitleLine1;

  /// No description provided for @questionsReadyTitleLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'PRONTOS?'**
  String get questionsReadyTitleLine2;

  /// No description provided for @questionsReadyBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quando todos já viram a palavra deles, iniciem a rodada de perguntas.'**
  String get questionsReadyBody;

  /// No description provided for @questionsReadyThemeLabel.
  ///
  /// In pt_BR, this message translates to:
  /// **'TEMA'**
  String get questionsReadyThemeLabel;

  /// No description provided for @questionsReadyStartQuestions.
  ///
  /// In pt_BR, this message translates to:
  /// **'INICIAR PERGUNTAS'**
  String get questionsReadyStartQuestions;

  /// No description provided for @outOfLoopMessage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Você está FORA do círculo — aja naturalmente.'**
  String get outOfLoopMessage;

  /// No description provided for @doneAnswering.
  ///
  /// In pt_BR, this message translates to:
  /// **'Terminei de responder'**
  String get doneAnswering;

  /// No description provided for @questionRoundPlayerTurn.
  ///
  /// In pt_BR, this message translates to:
  /// **'Vez de {playerName}'**
  String questionRoundPlayerTurn(String playerName);

  /// No description provided for @questionRoundAnsweringNow.
  ///
  /// In pt_BR, this message translates to:
  /// **'RESPONDENDO AGORA'**
  String get questionRoundAnsweringNow;

  /// No description provided for @questionRoundSpeakUp.
  ///
  /// In pt_BR, this message translates to:
  /// **'FALE ALTO!'**
  String get questionRoundSpeakUp;

  /// No description provided for @questionRoundSpeakUpLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'Responda a pergunta em voz alta para'**
  String get questionRoundSpeakUpLine1;

  /// No description provided for @questionRoundSpeakUpLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'todos ouvirem.'**
  String get questionRoundSpeakUpLine2;

  /// No description provided for @questionRoundDoneAnswering.
  ///
  /// In pt_BR, this message translates to:
  /// **'TERMINEI DE RESPONDER'**
  String get questionRoundDoneAnswering;

  /// No description provided for @questionRoundNextQuestion.
  ///
  /// In pt_BR, this message translates to:
  /// **'PRÓXIMA PERGUNTA'**
  String get questionRoundNextQuestion;

  /// No description provided for @questionRoundGoToVoting.
  ///
  /// In pt_BR, this message translates to:
  /// **'IR PARA VOTAÇÃO'**
  String get questionRoundGoToVoting;

  /// No description provided for @questionRoundExitTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Cancelar partida?'**
  String get questionRoundExitTitle;

  /// No description provided for @questionRoundExitMessage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Se você voltar agora, a partida será cancelada e você retornará à seleção de categorias.'**
  String get questionRoundExitMessage;

  /// No description provided for @questionRoundExitConfirm.
  ///
  /// In pt_BR, this message translates to:
  /// **'CANCELAR PARTIDA'**
  String get questionRoundExitConfirm;

  /// No description provided for @questionRoundExitStay.
  ///
  /// In pt_BR, this message translates to:
  /// **'CONTINUAR JOGANDO'**
  String get questionRoundExitStay;

  /// No description provided for @whoIsOutOfTheLoop.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quem esta fora do loop?'**
  String get whoIsOutOfTheLoop;

  /// No description provided for @votingHeadlineWhoIs.
  ///
  /// In pt_BR, this message translates to:
  /// **'QUEM ESTA'**
  String get votingHeadlineWhoIs;

  /// No description provided for @votingHeadlineOutOf.
  ///
  /// In pt_BR, this message translates to:
  /// **'FORA DO'**
  String get votingHeadlineOutOf;

  /// No description provided for @votingHeadlineTheLoop.
  ///
  /// In pt_BR, this message translates to:
  /// **'LOOP?'**
  String get votingHeadlineTheLoop;

  /// No description provided for @votingSubtitleLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'Ache o impostor! Vote no jogador'**
  String get votingSubtitleLine1;

  /// No description provided for @votingSubtitleLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'que voce acha que nao sabe a palavra'**
  String get votingSubtitleLine2;

  /// No description provided for @votingSubtitleLine3.
  ///
  /// In pt_BR, this message translates to:
  /// **'secreta.'**
  String get votingSubtitleLine3;

  /// No description provided for @votingVote.
  ///
  /// In pt_BR, this message translates to:
  /// **'VOTAR'**
  String get votingVote;

  /// No description provided for @votingYou.
  ///
  /// In pt_BR, this message translates to:
  /// **'VOCE'**
  String get votingYou;

  /// No description provided for @votingCannotVoteSelf.
  ///
  /// In pt_BR, this message translates to:
  /// **'NAO PODE VOTAR EM SI'**
  String get votingCannotVoteSelf;

  /// No description provided for @votingPlayerTurn.
  ///
  /// In pt_BR, this message translates to:
  /// **'Vez de {playerName} votar'**
  String votingPlayerTurn(String playerName);

  /// No description provided for @votingNow.
  ///
  /// In pt_BR, this message translates to:
  /// **'VOTANDO AGORA'**
  String get votingNow;

  /// No description provided for @votingCandidatesSection.
  ///
  /// In pt_BR, this message translates to:
  /// **'ESCOLHA UM SUSPEITO'**
  String get votingCandidatesSection;

  /// No description provided for @confirmVotes.
  ///
  /// In pt_BR, this message translates to:
  /// **'CONFIRMAR VOTOS'**
  String get confirmVotes;

  /// No description provided for @roundResults.
  ///
  /// In pt_BR, this message translates to:
  /// **'RESULTADO DA RODADA'**
  String get roundResults;

  /// No description provided for @roundResultsHeadlineAccent.
  ///
  /// In pt_BR, this message translates to:
  /// **'RESULTADO'**
  String get roundResultsHeadlineAccent;

  /// No description provided for @roundResultsHeadlineMain.
  ///
  /// In pt_BR, this message translates to:
  /// **'DA RODADA'**
  String get roundResultsHeadlineMain;

  /// No description provided for @roundResultsOutPlayerLabel.
  ///
  /// In pt_BR, this message translates to:
  /// **'O JOGADOR FORA ERA'**
  String get roundResultsOutPlayerLabel;

  /// No description provided for @roundResultsMajorityFound.
  ///
  /// In pt_BR, this message translates to:
  /// **'O grupo encontrou o jogador fora por maioria.'**
  String get roundResultsMajorityFound;

  /// No description provided for @roundResultsMajorityEscaped.
  ///
  /// In pt_BR, this message translates to:
  /// **'O jogador fora escapou da votacao por maioria.'**
  String get roundResultsMajorityEscaped;

  /// No description provided for @roundResultsGuessReminderTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'NAO DIGA A PALAVRA!'**
  String get roundResultsGuessReminderTitle;

  /// No description provided for @roundResultsGuessReminderLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'O jogador fora vai tentar adivinhar.'**
  String get roundResultsGuessReminderLine1;

  /// No description provided for @roundResultsGuessReminderLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'Fiquem em silencio — nao falem a palavra nem deem dicas.'**
  String get roundResultsGuessReminderLine2;

  /// No description provided for @roundResultsVoteTotals.
  ///
  /// In pt_BR, this message translates to:
  /// **'TOTAL DE VOTOS'**
  String get roundResultsVoteTotals;

  /// No description provided for @roundResultsRoundPoints.
  ///
  /// In pt_BR, this message translates to:
  /// **'PONTOS DA RODADA'**
  String get roundResultsRoundPoints;

  /// No description provided for @roundResultsVoteCount.
  ///
  /// In pt_BR, this message translates to:
  /// **'{count} votos'**
  String roundResultsVoteCount(int count);

  /// No description provided for @roundResultsPointsGain.
  ///
  /// In pt_BR, this message translates to:
  /// **'+{points}'**
  String roundResultsPointsGain(int points);

  /// No description provided for @roundResultsContinue.
  ///
  /// In pt_BR, this message translates to:
  /// **'CONTINUAR'**
  String get roundResultsContinue;

  /// No description provided for @roundResultsGoToRound.
  ///
  /// In pt_BR, this message translates to:
  /// **'IR PARA RODADA {roundNumber}'**
  String roundResultsGoToRound(int roundNumber);

  /// No description provided for @roundResultsViewFinalScore.
  ///
  /// In pt_BR, this message translates to:
  /// **'VER PLACAR FINAL'**
  String get roundResultsViewFinalScore;

  /// No description provided for @guessWord.
  ///
  /// In pt_BR, this message translates to:
  /// **'ADIVINHE A PALAVRA'**
  String get guessWord;

  /// No description provided for @guessHeadlineAccent.
  ///
  /// In pt_BR, this message translates to:
  /// **'ADIVINHE'**
  String get guessHeadlineAccent;

  /// No description provided for @guessHeadlineMain.
  ///
  /// In pt_BR, this message translates to:
  /// **'A PALAVRA'**
  String get guessHeadlineMain;

  /// No description provided for @guessPlayerTurn.
  ///
  /// In pt_BR, this message translates to:
  /// **'Vez de {name}'**
  String guessPlayerTurn(String name);

  /// No description provided for @guessInstructionLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'Diga a palavra secreta em voz alta.'**
  String get guessInstructionLine1;

  /// No description provided for @guessInstructionLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'O grupo decide se voce'**
  String get guessInstructionLine2;

  /// No description provided for @guessInstructionLine3.
  ///
  /// In pt_BR, this message translates to:
  /// **'acertou.'**
  String get guessInstructionLine3;

  /// No description provided for @guessCorrectButton.
  ///
  /// In pt_BR, this message translates to:
  /// **'ACERTOU'**
  String get guessCorrectButton;

  /// No description provided for @guessWrongButton.
  ///
  /// In pt_BR, this message translates to:
  /// **'ERROU'**
  String get guessWrongButton;

  /// No description provided for @correct.
  ///
  /// In pt_BR, this message translates to:
  /// **'Acertou'**
  String get correct;

  /// No description provided for @wrong.
  ///
  /// In pt_BR, this message translates to:
  /// **'Errou'**
  String get wrong;

  /// No description provided for @playAgain.
  ///
  /// In pt_BR, this message translates to:
  /// **'NOVA PARTIDA'**
  String get playAgain;

  /// No description provided for @newMatchDialogTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'NOVA PARTIDA'**
  String get newMatchDialogTitle;

  /// No description provided for @newMatchDialogMessage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quer manter a mesma categoria ou escolher outra?'**
  String get newMatchDialogMessage;

  /// No description provided for @newMatchKeepCategory.
  ///
  /// In pt_BR, this message translates to:
  /// **'MANTER CATEGORIA'**
  String get newMatchKeepCategory;

  /// No description provided for @newMatchChangeCategory.
  ///
  /// In pt_BR, this message translates to:
  /// **'TROCAR CATEGORIA'**
  String get newMatchChangeCategory;

  /// No description provided for @backToHome.
  ///
  /// In pt_BR, this message translates to:
  /// **'VOLTAR AO INÍCIO'**
  String get backToHome;

  /// No description provided for @resultsWinnerWins.
  ///
  /// In pt_BR, this message translates to:
  /// **'{name} venceu!'**
  String resultsWinnerWins(String name);

  /// No description provided for @resultsTheMastermind.
  ///
  /// In pt_BR, this message translates to:
  /// **'O MESTRE'**
  String get resultsTheMastermind;

  /// No description provided for @resultsSecretWordWas.
  ///
  /// In pt_BR, this message translates to:
  /// **'A PALAVRA SECRETA ERA:'**
  String get resultsSecretWordWas;

  /// No description provided for @resultsOutPlayerWas.
  ///
  /// In pt_BR, this message translates to:
  /// **'{name} estava Fora do Loop!'**
  String resultsOutPlayerWas(String name);

  /// No description provided for @resultsLeaderboard.
  ///
  /// In pt_BR, this message translates to:
  /// **'PLACAR'**
  String get resultsLeaderboard;

  /// No description provided for @settings.
  ///
  /// In pt_BR, this message translates to:
  /// **'Configuracoes'**
  String get settings;

  /// No description provided for @settingsScreenTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'CONFIGURAÇÕES'**
  String get settingsScreenTitle;

  /// No description provided for @settingsSectionLanguage.
  ///
  /// In pt_BR, this message translates to:
  /// **'IDIOMA'**
  String get settingsSectionLanguage;

  /// No description provided for @settingsSectionAudio.
  ///
  /// In pt_BR, this message translates to:
  /// **'ÁUDIO'**
  String get settingsSectionAudio;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In pt_BR, this message translates to:
  /// **'SOBRE'**
  String get settingsSectionAbout;

  /// No description provided for @settingsMusic.
  ///
  /// In pt_BR, this message translates to:
  /// **'Música'**
  String get settingsMusic;

  /// No description provided for @settingsSoundEffects.
  ///
  /// In pt_BR, this message translates to:
  /// **'Efeitos Sonoros'**
  String get settingsSoundEffects;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In pt_BR, this message translates to:
  /// **'Termos de Uso'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsPrivacy.
  ///
  /// In pt_BR, this message translates to:
  /// **'Privacidade'**
  String get settingsPrivacy;

  /// No description provided for @settingsAppVersionLabel.
  ///
  /// In pt_BR, this message translates to:
  /// **'Versão do App'**
  String get settingsAppVersionLabel;

  /// No description provided for @settingsAppVersionValue.
  ///
  /// In pt_BR, this message translates to:
  /// **'v0.1.0'**
  String get settingsAppVersionValue;

  /// No description provided for @settingsLanguagePortuguese.
  ///
  /// In pt_BR, this message translates to:
  /// **'Português'**
  String get settingsLanguagePortuguese;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In pt_BR, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In pt_BR, this message translates to:
  /// **'Español'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsLanguageHindi.
  ///
  /// In pt_BR, this message translates to:
  /// **'Hindi'**
  String get settingsLanguageHindi;

  /// No description provided for @settingsLanguageArabic.
  ///
  /// In pt_BR, this message translates to:
  /// **'Árabe'**
  String get settingsLanguageArabic;

  /// No description provided for @language.
  ///
  /// In pt_BR, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @howToPlayScreenTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'COMO JOGAR'**
  String get howToPlayScreenTitle;

  /// No description provided for @howToPlayKapow.
  ///
  /// In pt_BR, this message translates to:
  /// **'KA-POW!'**
  String get howToPlayKapow;

  /// No description provided for @howToPlaySecretTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'O SEGREDO'**
  String get howToPlaySecretTitle;

  /// No description provided for @howToPlaySecretBodyBefore.
  ///
  /// In pt_BR, this message translates to:
  /// **'Cada jogador vê a palavra secreta, exceto um... que está '**
  String get howToPlaySecretBodyBefore;

  /// No description provided for @howToPlaySecretBodyHighlight.
  ///
  /// In pt_BR, this message translates to:
  /// **'Fora do Loop!'**
  String get howToPlaySecretBodyHighlight;

  /// No description provided for @howToPlayQuestionTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'A PERGUNTA'**
  String get howToPlayQuestionTitle;

  /// No description provided for @howToPlayQuestionBodyBefore.
  ///
  /// In pt_BR, this message translates to:
  /// **'No modo guiado, responda às perguntas do app. No modo livre, dê uma pista de uma palavra. '**
  String get howToPlayQuestionBodyBefore;

  /// No description provided for @howToPlayQuestionBodyEmphasis.
  ///
  /// In pt_BR, this message translates to:
  /// **'Seja esperto!'**
  String get howToPlayQuestionBodyEmphasis;

  /// No description provided for @howToPlayVoteTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'A VOTAÇÃO'**
  String get howToPlayVoteTitle;

  /// No description provided for @howToPlayVoteBodyBefore.
  ///
  /// In pt_BR, this message translates to:
  /// **'Tente descobrir quem não sabe de nada e '**
  String get howToPlayVoteBodyBefore;

  /// No description provided for @howToPlayVoteBodyHighlight.
  ///
  /// In pt_BR, this message translates to:
  /// **'VOTE!'**
  String get howToPlayVoteBodyHighlight;

  /// No description provided for @howToPlayVoteBodyAfter.
  ///
  /// In pt_BR, this message translates to:
  /// **' Aponte o dedo sem medo.'**
  String get howToPlayVoteBodyAfter;

  /// No description provided for @howToPlayOutcomeTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'O DESFECHO'**
  String get howToPlayOutcomeTitle;

  /// No description provided for @howToPlayOutcomeBodyBefore.
  ///
  /// In pt_BR, this message translates to:
  /// **'Se o \'Fora do Loop\' adivinhar a palavra no final, '**
  String get howToPlayOutcomeBodyBefore;

  /// No description provided for @howToPlayOutcomeBodyHighlight.
  ///
  /// In pt_BR, this message translates to:
  /// **'ele ganha'**
  String get howToPlayOutcomeBodyHighlight;

  /// No description provided for @howToPlayOutcomeBodyAfter.
  ///
  /// In pt_BR, this message translates to:
  /// **' e vira o mestre!'**
  String get howToPlayOutcomeBodyAfter;

  /// No description provided for @reviewPromptTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Curtiu a partida?'**
  String get reviewPromptTitle;

  /// No description provided for @reviewPromptMessage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Se a galera se divertiu, uma avaliação na loja ajuda o jogo a chegar em mais mesas.'**
  String get reviewPromptMessage;

  /// No description provided for @reviewPromptRate.
  ///
  /// In pt_BR, this message translates to:
  /// **'AVALIAR'**
  String get reviewPromptRate;

  /// No description provided for @reviewPromptLater.
  ///
  /// In pt_BR, this message translates to:
  /// **'AGORA NÃO'**
  String get reviewPromptLater;

  /// No description provided for @gameModeLabel.
  ///
  /// In pt_BR, this message translates to:
  /// **'Como vocês vão jogar?'**
  String get gameModeLabel;

  /// No description provided for @guidedMode.
  ///
  /// In pt_BR, this message translates to:
  /// **'Guiado'**
  String get guidedMode;

  /// No description provided for @guidedModeDescription.
  ///
  /// In pt_BR, this message translates to:
  /// **'Respondam às perguntas do app.'**
  String get guidedModeDescription;

  /// No description provided for @freeMode.
  ///
  /// In pt_BR, this message translates to:
  /// **'Modo livre'**
  String get freeMode;

  /// No description provided for @freeModeDescription.
  ///
  /// In pt_BR, this message translates to:
  /// **'Deem pistas de uma palavra e tentem disfarçar.'**
  String get freeModeDescription;

  /// No description provided for @freeClueTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Uma palavra. Capriche na pista.'**
  String get freeClueTitle;

  /// No description provided for @freeClueBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Dê uma pista em voz alta sem dizer a palavra secreta. O impostor precisa disfarçar.'**
  String get freeClueBody;

  /// No description provided for @clueDone.
  ///
  /// In pt_BR, this message translates to:
  /// **'Já dei minha pista'**
  String get clueDone;

  /// No description provided for @anotherLap.
  ///
  /// In pt_BR, this message translates to:
  /// **'Mais uma volta'**
  String get anotherLap;

  /// No description provided for @voteNow.
  ///
  /// In pt_BR, this message translates to:
  /// **'Votar agora'**
  String get voteNow;

  /// No description provided for @cluesReady.
  ///
  /// In pt_BR, this message translates to:
  /// **'Todos já deram uma pista.'**
  String get cluesReady;

  /// No description provided for @savedGroupHint.
  ///
  /// In pt_BR, this message translates to:
  /// **'Seu último grupo está pronto. Adicione ou remova jogadores se quiser.'**
  String get savedGroupHint;

  /// No description provided for @historySection.
  ///
  /// In pt_BR, this message translates to:
  /// **'Rodadas diferentes'**
  String get historySection;

  /// No description provided for @historyDescription.
  ///
  /// In pt_BR, this message translates to:
  /// **'Palavras e perguntas recentes são evitadas neste aparelho. Ao esgotar o pacote, as mais antigas voltam.'**
  String get historyDescription;

  /// No description provided for @resetHistory.
  ///
  /// In pt_BR, this message translates to:
  /// **'Reiniciar histórico de palavras'**
  String get resetHistory;

  /// No description provided for @historyReset.
  ///
  /// In pt_BR, this message translates to:
  /// **'Histórico de palavras reiniciado.'**
  String get historyReset;

  /// No description provided for @forgetGroup.
  ///
  /// In pt_BR, this message translates to:
  /// **'Esquecer grupo salvo'**
  String get forgetGroup;

  /// No description provided for @groupForgotten.
  ///
  /// In pt_BR, this message translates to:
  /// **'Grupo salvo removido.'**
  String get groupForgotten;

  /// No description provided for @gameNightPacks.
  ///
  /// In pt_BR, this message translates to:
  /// **'Pacotes para jogar juntos'**
  String get gameNightPacks;

  /// No description provided for @packsSubtitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Novos assuntos para o próximo encontro. Conteúdo em inglês.'**
  String get packsSubtitle;

  /// No description provided for @packPurchaseOnce.
  ///
  /// In pt_BR, this message translates to:
  /// **'Compra única. Sem assinatura.'**
  String get packPurchaseOnce;

  /// No description provided for @packOwned.
  ///
  /// In pt_BR, this message translates to:
  /// **'Pronto para jogar'**
  String get packOwned;

  /// No description provided for @packPlay.
  ///
  /// In pt_BR, this message translates to:
  /// **'Jogar este pacote'**
  String get packPlay;

  /// No description provided for @packBuy.
  ///
  /// In pt_BR, this message translates to:
  /// **'Desbloquear pacote'**
  String get packBuy;

  /// No description provided for @packUnavailable.
  ///
  /// In pt_BR, this message translates to:
  /// **'As compras estão indisponíveis no momento. Suas categorias gratuitas continuam disponíveis.'**
  String get packUnavailable;

  /// No description provided for @restorePurchases.
  ///
  /// In pt_BR, this message translates to:
  /// **'Restaurar compras'**
  String get restorePurchases;

  /// No description provided for @purchaseFailed.
  ///
  /// In pt_BR, this message translates to:
  /// **'Não foi possível concluir a compra. Tente novamente.'**
  String get purchaseFailed;

  /// No description provided for @purchasePending.
  ///
  /// In pt_BR, this message translates to:
  /// **'Sua compra aguarda aprovação. Você pode continuar nas categorias gratuitas.'**
  String get purchasePending;

  /// No description provided for @purchaseRestored.
  ///
  /// In pt_BR, this message translates to:
  /// **'Compras verificadas. Seus pacotes disponíveis aparecem abaixo.'**
  String get purchaseRestored;

  /// No description provided for @purchaseSuccess.
  ///
  /// In pt_BR, this message translates to:
  /// **'Seu pacote está pronto. Vamos jogar!'**
  String get purchaseSuccess;

  /// No description provided for @packEnglishOnly.
  ///
  /// In pt_BR, this message translates to:
  /// **'Conteúdo em inglês'**
  String get packEnglishOnly;

  /// No description provided for @packBundleTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Coleção Game Night'**
  String get packBundleTitle;

  /// No description provided for @packBundleDescription.
  ///
  /// In pt_BR, this message translates to:
  /// **'Os três pacotes listados aqui. Uma compra para manter todos.'**
  String get packBundleDescription;

  /// No description provided for @roundsOnlySummary.
  ///
  /// In pt_BR, this message translates to:
  /// **'{roundCount} rodadas · pistas de uma palavra'**
  String roundsOnlySummary(int roundCount);

  /// No description provided for @packWordCount.
  ///
  /// In pt_BR, this message translates to:
  /// **'{count} palavras · guiado e livre'**
  String packWordCount(int count);

  /// No description provided for @readyToPlay.
  ///
  /// In pt_BR, this message translates to:
  /// **'Para jogar'**
  String get readyToPlay;

  /// No description provided for @explorePacks.
  ///
  /// In pt_BR, this message translates to:
  /// **'Explorar pacotes'**
  String get explorePacks;

  /// No description provided for @packEnglishContent.
  ///
  /// In pt_BR, this message translates to:
  /// **'Pacote com conteúdo em inglês'**
  String get packEnglishContent;

  /// No description provided for @onboardingSkip.
  ///
  /// In pt_BR, this message translates to:
  /// **'Pular'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In pt_BR, this message translates to:
  /// **'Continuar'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In pt_BR, this message translates to:
  /// **'Começar partida'**
  String get onboardingStart;

  /// No description provided for @onboardingReplay.
  ///
  /// In pt_BR, this message translates to:
  /// **'Rever tutorial interativo'**
  String get onboardingReplay;

  /// No description provided for @onboardingStep.
  ///
  /// In pt_BR, this message translates to:
  /// **'PASSO {step} DE 3'**
  String onboardingStep(int step);

  /// No description provided for @onboardingSecretTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Todos sabem. Menos um.'**
  String get onboardingSecretTitle;

  /// No description provided for @onboardingSecretBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Junte de 3 a 9 pessoas. Todos recebem a mesma palavra secreta, exceto uma pessoa: quem está Fora do Loop precisa blefar!'**
  String get onboardingSecretBody;

  /// No description provided for @onboardingPassTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Veja seu segredo e passe o celular.'**
  String get onboardingPassTitle;

  /// No description provided for @onboardingPassBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Toque no card para praticar. Na partida, veja seu papel sem mostrar aos outros, esconda a palavra e passe o celular para a próxima pessoa.'**
  String get onboardingPassBody;

  /// No description provided for @onboardingVoteTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Dê pistas. Blefe. Vote.'**
  String get onboardingVoteTitle;

  /// No description provided for @onboardingVoteBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'No modo guiado, responda às perguntas. No livre, dê uma pista de uma palavra. Depois, votem em quem está Fora do Loop. Se essa pessoa adivinhar a palavra no final, ela ganha!'**
  String get onboardingVoteBody;

  /// No description provided for @onboardingWord.
  ///
  /// In pt_BR, this message translates to:
  /// **'Pizza'**
  String get onboardingWord;

  /// No description provided for @onboardingOut.
  ///
  /// In pt_BR, this message translates to:
  /// **'Fora do Loop'**
  String get onboardingOut;

  /// No description provided for @onboardingReveal.
  ///
  /// In pt_BR, this message translates to:
  /// **'Toque para revelar'**
  String get onboardingReveal;

  /// No description provided for @onboardingHide.
  ///
  /// In pt_BR, this message translates to:
  /// **'Toque para esconder'**
  String get onboardingHide;

  /// No description provided for @onboardingVoteLabel.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quem está blefando?'**
  String get onboardingVoteLabel;

  /// No description provided for @onboardingSaveError.
  ///
  /// In pt_BR, this message translates to:
  /// **'Não foi possível salvar. Tente novamente.'**
  String get onboardingSaveError;

  /// No description provided for @classicDevTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Classic · desenvolvimento'**
  String get classicDevTitle;

  /// No description provided for @classicFixtureNotice.
  ///
  /// In pt_BR, this message translates to:
  /// **'Catálogo offline · revisão editorial pendente'**
  String get classicFixtureNotice;

  /// No description provided for @classicHint.
  ///
  /// In pt_BR, this message translates to:
  /// **'Dica da categoria'**
  String get classicHint;

  /// No description provided for @classicSheet.
  ///
  /// In pt_BR, this message translates to:
  /// **'Sheet de componentes'**
  String get classicSheet;

  /// No description provided for @classicUnavailable.
  ///
  /// In pt_BR, this message translates to:
  /// **'Jogo disponível na etapa 3'**
  String get classicUnavailable;

  /// No description provided for @classicLoading.
  ///
  /// In pt_BR, this message translates to:
  /// **'Carregando'**
  String get classicLoading;

  /// No description provided for @classicError.
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro de exemplo'**
  String get classicError;

  /// No description provided for @classicRetry.
  ///
  /// In pt_BR, this message translates to:
  /// **'Tentar novamente'**
  String get classicRetry;

  /// No description provided for @classicCrew.
  ///
  /// In pt_BR, this message translates to:
  /// **'Seu grupo'**
  String get classicCrew;

  /// No description provided for @classicNames.
  ///
  /// In pt_BR, this message translates to:
  /// **'Editar nomes'**
  String get classicNames;

  /// No description provided for @classicCategories.
  ///
  /// In pt_BR, this message translates to:
  /// **'Categorias'**
  String get classicCategories;

  /// No description provided for @classicImpostors.
  ///
  /// In pt_BR, this message translates to:
  /// **'Impostores'**
  String get classicImpostors;

  /// No description provided for @classicAuto.
  ///
  /// In pt_BR, this message translates to:
  /// **'Auto (recomendado)'**
  String get classicAuto;

  /// No description provided for @classicTimer.
  ///
  /// In pt_BR, this message translates to:
  /// **'Tempo de discussão'**
  String get classicTimer;

  /// No description provided for @classicDuration.
  ///
  /// In pt_BR, this message translates to:
  /// **'Duração'**
  String get classicDuration;

  /// No description provided for @classicTroll.
  ///
  /// In pt_BR, this message translates to:
  /// **'Modo Troll'**
  String get classicTroll;

  /// No description provided for @classicSave.
  ///
  /// In pt_BR, this message translates to:
  /// **'Salvar nomes'**
  String get classicSave;

  /// No description provided for @classicConfirm.
  ///
  /// In pt_BR, this message translates to:
  /// **'Confirmar'**
  String get classicConfirm;

  /// No description provided for @classicClear.
  ///
  /// In pt_BR, this message translates to:
  /// **'Limpar'**
  String get classicClear;

  /// No description provided for @classicSelectFree.
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar todas grátis'**
  String get classicSelectFree;

  /// No description provided for @classicSelectAll.
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar todas'**
  String get classicSelectAll;

  /// No description provided for @classicAll.
  ///
  /// In pt_BR, this message translates to:
  /// **'Todas'**
  String get classicAll;

  /// No description provided for @classicDone.
  ///
  /// In pt_BR, this message translates to:
  /// **'Concluir'**
  String get classicDone;

  /// No description provided for @classicAdd.
  ///
  /// In pt_BR, this message translates to:
  /// **'Adicionar jogador'**
  String get classicAdd;

  /// No description provided for @classicRemove.
  ///
  /// In pt_BR, this message translates to:
  /// **'Remover jogador'**
  String get classicRemove;

  /// No description provided for @classicPlayer.
  ///
  /// In pt_BR, this message translates to:
  /// **'Jogador'**
  String get classicPlayer;

  /// No description provided for @classicHelp.
  ///
  /// In pt_BR, this message translates to:
  /// **'Como jogar'**
  String get classicHelp;

  /// No description provided for @classicSettings.
  ///
  /// In pt_BR, this message translates to:
  /// **'Configurações'**
  String get classicSettings;

  /// No description provided for @classicPremium.
  ///
  /// In pt_BR, this message translates to:
  /// **'Premium · demo'**
  String get classicPremium;

  /// No description provided for @classicDemoBuy.
  ///
  /// In pt_BR, this message translates to:
  /// **'Ativar Premium de demonstração'**
  String get classicDemoBuy;

  /// No description provided for @classicDemoNotice.
  ///
  /// In pt_BR, this message translates to:
  /// **'Demonstração de desenvolvimento. Premium simulado, sem compra real. As três categorias grátis têm conteúdo em inglês. Catálogo completo na etapa 5; retomada após fechar o app na etapa 4.'**
  String get classicDemoNotice;

  /// No description provided for @classicStart.
  ///
  /// In pt_BR, this message translates to:
  /// **'Iniciar partida'**
  String get classicStart;

  /// No description provided for @classicTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quem é o impostor?'**
  String get classicTitle;

  /// No description provided for @classicSubtitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Um telefone. Seus amigos. Uma palavra secreta.'**
  String get classicSubtitle;

  /// No description provided for @classicOff.
  ///
  /// In pt_BR, this message translates to:
  /// **'Desligado'**
  String get classicOff;

  /// No description provided for @classicMinutes.
  ///
  /// In pt_BR, this message translates to:
  /// **'minutos'**
  String get classicMinutes;

  /// No description provided for @classicShare.
  ///
  /// In pt_BR, this message translates to:
  /// **'Compartilhar · disponível na etapa 7'**
  String get classicShare;

  /// No description provided for @classicRate.
  ///
  /// In pt_BR, this message translates to:
  /// **'Avaliar · disponível na etapa 7'**
  String get classicRate;

  /// No description provided for @classicFooter.
  ///
  /// In pt_BR, this message translates to:
  /// **'Conversem, blefem e votem juntos. A discussão acontece fora da tela.'**
  String get classicFooter;

  /// No description provided for @classicHelpSteps.
  ///
  /// In pt_BR, this message translates to:
  /// **'1. Reúna 3–20 jogadores com um telefone.\n2. Segure para ver seu papel; solte para esconder.\n3. Dê pistas sobre a palavra secreta.\n4. Impostores blefam para se misturar.\n5. Conversem e votem presencialmente.\n6. Confirme a revelação para ver a palavra e os impostores.\n\nA dica mostra só a categoria. Troll pode tornar todos impostores.'**
  String get classicHelpSteps;

  /// No description provided for @classicEnglish.
  ///
  /// In pt_BR, this message translates to:
  /// **'Idioma do conteúdo: inglês (demo)'**
  String get classicEnglish;

  /// No description provided for @classicClose.
  ///
  /// In pt_BR, this message translates to:
  /// **'Fechar'**
  String get classicClose;

  /// No description provided for @classicHold.
  ///
  /// In pt_BR, this message translates to:
  /// **'Segure aqui para ver seu papel'**
  String get classicHold;

  /// No description provided for @classicRelease.
  ///
  /// In pt_BR, this message translates to:
  /// **'Solte para ocultar. Só passe o telefone com o cartão coberto.'**
  String get classicRelease;

  /// No description provided for @classicShowRole.
  ///
  /// In pt_BR, this message translates to:
  /// **'Revelar papel · alternativa acessível'**
  String get classicShowRole;

  /// No description provided for @classicHideRole.
  ///
  /// In pt_BR, this message translates to:
  /// **'Ocultar papel'**
  String get classicHideRole;

  /// No description provided for @classicYouImpostor.
  ///
  /// In pt_BR, this message translates to:
  /// **'Você é um impostor'**
  String get classicYouImpostor;

  /// No description provided for @classicYourWord.
  ///
  /// In pt_BR, this message translates to:
  /// **'Palavra secreta'**
  String get classicYourWord;

  /// No description provided for @classicNext.
  ///
  /// In pt_BR, this message translates to:
  /// **'Próximo jogador'**
  String get classicNext;

  /// No description provided for @classicDiscuss.
  ///
  /// In pt_BR, this message translates to:
  /// **'Começar discussão'**
  String get classicDiscuss;

  /// No description provided for @classicStarts.
  ///
  /// In pt_BR, this message translates to:
  /// **'Primeiro a dar uma pista'**
  String get classicStarts;

  /// No description provided for @classicInPerson.
  ///
  /// In pt_BR, this message translates to:
  /// **'Deem pistas, blefem, conversem e votem presencialmente. Quando todos estiverem prontos, revelem o resultado juntos.'**
  String get classicInPerson;

  /// No description provided for @classicPause.
  ///
  /// In pt_BR, this message translates to:
  /// **'Pausar timer'**
  String get classicPause;

  /// No description provided for @classicResume.
  ///
  /// In pt_BR, this message translates to:
  /// **'Retomar timer'**
  String get classicResume;

  /// No description provided for @classicTimeUp.
  ///
  /// In pt_BR, this message translates to:
  /// **'O tempo acabou. Continuem conversando ou revelem quando quiserem.'**
  String get classicTimeUp;

  /// No description provided for @classicReveal.
  ///
  /// In pt_BR, this message translates to:
  /// **'Revelar resultado'**
  String get classicReveal;

  /// No description provided for @classicRevealQuestion.
  ///
  /// In pt_BR, this message translates to:
  /// **'Revelar o segredo?'**
  String get classicRevealQuestion;

  /// No description provided for @classicRevealWarning.
  ///
  /// In pt_BR, this message translates to:
  /// **'Todos verão a palavra e todos os impostores. Terminem a votação antes.'**
  String get classicRevealWarning;

  /// No description provided for @classicCancel.
  ///
  /// In pt_BR, this message translates to:
  /// **'Cancelar'**
  String get classicCancel;

  /// No description provided for @classicEnd.
  ///
  /// In pt_BR, this message translates to:
  /// **'Encerrar rodada'**
  String get classicEnd;

  /// No description provided for @classicExitQuestion.
  ///
  /// In pt_BR, this message translates to:
  /// **'Encerrar esta rodada?'**
  String get classicExitQuestion;

  /// No description provided for @classicExitWarning.
  ///
  /// In pt_BR, this message translates to:
  /// **'Voltar à configuração sem revelar segredos. Esta rodada não poderá ser retomada.'**
  String get classicExitWarning;

  /// No description provided for @classicResult.
  ///
  /// In pt_BR, this message translates to:
  /// **'Os impostores eram…'**
  String get classicResult;

  /// No description provided for @classicTrollResult.
  ///
  /// In pt_BR, this message translates to:
  /// **'Rodada Troll — todo mundo!'**
  String get classicTrollResult;

  /// No description provided for @classicAgain.
  ///
  /// In pt_BR, this message translates to:
  /// **'Jogar novamente'**
  String get classicAgain;

  /// No description provided for @classicEditGame.
  ///
  /// In pt_BR, this message translates to:
  /// **'Editar jogo'**
  String get classicEditGame;

  /// No description provided for @classicContentMissing.
  ///
  /// In pt_BR, this message translates to:
  /// **'Algumas categorias selecionadas ainda não têm conteúdo jogável em inglês. Escolha as gratuitas para começar.'**
  String get classicContentMissing;

  /// No description provided for @classicRecoveryTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Recuperar jogo salvo'**
  String get classicRecoveryTitle;

  /// No description provided for @classicFutureSave.
  ///
  /// In pt_BR, this message translates to:
  /// **'Este save exige uma versão mais nova. Tente novamente ou jogue temporariamente sem substituí-lo.'**
  String get classicFutureSave;

  /// No description provided for @classicRecoveryBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Não foi possível ler o jogo salvo. Tente novamente ou comece com o grupo e histórico válidos. Compras e preferências serão preservadas.'**
  String get classicRecoveryBody;

  /// No description provided for @classicNewGame.
  ///
  /// In pt_BR, this message translates to:
  /// **'Nova partida'**
  String get classicNewGame;

  /// No description provided for @classicDiscardBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Descartar apenas a rodada salva? Grupo, histórico, preferências e compras serão mantidos.'**
  String get classicDiscardBody;

  /// No description provided for @classicResumeTitle.
  ///
  /// In pt_BR, this message translates to:
  /// **'Partida em andamento'**
  String get classicResumeTitle;

  /// No description provided for @classicResumeBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Retome com os cartões cobertos e o timer pausado, ou encerre esta rodada.'**
  String get classicResumeBody;

  /// No description provided for @classicWriteFailure.
  ///
  /// In pt_BR, this message translates to:
  /// **'Não foi possível salvar. Tente novamente ou continue sabendo que reabrir pode voltar à última transição salva.'**
  String get classicWriteFailure;

  /// No description provided for @classicContinueUnsaved.
  ///
  /// In pt_BR, this message translates to:
  /// **'Continuar sem salvar'**
  String get classicContinueUnsaved;

  /// No description provided for @classicUnsavedNotice.
  ///
  /// In pt_BR, this message translates to:
  /// **'Progresso não salvo. Reabrir pode perder as últimas ações.'**
  String get classicUnsavedNotice;

  /// No description provided for @classicResetHistory.
  ///
  /// In pt_BR, this message translates to:
  /// **'Limpar histórico de palavras'**
  String get classicResetHistory;

  /// No description provided for @classicResetHistoryBody.
  ///
  /// In pt_BR, this message translates to:
  /// **'Limpar apenas o histórico de palavras e impostores? Grupo, preferências e compras serão mantidos.'**
  String get classicResetHistoryBody;

  /// No description provided for @classicResumeGame.
  ///
  /// In pt_BR, this message translates to:
  /// **'Retomar partida'**
  String get classicResumeGame;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'hi', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
