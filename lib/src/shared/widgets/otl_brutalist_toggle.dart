import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Neubrutalist on/off pill used in settings rows (display-only; tap handled by parent).
class OtlBrutalistToggle extends StatelessWidget {
  const OtlBrutalistToggle({required this.value, super.key});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 64,
        height: 32,
        padding: EdgeInsets.fromLTRB(value ? 38 : 6, 6, value ? 10 : 42, 6),
        decoration: BoxDecoration(
          color: value ? BrutalistColors.lime : BrutalistColors.toggleOff,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
