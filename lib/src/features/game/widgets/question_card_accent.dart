import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class QuestionCardAccent extends StatelessWidget {
  const QuestionCardAccent({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrutalistColors.playerCardYellow,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 4),
        ),
      ),
      child: const SizedBox(height: 12, width: double.infinity),
    );
  }
}
