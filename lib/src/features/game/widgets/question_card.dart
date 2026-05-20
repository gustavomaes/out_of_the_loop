import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'question_card_accent.dart';
import 'question_mark_badge.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.questionText, super.key});

  final String questionText;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;
  static const _accentHeight = 16.0;
  static const _verticalPadding = 72.0;
  static const _contentChrome = _accentHeight + _verticalPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minCardHeight = constraints.minHeight;
        final minContentHeight = (minCardHeight - _contentChrome).clamp(
          0.0,
          double.infinity,
        );

        return Padding(
          padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minCardHeight),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: _shadowDx,
                  top: _shadowDy,
                  right: 0,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: BrutalistColors.homeSecondaryButton,
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(44),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const QuestionCardAccent(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(36, 36, 36, 36),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: minContentHeight,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const QuestionMarkBadge(),
                                  const SizedBox(height: 24),
                                  Text(
                                    questionText,
                                    style:
                                        DisplayTypography.rubikQuestionCard(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
