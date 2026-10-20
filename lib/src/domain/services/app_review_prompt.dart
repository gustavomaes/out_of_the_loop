import '../../data/review/app_review_store.dart';
import '../../data/review/store_review_gateway.dart';

enum ReviewPromptChoice { rate, later }

/// Decides when the post-match review prompt may appear again.
///
/// The happy path is the final leaderboard: the match is over and the winner
/// is on screen. A decline waits [declineCooldown] before the same screen may
/// ask again. Agreeing to rate stops the prompt.
final class AppReviewPrompt {
  AppReviewPrompt({
    AppReviewStore? store,
    StoreReviewGateway? gateway,
    DateTime Function()? now,
    this.cooldown = declineCooldown,
  }) : _store = store ?? const SharedPreferencesAppReviewStore(),
       _gateway = gateway ?? InAppStoreReviewGateway(),
       _now = now ?? DateTime.now;

  static const declineCooldown = Duration(days: 14);

  /// Leaves the winner card animation visible before the dialog covers it.
  static const leaderboardDelay = Duration(milliseconds: 1500);

  final AppReviewStore _store;
  final StoreReviewGateway _gateway;
  final DateTime Function() _now;
  final Duration cooldown;

  var _presentationClaimed = false;

  /// Prevents a second dialog if the final leaderboard rebuilds mid-prompt.
  bool claimPresentation() {
    if (_presentationClaimed) {
      return false;
    }
    _presentationClaimed = true;
    return true;
  }

  void releasePresentation() {
    _presentationClaimed = false;
  }

  Future<bool> shouldAsk() async {
    if (await _store.hasRated()) {
      return false;
    }

    final declinedAt = await _store.declinedAt();
    if (declinedAt == null) {
      return true;
    }

    return _now().difference(declinedAt) >= cooldown;
  }

  Future<void> recordChoice(ReviewPromptChoice choice) async {
    switch (choice) {
      case ReviewPromptChoice.rate:
        await _store.markRated();
        try {
          await _gateway.requestReview();
        } on Object {
          // The player already agreed. Keep that choice if the store sheet
          // cannot be shown (simulator, quota, or missing store install).
        }
      case ReviewPromptChoice.later:
        await _store.markDeclined(_now());
    }
  }
}
