import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/services/app_review_prompt.dart';
import '../../shared/widgets/otl_review_prompt_dialog.dart';

/// Shows the review prompt on the final leaderboard, after the winner moment.
class FinalLeaderboardReviewGate extends StatefulWidget {
  const FinalLeaderboardReviewGate({
    required this.reviewPrompt,
    required this.child,
    this.delay = AppReviewPrompt.leaderboardDelay,
    super.key,
  });

  final AppReviewPrompt reviewPrompt;
  final Widget child;
  final Duration delay;

  @override
  State<FinalLeaderboardReviewGate> createState() =>
      _FinalLeaderboardReviewGateState();
}

class _FinalLeaderboardReviewGateState
    extends State<FinalLeaderboardReviewGate> {
  @override
  void initState() {
    super.initState();
    unawaited(_maybePrompt());
  }

  Future<void> _maybePrompt() async {
    await Future<void>.delayed(widget.delay);
    if (!mounted || !_isCurrentRoute) {
      return;
    }
    if (!widget.reviewPrompt.claimPresentation()) {
      return;
    }

    try {
      if (!await widget.reviewPrompt.shouldAsk()) {
        return;
      }
      if (!mounted || !_isCurrentRoute) {
        return;
      }

      final choice = await showOtlReviewPromptDialog(context);
      if (choice == null) {
        return;
      }
      await widget.reviewPrompt.recordChoice(choice);
    } finally {
      widget.reviewPrompt.releasePresentation();
    }
  }

  bool get _isCurrentRoute {
    final route = ModalRoute.of(context);
    return route == null || route.isCurrent;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
