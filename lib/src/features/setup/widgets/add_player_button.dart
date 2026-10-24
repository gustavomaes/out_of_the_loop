import 'package:flutter/material.dart';
import '../../../shared/widgets/otl_neon_action.dart';

class AddPlayerButton extends StatelessWidget {
  const AddPlayerButton({
    required this.label,
    required this.onPressed,
    super.key,
  });
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => OtlNeonAction(
    label: label,
    onPressed: onPressed,
    primary: false,
    icon: Icons.add,
  );
}
