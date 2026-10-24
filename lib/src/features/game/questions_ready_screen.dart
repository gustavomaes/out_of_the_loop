import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import '../setup/category_localization.dart';
import 'widgets/heading_with_shadow.dart';
import 'widgets/secret_reveal_cta.dart';
import 'widgets/speak_up_prompt.dart';

class QuestionsReadyScreen extends StatelessWidget {
  const QuestionsReadyScreen({
    required this.category,
    required this.language,
    required this.roundNumber,
    this.onStart,
    this.onBack,
    super.key,
  });

  final Category category;
  final SupportedLanguage language;
  final int roundNumber;
  final VoidCallback? onStart;
  final VoidCallback? onBack;

  Future<void> _onBackPressed(BuildContext context) async {
    await confirmExitGameOnBack(context, onBack: onBack);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeName = l10n.categoryDisplayName(
      categoryId: category.id,
      fallback: category.name,
      language: language,
    );

    return BrutalistScreenTheme.wrap(
      context,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            unawaited(_onBackPressed(context));
          }
        },
        child: Scaffold(
          appBar: OtlBrutalistDiscoveryAppBar(
            onBack: () => _onBackPressed(context),
            showSettings: false,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              const OtlPartyAtmosphere.questionRound(),
              SafeArea(
                top: false,
                child: LayoutBuilder(
                  builder: (context, viewport) {
                    final sectionGap = viewport.maxHeight < 700 ? 24.0 : 40.0;

                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 448),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                          child: Column(
                            children: [
                              Text(
                                l10n.secretRevealRound(roundNumber),
                                style: DisplayTypography.spaceGroteskRoundLabel(
                                  color: BrutalistColors.sectionLabel,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: sectionGap),
                              HeadingWithShadow(
                                line1: l10n.questionsReadyTitleLine1,
                                line2: l10n.questionsReadyTitleLine2,
                              ),
                              SizedBox(height: sectionGap),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SpeakUpPrompt(
                                      title: l10n.questionsReadyThemeLabel,
                                      line1: themeName,
                                      line2: l10n.questionsReadyBody,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              SecretRevealCta(
                                label: l10n.questionsReadyStartQuestions,
                                onPressed: () => onStart?.call(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
