import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'otl_neon_action.dart';

class OtlBrutalistPillButton extends StatelessWidget {
  const OtlBrutalistPillButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    this.borderRadius = 14,
    super.key,
  });
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final double borderRadius;
  @override
  Widget build(BuildContext context) => OtlNeonAction(
    label: label,
    onPressed: onPressed,
    icon: icon,
    primary: backgroundColor == BrutalistColors.lime,
  );
}
