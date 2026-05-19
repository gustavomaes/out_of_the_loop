import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/match_setup_footer.dart';
import 'widgets/match_setup_header.dart';
import 'widgets/questions_per_player_selector.dart';
import 'widgets/round_count_selector.dart';

typedef MatchSetupContinueCallback =
    void Function(int roundCount, int questionsPerPlayer);

class MatchSetupScreen extends StatefulWidget {
  const MatchSetupScreen({
    this.categoryWords,
    this.onContinue,
    this.onBack,
    this.onSettings,
    MatchSetupService? setupService,
    super.key,
  }) : setupService = setupService ?? const MatchSetupService();

  final List<SecretWord>? categoryWords;
  final MatchSetupContinueCallback? onContinue;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;
  final MatchSetupService setupService;

  @override
  State<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends State<MatchSetupScreen> {
  var _roundCount = MatchSetup.recommendedRoundCount;
  var _roundCountTouched = false;
  var _questionsPerPlayer = MatchSetupService.recommendedQuestionsPerPlayer(0);

  List<SecretWord> get _categoryWords =>
      widget.categoryWords ?? _defaultPlayableWords;

  int get _maxQuestionsPerPlayer => MatchSetupService.maxQuestionsPerPlayerFor(
    playerCount: MatchSetup.minPlayers,
    categoryWords: _categoryWords,
  );

  int get _maxRoundCount => MatchSetupService.maxRoundCountFor(
    playerCount: MatchSetup.minPlayers,
    questionsPerPlayer: _questionsPerPlayer,
    categoryWords: _categoryWords,
  );

  bool get _canContinue =>
      _roundCount >= MatchSetup.minRoundCount &&
      _roundCount <= _maxRoundCount &&
      _questionsPerPlayer >= MatchSetup.minQuestionsPerPlayer &&
      _questionsPerPlayer <= _maxQuestionsPerPlayer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(
          onBack: widget.onBack,
          onSettings: widget.onSettings,
        ),
        body: Stack(
          children: [
            const OtlPartyAtmosphere.matchSetup(),
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                20,
                32,
                20,
                160 + MediaQuery.paddingOf(context).bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MatchSetupHeader(l10n: l10n),
                  const SizedBox(height: 8),
                  Text(
                    l10n.matchSetupSubtitle,
                    style: DisplayTypography.plusJakartaBody(
                      color: BrutalistColors.sectionLabel,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  QuestionsPerPlayerSelector(
                    l10n: l10n,
                    value: _questionsPerPlayer,
                    maxValue: _maxQuestionsPerPlayer,
                    onChanged: _setQuestionsPerPlayer,
                  ),
                  const SizedBox(height: 24),
                  RoundCountSelector(
                    l10n: l10n,
                    value: _roundCount,
                    maxValue: _maxRoundCount,
                    onChanged: _setRoundCount,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.matchSetupSummary(
                      _roundCount,
                      _questionsPerPlayer,
                    ),
                    key: const Key('match_setup_summary'),
                    style: DisplayTypography.plusJakartaBody(
                      color: BrutalistColors.cardText,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MatchSetupFooter(
                label: l10n.matchSetupContinue,
                enabled: _canContinue,
                onPressed: _canContinue
                    ? () => widget.onContinue?.call(
                        _roundCount,
                        _questionsPerPlayer,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setRoundCount(int value) {
    setState(() {
      _roundCountTouched = true;
      _roundCount = value;
    });
  }

  void _setQuestionsPerPlayer(int value) {
    setState(() => _questionsPerPlayer = value);
    _syncRoundCount();
  }

  void _syncRoundCount() {
    final nextValue = MatchSetupService.effectiveRoundCount(
      roundCount: _roundCount,
      maxRoundCount: _maxRoundCount,
      touched: _roundCountTouched,
    );

    if (nextValue == _roundCount) {
      return;
    }
    setState(() => _roundCount = nextValue);
  }
}

final _defaultPlayableWords = List.generate(
  5,
  (wordIndex) => SecretWord(
    id: 'word-$wordIndex',
    categoryId: 'food',
    value: LocalizedText({
      SupportedLanguage.ptBr: 'Palavra ${wordIndex + 1}',
      SupportedLanguage.en: 'Word ${wordIndex + 1}',
      SupportedLanguage.es: 'Palabra ${wordIndex + 1}',
      SupportedLanguage.hi: 'Word ${wordIndex + 1}',
    }),
    questions: List.generate(
      9,
      (questionIndex) => Question(
        id: 'word-$wordIndex-q$questionIndex',
        wordId: 'word-$wordIndex',
        text: LocalizedText({
          SupportedLanguage.ptBr: 'Pergunta ${questionIndex + 1}',
          SupportedLanguage.en: 'Question ${questionIndex + 1}',
          SupportedLanguage.es: 'Pregunta ${questionIndex + 1}',
          SupportedLanguage.hi: 'Question ${questionIndex + 1}',
        }),
      ),
    ),
  ),
);
