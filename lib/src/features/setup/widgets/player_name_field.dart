import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class PlayerNameField extends StatelessWidget {
  const PlayerNameField({
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;
  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onSubmitted: onSubmitted,
    textInputAction: TextInputAction.done,
    style: DisplayTypography.plusJakartaBody(
      color: BrutalistColors.cardText,
      fontSize: 16,
    ),
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: const Icon(Icons.person_outline),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    ),
  );
}
