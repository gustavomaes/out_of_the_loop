import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Quiet depth behind gameplay; all visual emphasis stays on content/actions.
class OtlPartyAtmosphere extends StatelessWidget {
  const OtlPartyAtmosphere.voting({super.key});
  const OtlPartyAtmosphere.questionRound({super.key});
  const OtlPartyAtmosphere.secretReveal({super.key});
  const OtlPartyAtmosphere.matchSetup({super.key});
  @override
  Widget build(BuildContext context) => const IgnorePointer(
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF21172D), BrutalistColors.screenBackground],
        ),
      ),
    ),
  );
}
