import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

/// No free-form parameters, IDs, exceptions, names or game content cross this API.
enum ClassicEvent {
  setupViewed,
  setupOptionChanged,
  roundStarted,
  roundSaved,
  roundUnsaved,
  persistenceFailed,
  discussionStarted,
  roundCompleted,
  replayStarted,
  roundEnded,
  gameResumed,
  shareRequested,
  shareCopied,
  shareCompleted,
  shareCancelled,
  feedbackOpened,
  reviewRequested,
  paywallOpened,
  paywallDismissed,
  planSelected,
  entitlementChanged,
  purchaseRequested,
  purchaseVerified,
  purchaseCancelled,
  purchasePending,
  purchaseFailed,
  restoreRequested,
  restoreFound,
  restoreEmpty,
  restoreFailed,
}

enum ClassicOption { players, categories, impostors, hint, timer, troll }

enum ClassicOrigin { home, categories, settings, result }

enum ClassicPlan { annual, weekly }

class ClassicAnalytics {
  ClassicAnalytics({this.sink});
  final Future<void> Function(String, Map<String, Object>)? sink;
  void record(
    ClassicEvent event, {
    ClassicOrigin? origin,
    ClassicPlan? plan,
    ClassicOption? option,
  }) {
    unawaited(
      _send(event, {
        if (origin != null) 'origin': origin.name,
        if (plan != null) 'plan': plan.name,
        if (option != null) 'option': option.name,
      }),
    );
  }

  Future<void> _send(ClassicEvent event, Map<String, Object> parameters) async {
    final name =
        'classic_${event.name.replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m[0]!.toLowerCase()}')}';
    try {
      if (sink != null) {
        await sink!(name, parameters);
      } else if (Firebase.apps.isNotEmpty) {
        await FirebaseAnalytics.instance.logEvent(
          name: name,
          parameters: parameters,
        );
      }
    } on Object {
      // Telemetry must neither block gameplay nor forward raw SDK exceptions.
    }
  }
}
