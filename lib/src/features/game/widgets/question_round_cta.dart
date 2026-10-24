import 'package:flutter/material.dart';
import '../../../shared/widgets/otl_neon_action.dart';

class QuestionRoundCta extends StatelessWidget {
  const QuestionRoundCta({
    required this.label,
    required this.onPressed,
    super.key,
  });
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 12),
    child: OtlNeonAction(label: label, onPressed: onPressed),
  );
}
