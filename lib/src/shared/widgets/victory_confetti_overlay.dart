import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Full-screen confetti burst for victory / final leaderboard moments.
class VictoryConfettiOverlay extends StatefulWidget {
  const VictoryConfettiOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<VictoryConfettiOverlay> createState() => _VictoryConfettiOverlayState();
}

class _VictoryConfettiOverlayState extends State<VictoryConfettiOverlay> {
  late final ConfettiController _controller;

  static const _confettiColors = [
    BrutalistColors.lime,
    BrutalistColors.playerCardPink,
    BrutalistColors.playerCardYellow,
    Colors.white,
    Colors.black,
  ];

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 4));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: _confettiColors,
                numberOfParticles: 42,
                emissionFrequency: 0.04,
                maxBlastForce: 28,
                minBlastForce: 12,
                gravity: 0.12,
                particleDrag: 0.04,
                createParticlePath: _drawConfettiParticle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Path _drawConfettiParticle(Size size) {
    final path = Path();
    if (size.width > size.height) {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.6));
    } else {
      path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    }
    return path;
  }
}
