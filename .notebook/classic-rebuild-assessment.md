# Classic rebuild assessment
> Code inventory for the Premium subscription redesign

Entry: `lib/src/app/game_flow_controller.dart`; target: `docs/prd/PRD-reformulacao-ios-us.md` (v3).

- Stage 0 implemented on 2026-10-25: `docs/classic/BASELINE_STAGE_0.md` records the preserved Git reference, preferences/commercial inventory, reuse matrix, external gaps and reproducible build instructions. `tool/classic_baseline_inventory.py` generates asset hashes and localized counts. Full baseline: 152 tests passed, analysis exit 0 (two existing infos), unsigned iOS release build succeeded; generated plist confirms production Bundle ID and 1.2.1 (7). Store equivalence and commercial data remain unverified. See the report instead of duplicating its inventory here.

- User confirmed subscription PRD as evaluation baseline on 2026-10-25; historical v2 uses one-time purchases. No rebuild implemented by this investigation.
- `lib/src/domain/models/game_models.dart:MatchSetup` caps players at 9; `RoundState` has one `outPlayerId` and question/vote phases. Classic needs a new round model and flow.
- `lib/src/data/content/local_content_repository.dart:ContentSeed.fromJson()` requires question boundaries; `_wordFromJson()` requires questions. Word-only Classic needs a different schema/parser or conversion, not merely new JSON assets.
- `lib/src/data/session/session_repository.dart` stores names, settings and history under `game.session.v1`, not an active-round snapshot. Migration should preserve this data; active Classic snapshots are new functionality.
- `lib/src/data/purchases/purchase_gateway.dart:RevenueCatPurchaseGateway.load()` explicitly filters non-subscription products; `buy()` assumes package ID equals entitlement ID. Subscription integration must separate plan/package IDs from the shared Premium entitlement.
- `lib/src/features/packs/packs_controller.dart:owns()` recognizes individual packs and collection; no explicit lifetime mapping in lib. Audit external entitlement promises before release even though user reports zero sales.
- `android/app/build.gradle.kts` and `ios/Runner.xcodeproj/project.pbxproj`: production identifier `com.mathsquirrels.outoftheloop`. Native project recreation is not needed to replace Dart gameplay/UI.
- `prototypes/oddly/README.md`, `app.js`, `subscription-catalog.js`: Suslo visual/flow reference; billing and restore simulated. Catalog is samples, not the full launch library.
- Verification: `flutter test --no-pub test/domain test/data --reporter compact` passed 58 tests. No native build, StoreKit transaction, UI run or installed-version migration verified in this assessment.

Updated: 2026-10-25
