import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

/// Opens the platform review sheet (App Store / Play Store).
abstract interface class StoreReviewGateway {
  Future<void> requestReview();
}

final class InAppStoreReviewGateway implements StoreReviewGateway {
  InAppStoreReviewGateway({InAppReview? review})
    : _review = review ?? InAppReview.instance;

  final InAppReview _review;

  @override
  Future<void> requestReview() async {
    if (await _review.isAvailable()) {
      await _review.requestReview();
      return;
    }

    // Play can still open the listing when the in-app sheet is unavailable
    // (sideload, or the device has no Play services). iOS needs a numeric
    // App Store id for the listing fallback, which this project does not have.
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _review.openStoreListing();
    }
  }
}
