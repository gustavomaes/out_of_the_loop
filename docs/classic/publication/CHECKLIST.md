# Submission checklist — blocked, not authorized for publication

Owner review is the final step after evidence is complete. Git push does not
submit a build. All boxes below require an evidence link, reviewer and date;
an unchecked item remains a blocker. See STAGE_8.md for priorities and physical QA.

- [ ] Close sandbox/product/legacy-rights gates from STAGE_6 and STAGE_8.
- [ ] Close privacy, preview, migration, offline and physical QA on signed candidate.
- [ ] Complete five-host/two-group usability protocol and resolve critical friction.
- [ ] Approve catalog, translations, brand and five-language accessibility review.
- [ ] Confirm existing App Store record and Bundle ID com.mathsquirrels.outoftheloop.
- [ ] Reconcile latest uploaded version/build with store; choose unique update numbers.
- [ ] Archive/export signed IPA; record source revision, Flutter/Xcode versions,
      commercial configuration reference (no keys), IPA SHA-256 and signing identity.
- [ ] Inspect exported Payload/Runner.app using tool/classic_rc_check.py; attach output.
- [ ] Upload/install matching TestFlight candidate; test distribution, restore,
      support/terms/privacy/management links and prices on that candidate.
- [ ] Confirm privacy declarations for Firebase/RevenueCat and any required privacy
      manifests, age rating, content rights/Twemoji attribution and export compliance.
- [ ] Complete METADATA_en-US.md links and review all intended store localizations.
- [ ] Capture final iPhone/iPad screenshots from identified candidate, dimensions
      accepted by current App Store Connect; include free gameplay and identify
      Premium content. Real captures only; no secrets or participant names.
- [ ] Replace screenshot evidence manifest with final build/hash/device/locale records.
- [ ] Complete REVIEW_NOTES.md and subscription review assets/products for submission.
- [ ] Assign release/hotfix/support owners and record monitoring access/baseline.
- [ ] Owner reviews concrete IPA, metadata, screenshots and evidence; records approval.
- [ ] Obtain separate explicit publication authorization; select release mode in store.

After authorized release: record actual launch timestamp/timezone, version/build,
store availability and rollout state in reports; schedule D7/D14/D30 from actual
launch, not from this document's date. No automation is created by this checklist.

Apple references checked 2026-10-25:
[submission](https://developer.apple.com/app-store/submitting/),
[review guidelines](https://developer.apple.com/app-store/review/guidelines/),
[privacy details](https://developer.apple.com/app-store/app-privacy-details/),
[screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications).
The checklist supports preparation; it does not certify Apple approval.
