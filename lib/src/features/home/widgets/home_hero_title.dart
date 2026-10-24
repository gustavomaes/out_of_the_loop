import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../home_screen.dart';

class HomeHeroTitle extends StatelessWidget {
  const HomeHeroTitle({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        HomeBrand.lineOne,
        style: DisplayTypography.rubikHomeTitle(
          color: BrutalistColors.cardText,
          fontSize: 38,
        ),
      ),
      Text(
        HomeBrand.lineTwo,
        style: DisplayTypography.rubikHomeTitle(
          color: BrutalistColors.lime,
          fontSize: 64,
        ),
      ),
    ],
  );
}
