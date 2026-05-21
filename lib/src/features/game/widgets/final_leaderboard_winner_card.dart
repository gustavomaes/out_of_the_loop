import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../shared/widgets/otl_brutalist_shadow_card.dart';
import '../../../shared/widgets/player_avatar.dart';
import '../../../theme/theme.dart';

class FinalLeaderboardWinnerCard extends StatefulWidget {
  const FinalLeaderboardWinnerCard({
    required this.winner,
    required this.winsLabel,
    required this.mastermindLabel,
    super.key,
  });

  final Player winner;
  final String winsLabel;
  final String mastermindLabel;

  @override
  State<FinalLeaderboardWinnerCard> createState() =>
      _FinalLeaderboardWinnerCardState();
}

class _FinalLeaderboardWinnerCardState extends State<FinalLeaderboardWinnerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _avatarScale;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _avatarScale = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.55, curve: Curves.elasticOut),
      ),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 1, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.35, 1, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OtlBrutalistShadowCard(
      color: BrutalistColors.lime,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(left: 12, top: 12, child: _DecorativeStar(size: 40)),
          const Positioned(
            right: 12,
            top: 12,
            child: _DecorativeStar(size: 32, opacity: 0.25),
          ),
          const Positioned(
            right: 16,
            bottom: 12,
            child: Opacity(
              opacity: 0.55,
              child: Icon(
                Icons.emoji_events,
                color: BrutalistColors.playerCardYellow,
                size: 52,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 240),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _avatarScale,
                      child: _WinnerAvatar(winner: widget.winner),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _textOpacity,
                      child: SlideTransition(
                        position: _textSlide,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.winsLabel,
                              style: DisplayTypography.rubikResultsWinnerTitle(
                                color: BrutalistColors.limeText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                child: Text(
                                  widget.mastermindLabel,
                                  style:
                                      DisplayTypography.spaceGroteskResultsBadge(
                                        color: BrutalistColors.lime,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WinnerAvatar extends StatelessWidget {
  const _WinnerAvatar({required this.winner});

  final Player winner;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: BrutalistColors.cardBackground,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: BrutalistColors.playerCardPink,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: PlayerAvatar(
                name: winner.name,
                seed: winner.avatarSeed,
                size: 96,
              ),
            ),
          ),
        ),
        Positioned(
          top: -14,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: BrutalistColors.playerCardYellow,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.emoji_events, color: Colors.black, size: 22),
            ),
          ),
        ),
      ],
    );
  }
}

class _DecorativeStar extends StatelessWidget {
  const _DecorativeStar({required this.size, this.opacity = 0.35});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Icon(
        Icons.star_rounded,
        color: BrutalistColors.resultsWinnerStar,
        size: size,
      ),
    );
  }
}
