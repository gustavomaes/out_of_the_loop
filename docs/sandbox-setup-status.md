# App Store / RevenueCat setup — 2026-10-20

App: Imposter Spy: Out of the Loop, Apple ID 6771190067.
Bundle ID: `com.mathsquirrels.outoftheloop`.
RevenueCat project: `f5b63206`; iOS app: `appc66499b426`.

All four products were created as non-consumables in App Store Connect and RevenueCat. USA is the base country and the only initial availability territory. Family Sharing was not enabled. The existing `otl_pro_lifetime` product and the pending app review were preserved.

| Product | Apple product ID | Apple numeric ID | USD price | RevenueCat package and entitlement |
| --- | --- | --- | --- | --- |
| Backyard Hangout | `otl_us_backyard` | 6825054172 | 1.99 | `us_backyard` |
| Road Trip | `otl_us_roadtrip` | 6825054574 | 1.99 | `us_roadtrip` |
| Holiday Hangout | `otl_us_holidays` | 6825054754 | 1.99 | `us_holidays` |
| Game Night Collection | `otl_game_night_collection` | 6825055343 | 3.99 | `game_night_collection` |

RevenueCat current offering: `default` (US Game Night Packs). Each package maps to its matching Apple product, and each entitlement maps to that same product. The collection entitlement grants all three packs through `PacksController.owns()`.

Verified from the saved RevenueCat UI: four packages in the current offering and four entitlements with one product each. Verified from each Apple's Current Price dialog: USA $1.99/$1.99/$1.99/$3.99 respectively. Simulator debug build with `--dart-define-from-file=.env` succeeded. No purchase transaction has been executed.

The Apple In-App Purchase key L9NR637CM9 was reused with explicit user authorization. No private key was downloaded or added to the repository. No App Store Connect management API key was connected; products were created manually.

## Remaining before a verified sandbox purchase

- Apple products are in Prepare for Submission. Complete review screenshots and any validation Apple surfaces. The browser extension rejected local-file upload because file URL access is disabled. The real packs screenshot is available in the chat's us-release visualizations folder; no review submission was made.
- Both existing Sandbox Apple Accounts are Brazilian and were left unchanged. A new-account form has been prepared with United States selected; it awaits the user's controlled email, personal fields and direct password entry. No tester was created.
- Build/install on a development device or upload a new TestFlight build using the public iOS key configuration below. Simulator build success alone is not proof of an Apple sandbox purchase.
- Confirm all four offers appear; buy each individual pack using clean purchase history/test identities; confirm only its entitlement unlocks. Buy the collection using a clean identity and confirm all three packs unlock.
- Test cancellation, pending approval, restore, restart/offline access after purchase, and revoked rights. Inspect sandbox transactions and entitlements in this RevenueCat project.
- Apple's sandbox may take time to propagate metadata and can return inconsistent localized pricing. The app uses the actual SDK price string, not these documented prices.

```sh
flutter run --dart-define-from-file=.env.test
flutter build ipa --dart-define-from-file=.env
```

`.env` and `.env.test` contain only the **public iOS SDK key**. Never put Apple .p8 files or RevenueCat secret API keys in it. This is the App Store SDK key, not the RevenueCat Test Store key: Apple selects the transaction environment for the development/TestFlight build.

## Approved hybrid model

Existing categories retain their rewarded-ad access. New packs are permanent one-time unlocks. A rewarded-ad sample round for premium packs was approved as product direction but is not implemented by this store configuration. Do not represent that sample as already available.

Links:
- https://app.revenuecat.com/projects/f5b63206/product-catalog/offerings/ofrnga6b5593221
- https://appstoreconnect.apple.com/apps/6771190067/distribution/iaps
- https://www.revenuecat.com/docs/test-and-launch/sandbox/apple-app-store

Environment files are local and ignored by Git. Use `.env` for release builds and `.env.test` for development / Apple sandbox builds. Both currently contain the same public iOS SDK key; `.env.test` does not switch to the RevenueCat Test Store. Flutter reads these files through `--dart-define-from-file`, so no runtime dotenv dependency or bundled asset is needed.
