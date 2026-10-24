import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.questionText, super.key});
  final String questionText;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    constraints: const BoxConstraints(minHeight: 230),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: BrutalistColors.cardBackground,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: BrutalistColors.headerBorder),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.chat_bubble_outline_rounded,
          color: BrutalistColors.lime,
          size: 24,
        ),
        const SizedBox(height: 20),
        Text(
          questionText,
          style: DisplayTypography.rubikQuestionCard(
            color: BrutalistColors.cardText,
          ),
        ),
      ],
    ),
  );
}
