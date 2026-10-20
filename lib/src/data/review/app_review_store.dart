import 'package:shared_preferences/shared_preferences.dart';

/// Persists whether the player already rated the app, and when they last
/// declined the review prompt.
abstract interface class AppReviewStore {
  Future<bool> hasRated();

  Future<DateTime?> declinedAt();

  Future<void> markRated();

  Future<void> markDeclined(DateTime at);
}

final class SharedPreferencesAppReviewStore implements AppReviewStore {
  const SharedPreferencesAppReviewStore();

  static const ratedKey = 'review.rated';
  static const declinedAtKey = 'review.declinedAtMillis';

  @override
  Future<bool> hasRated() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(ratedKey) ?? false;
  }

  @override
  Future<DateTime?> declinedAt() async {
    final preferences = await SharedPreferences.getInstance();
    final millis = preferences.getInt(declinedAtKey);
    if (millis == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
  }

  @override
  Future<void> markRated() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(ratedKey, true);
  }

  @override
  Future<void> markDeclined(DateTime at) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(declinedAtKey, at.toUtc().millisecondsSinceEpoch);
  }
}
