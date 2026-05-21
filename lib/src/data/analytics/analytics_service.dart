import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../domain/models/models.dart';
import 'analytics_events.dart';

/// Wraps [FirebaseAnalytics] with typed helpers and safe no-ops when Firebase
/// is unavailable (e.g. widget tests).
class AnalyticsService {
  AnalyticsService({FirebaseAnalytics? analytics}) : _injected = analytics;

  final FirebaseAnalytics? _injected;
  FirebaseAnalytics? _client;

  bool get _isAvailable => Firebase.apps.isNotEmpty;

  FirebaseAnalytics? get _analytics {
    if (!_isAvailable) {
      return null;
    }
    return _client ??= _injected ?? FirebaseAnalytics.instance;
  }

  NavigatorObserver get routeObserver {
    final analytics = _analytics;
    if (analytics == null) {
      return _NoOpNavigatorObserver();
    }
    return FirebaseAnalyticsObserver(
      analytics: analytics,
      nameExtractor: (settings) {
        final name = settings.name;
        return name != null && name.isNotEmpty ? name : null;
      },
    );
  }

  Future<void> logSelectCategory({required String categoryId}) {
    return _logEvent(AnalyticsEvents.selectCategory, {
      AnalyticsEvents.categoryId: categoryId,
    });
  }

  Future<void> logConfigureMatch({
    required int roundCount,
    required int questionsPerPlayer,
  }) {
    return _logEvent(AnalyticsEvents.configureMatch, {
      AnalyticsEvents.roundCount: roundCount,
      AnalyticsEvents.questionsPerPlayer: questionsPerPlayer,
    });
  }

  Future<void> logStartMatch({
    required String categoryId,
    required SupportedLanguage language,
    required int playerCount,
    required int roundCount,
    required int questionsPerPlayer,
  }) {
    return _logEvent(AnalyticsEvents.startMatch, {
      AnalyticsEvents.categoryId: categoryId,
      AnalyticsEvents.language: language.code,
      AnalyticsEvents.playerCount: playerCount,
      AnalyticsEvents.roundCount: roundCount,
      AnalyticsEvents.questionsPerPlayer: questionsPerPlayer,
    });
  }

  Future<void> logCompleteVoting({required int playerCount}) {
    return _logEvent(AnalyticsEvents.completeVoting, {
      AnalyticsEvents.playerCount: playerCount,
    });
  }

  Future<void> logSubmitGuess({required bool guessCorrect}) {
    return _logEvent(AnalyticsEvents.submitGuess, {
      AnalyticsEvents.guessCorrect: guessCorrect,
    });
  }

  Future<void> logCompleteRound({
    required int roundNumber,
    required bool outFoundMajority,
    required bool? guessCorrect,
    required bool isMatchEnd,
  }) {
    final parameters = <String, Object>{
      AnalyticsEvents.roundNumber: roundNumber,
      AnalyticsEvents.outFoundMajority: outFoundMajority,
      AnalyticsEvents.isMatchEnd: isMatchEnd,
    };
    if (guessCorrect != null) {
      parameters[AnalyticsEvents.guessCorrect] = guessCorrect;
    }
    return _logEvent(AnalyticsEvents.completeRound, parameters);
  }

  Future<void> logCancelMatch({required int roundNumber}) {
    return _logEvent(AnalyticsEvents.cancelMatch, {
      AnalyticsEvents.roundNumber: roundNumber,
    });
  }

  Future<void> logMatchFinished({
    required String categoryId,
    required int playerCount,
    required int roundCount,
  }) {
    return _logEvent(AnalyticsEvents.matchFinished, {
      AnalyticsEvents.categoryId: categoryId,
      AnalyticsEvents.playerCount: playerCount,
      AnalyticsEvents.roundCount: roundCount,
    });
  }

  Future<void> logRematchStarted({required String rematchType}) {
    return _logEvent(AnalyticsEvents.rematchStarted, {
      AnalyticsEvents.rematchType: rematchType,
    });
  }

  Future<void> logChangeSetting({
    required String settingName,
    required String settingValue,
  }) {
    return _logEvent(AnalyticsEvents.changeSetting, {
      AnalyticsEvents.settingName: settingName,
      AnalyticsEvents.settingValue: settingValue,
    });
  }

  Future<void> _logEvent(
    String name,
    Map<String, Object> parameters,
  ) async {
    final analytics = _analytics;
    if (analytics == null) {
      return;
    }
    try {
      await analytics.logEvent(name: name, parameters: parameters);
    } on Object catch (error, stackTrace) {
      assert(() {
        debugPrint('Analytics logEvent failed: $error\n$stackTrace');
        return true;
      }());
    }
  }
}

final class _NoOpNavigatorObserver extends NavigatorObserver {}
