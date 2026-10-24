import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class AboutDivider extends StatelessWidget {
  const AboutDivider({super.key});
  @override
  Widget build(BuildContext context) => const Divider(
    height: 1,
    thickness: 1,
    indent: 16,
    endIndent: 16,
    color: BrutalistColors.headerBorder,
  );
}
