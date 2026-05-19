import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class QuestionMarkBadge extends StatelessWidget {
  const QuestionMarkBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrutalistColors.playerCardYellow,
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const SizedBox(
        width: 27,
        height: 36,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
