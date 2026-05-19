import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/services/match_setup_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/brutalist_theme.dart';
import '../../theme/display_typography.dart';

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
            const _MatchSetupAtmosphere(),
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
                _MatchSetupHeader(l10n: l10n),
                const SizedBox(height: 8),
                Text(
                  l10n.matchSetupSubtitle,
                  style: DisplayTypography.plusJakartaBody(
                    color: BrutalistColors.sectionLabel,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                _QuestionsPerPlayerSelector(
                  l10n: l10n,
                  value: _questionsPerPlayer,
                  maxValue: _maxQuestionsPerPlayer,
                  onChanged: _setQuestionsPerPlayer,
                ),
                const SizedBox(height: 24),
                _RoundCountSelector(
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
              child: _MatchSetupFooter(
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

class _MatchSetupHeader extends StatelessWidget {
  const _MatchSetupHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.matchSetupTitleLine1,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        Text(
          l10n.matchSetupTitleLine2,
          style: DisplayTypography.rubikPlayerSetupTitle(
            color: BrutalistColors.lime,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 4),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: const Offset(4, 4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: BrutalistColors.playerCardYellow,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    l10n.matchSetupRulesBadge,
                    key: const Key('match_setup_rules_badge'),
                    style: DisplayTypography.spaceGroteskMeta(
                      color: BrutalistColors.limeText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MatchSetupSectionCard extends StatelessWidget {
  const _MatchSetupSectionCard({
    required this.icon,
    required this.sectionLabel,
    required this.description,
    required this.recommendation,
    required this.valueLabel,
    required this.child,
  });

  final IconData icon;
  final String sectionLabel;
  final String description;
  final String recommendation;
  final String valueLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 4,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: BrutalistColors.lime, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  sectionLabel,
                  style: DisplayTypography.spaceGroteskSectionLabel(
                    color: BrutalistColors.lime,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: DisplayTypography.plusJakartaBody(
              color: BrutalistColors.cardText,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            recommendation,
            style: DisplayTypography.plusJakartaBody(
              color: BrutalistColors.sectionLabel,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            valueLabel,
            key: ValueKey('match_setup_value_$sectionLabel'),
            style: DisplayTypography.rubikSettingLabel(
              color: BrutalistColors.cardText,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _RoundCountSelector extends StatelessWidget {
  const _RoundCountSelector({
    required this.l10n,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return _MatchSetupSectionCard(
      icon: Icons.layers_outlined,
      sectionLabel: l10n.matchSetupRoundsSection,
      description: l10n.matchSetupRoundsDescription,
      recommendation: l10n.matchSetupRoundsRecommended(
        MatchSetup.recommendedRoundCount,
      ),
      valueLabel: l10n.matchSetupRoundsValue(value),
      child: Row(
        children: [
          for (
            var count = MatchSetup.minRoundCount;
            count <= MatchSetup.maxRoundCount;
            count += 1
          )
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: count == MatchSetup.minRoundCount ? 0 : 8,
                ),
                child: _BrutalistCountChip(
                  key: Key('round_count_$count'),
                  label: '$count',
                  selected: value == count,
                  enabled: count <= maxValue,
                  onTap: () => onChanged(count),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuestionsPerPlayerSelector extends StatelessWidget {
  const _QuestionsPerPlayerSelector({
    required this.l10n,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final recommended = MatchSetupService.recommendedQuestionsPerPlayer(3);

    return _MatchSetupSectionCard(
      icon: Icons.quiz_outlined,
      sectionLabel: l10n.matchSetupQuestionsSection,
      description: l10n.matchSetupQuestionsDescription,
      recommendation: l10n.matchSetupQuestionsRecommendation(recommended),
      valueLabel: l10n.matchSetupQuestionCountChip(value),
      child: Row(
        children: [
          for (
            var count = MatchSetup.minQuestionsPerPlayer;
            count <= MatchSetup.maxQuestionsPerPlayer;
            count += 1
          )
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: count == MatchSetup.minQuestionsPerPlayer ? 0 : 8,
                ),
                child: _BrutalistCountChip(
                  key: Key('question_count_$count'),
                  label: '$count',
                  selected: value == count,
                  enabled: count <= maxValue,
                  onTap: () => onChanged(count),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BrutalistCountChip extends StatelessWidget {
  const _BrutalistCountChip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? BrutalistColors.lime
        : BrutalistColors.homeSecondaryButton;
    final textColor = selected
        ? BrutalistColors.homePrimaryButtonText
        : BrutalistColors.cardText;

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: OtlBrutalistSurface(
        backgroundColor: backgroundColor,
        shadowOffset: 4,
        onTap: enabled ? onTap : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Text(
          label,
          style: DisplayTypography.rubikHomeButton(
            color: textColor,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _MatchSetupFooter extends StatelessWidget {
  const _MatchSetupFooter({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  static const _height = 80.0;
  static const _shadowOffset = 8.0;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: BrutalistColors.footerScrim),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomPadding),
            child: Opacity(
              opacity: enabled ? 1 : 0.45,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: _shadowOffset,
                  bottom: _shadowOffset,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Transform.translate(
                        offset: const Offset(_shadowOffset, _shadowOffset),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height,
                      width: double.infinity,
                      child: Material(
                        color: BrutalistColors.lime,
                        child: InkWell(
                          onTap: onPressed,
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  label,
                                  style: DisplayTypography.rubikPlayerSetupCta(
                                    color: BrutalistColors.homePrimaryButtonText,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.arrow_forward,
                                  color: BrutalistColors.homePrimaryButtonText,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchSetupAtmosphere extends StatelessWidget {
  const _MatchSetupAtmosphere();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: 96,
            child: _glow(color: BrutalistColors.playerCardPink),
          ),
          Positioned(
            left: -40,
            bottom: 212,
            child: _glow(color: BrutalistColors.lime),
          ),
        ],
      ),
    );
  }

  Widget _glow({required Color color}) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Opacity(
        opacity: 0.2,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
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
