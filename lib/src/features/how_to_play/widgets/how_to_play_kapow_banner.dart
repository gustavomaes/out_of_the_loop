import 'package:flutter/material.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../theme/theme.dart';

/// Party image banner with lime KAPOW label.
class HowToPlayKapowBanner extends StatelessWidget {
  const HowToPlayKapowBanner({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistSurface(
      backgroundColor: BrutalistColors.cardBackground,
      shadowOffset: 6,
      padding: const EdgeInsets.all(4),
      height: 160,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.4,
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix(<double>[
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: Image.asset(
                  'assets/images/how_to_play_party.png',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.25),
                ),
              ),
            ),
            Center(
              child: OtlBrutalistSurface(
                backgroundColor: BrutalistColors.lime,
                shadowOffset: 6,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text(
                  label,
                  style: DisplayTypography.rubikTitle(
                    color: Colors.black,
                    fontSize: 48,
                    height: 52 / 48,
                    letterSpacing: -0.96,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
