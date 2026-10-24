import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class OtlBrutalistToggle extends StatelessWidget {
  const OtlBrutalistToggle({required this.value, super.key});
  final bool value;
  @override
  Widget build(BuildContext context) => Semantics(
    toggled: value,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 48,
      height: 28,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: value ? BrutalistColors.lime : BrutalistColors.toggleOff,
        borderRadius: BorderRadius.circular(30),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: value ? BrutalistColors.limeText : BrutalistColors.cardText,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ),
  );
}
