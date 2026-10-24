import 'package:flutter/material.dart';
import '../../../shared/widgets/otl_neon_action.dart';

class PlayerSetupFooter extends StatelessWidget {
  const PlayerSetupFooter({
    required this.label,
    required this.enabled,
    required this.onPressed,
    super.key,
  });
  final String label;
  final bool enabled;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => OtlNeonFooter(
    child: OtlNeonAction(
      label: label,
      onPressed: enabled ? onPressed : null,
      icon: Icons.play_arrow,
    ),
  );
}
