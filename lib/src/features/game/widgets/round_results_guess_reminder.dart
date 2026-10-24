import 'package:flutter/material.dart';
import '../../../shared/widgets/otl_brutalist_surface.dart';
import '../../../theme/theme.dart';

class RoundResultsGuessReminder extends StatelessWidget {
  const RoundResultsGuessReminder({
    required this.title,
    required this.line1,
    required this.line2,
    super.key,
  });
  final String title;
  final String line1;
  final String line2;
  @override
  Widget build(BuildContext context) => OtlBrutalistSurface(
    backgroundColor: BrutalistColors.cardBackground,
    shadowOffset: 0,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.volume_off_outlined,
          color: BrutalistColors.playerCardPink,
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: DisplayTypography.rubikSpeakUpTitle(
            color: BrutalistColors.cardText,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          line1,
          style: DisplayTypography.plusJakartaSecretRevealBody(
            color: BrutalistColors.cardText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          line2,
          style: DisplayTypography.plusJakartaSecretRevealBody(
            color: BrutalistColors.sectionLabel,
          ),
        ),
      ],
    ),
  );
}
