import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Full-screen decorative glow layers for party/game screens.
///
/// Five named layouts mirror the former private `*Atmosphere` widgets (T08).
/// [OtlPartyAtmosphere.matchSetup] is shared by match and player setup.
class OtlPartyAtmosphere extends StatelessWidget {
  const OtlPartyAtmosphere.voting({super.key}) : _variant = _Variant.voting;

  const OtlPartyAtmosphere.questionRound({super.key})
    : _variant = _Variant.questionRound;

  const OtlPartyAtmosphere.secretReveal({super.key})
    : _variant = _Variant.secretReveal;

  const OtlPartyAtmosphere.matchSetup({super.key})
    : _variant = _Variant.matchSetup;

  final _Variant _variant;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: switch (_variant) {
        _Variant.voting => _buildVoting(),
        _Variant.questionRound => _buildQuestionRound(),
        _Variant.secretReveal => _buildSecretReveal(),
        _Variant.matchSetup => _buildMatchSetup(),
      },
    );
  }

  Widget _buildVoting() {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.2,
              colors: [
                BrutalistColors.votingAtmosphereAccent.withValues(alpha: 0.08),
                BrutalistColors.screenBackground,
              ],
            ),
          ),
        ),
        Positioned(
          left: -40,
          top: 120,
          child: _PartyGlow(
            color: BrutalistColors.playerCardPink,
            blurSigma: 48,
            opacity: 0.18,
            size: 140,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionRound() {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.2,
              colors: [
                BrutalistColors.playerCardPink.withValues(alpha: 0.08),
                BrutalistColors.screenBackground,
              ],
            ),
          ),
        ),
        Positioned(
          right: -40,
          top: 140,
          child: _PartyGlow(
            color: BrutalistColors.playerCardYellow,
            blurSigma: 48,
            opacity: 0.18,
            size: 140,
          ),
        ),
      ],
    );
  }

  Widget _buildSecretReveal() {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.1,
              colors: [
                BrutalistColors.lime.withValues(alpha: 0.12),
                BrutalistColors.screenBackground,
              ],
            ),
          ),
        ),
        Positioned(
          right: -48,
          top: 120,
          child: _PartyGlow(
            color: BrutalistColors.playerCardPink,
            blurSigma: 50,
            opacity: 0.2,
            size: 160,
          ),
        ),
        Positioned(
          left: -48,
          bottom: 160,
          child: _PartyGlow(
            color: BrutalistColors.lime,
            blurSigma: 50,
            opacity: 0.2,
            size: 160,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchSetup() {
    return Stack(
      children: [
        Positioned(
          right: -40,
          top: 96,
          child: _PartyGlow(
            color: BrutalistColors.playerCardPink,
            blurSigma: 50,
            opacity: 0.2,
            size: 160,
          ),
        ),
        Positioned(
          left: -40,
          bottom: 212,
          child: _PartyGlow(
            color: BrutalistColors.lime,
            blurSigma: 50,
            opacity: 0.2,
            size: 160,
          ),
        ),
      ],
    );
  }
}

enum _Variant { voting, questionRound, secretReveal, matchSetup }

class _PartyGlow extends StatelessWidget {
  const _PartyGlow({
    required this.color,
    required this.blurSigma,
    required this.opacity,
    required this.size,
  });

  final Color color;
  final double blurSigma;
  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
