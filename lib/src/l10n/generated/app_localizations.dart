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

  /// No description provided for @startMatch.
  ///
  /// In pt_BR, this message translates to:
  /// **'Iniciar partida'**
  String get startMatch;

  /// No description provided for @revealMyWord.
  ///
  /// In pt_BR, this message translates to:
  /// **'Visualizar minha palavra'**
  String get revealMyWord;

  /// No description provided for @outOfLoopMessage.
  ///
  /// In pt_BR, this message translates to:
  /// **'Voce esta FORA do circulo - aja naturalmente.'**
  String get outOfLoopMessage;

  /// No description provided for @doneAnswering.
  ///
  /// In pt_BR, this message translates to:
  /// **'Terminei de responder'**
  String get doneAnswering;

  /// No description provided for @whoIsOutOfTheLoop.
  ///
  /// In pt_BR, this message translates to:
  /// **'Quem esta fora do loop?'**
  String get whoIsOutOfTheLoop;

  /// No description provided for @confirmVotes.
  ///
  /// In pt_BR, this message translates to:
  /// **'Confirmar votos'**
  String get confirmVotes;

  /// No description provided for @roundResults.
  ///
  /// In pt_BR, this message translates to:
  /// **'Resultado da rodada'**
  String get roundResults;

  /// No description provided for @guessWord.
  ///
  /// In pt_BR, this message translates to:
  /// **'Adivinhe a palavra'**
  String get guessWord;

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
  /// **'Nova partida'**
  String get playAgain;

  /// No description provided for @backToHome.
  ///
  /// In pt_BR, this message translates to:
  /// **'Voltar ao inicio'**
  String get backToHome;

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

  /// No description provided for @settingsSectionTimer.
  ///
  /// In pt_BR, this message translates to:
  /// **'TIMER'**
  String get settingsSectionTimer;

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

  /// No description provided for @settingsUseTimer.
  ///
  /// In pt_BR, this message translates to:
  /// **'Usar timer'**
  String get settingsUseTimer;

  /// No description provided for @settingsTimerSeconds.
  ///
  /// In pt_BR, this message translates to:
  /// **'{seconds} segundos por turno'**
  String settingsTimerSeconds(int seconds);

  /// No description provided for @language.
  ///
  /// In pt_BR, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @timer.
  ///
  /// In pt_BR, this message translates to:
  /// **'Timer'**
  String get timer;

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
