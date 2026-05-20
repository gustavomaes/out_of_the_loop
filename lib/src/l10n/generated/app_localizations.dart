import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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

  /// No description provided for @secretRevealPrivacyLine1.
  ///
  /// In pt_BR, this message translates to:
  /// **'Certifique-se de que ninguém mais'**
  String get secretRevealPrivacyLine1;

  /// No description provided for @secretRevealPrivacyLine2.
  ///
  /// In pt_BR, this message translates to:
  /// **'está olhando para sua tela.'**
  String get secretRevealPrivacyLine2;

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

  /// No description provided for @secretRevealStartQuestions.
  ///
  /// In pt_BR, this message translates to:
  /// **'INICIAR PERGUNTAS'**
  String get secretRevealStartQuestions;

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
  /// **'Responda perguntas engraçadas sobre a palavra sem dar na cara o que é. '**
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
      <String>['en', 'es', 'hi', 'pt'].contains(locale.languageCode);

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
