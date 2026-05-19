import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'question_card_accent.dart';
import 'question_mark_badge.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.questionText, super.key});

  final String questionText;

  static const _shadowDx = 8.0;
  static const _shadowDy = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _shadowDx, bottom: _shadowDy),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(_shadowDx, _shadowDy),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: BrutalistColors.homeSecondaryButton,
                borderRadius: BorderRadius.circular(48),
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(44),
                child: Stack(
                  children: [
                    const Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: QuestionCardAccent(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(36, 36, 36, 36),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const QuestionMarkBadge(),
                              const SizedBox(height: 24),
                              Text(
                                questionText,
                                style: DisplayTypography.rubikQuestionCard(
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
          ),
        ],
      ),
    );
  }
}
