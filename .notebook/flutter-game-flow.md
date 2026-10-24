# Flutter Game Flow
> In-memory game flow with local content and preferences

Entry: `lib/src/app/app_router.dart`
Flow: home -> category -> match setup (guided/free) -> players -> reveal -> guided questions/free clues -> vote -> results -> guess/final

State owner: `lib/src/app/game_flow_controller.dart`
- Holds selected category, language, timer settings, match, round, result
- Content via `lib/src/data/content/local_content_repository.dart`
- Preferences via `lib/src/data/preferences/preferences_repository.dart`
- SessionRepository persists last group/settings and bounded PlayHistory in SharedPreferences (`game.session.v1`). Names stay local; scores reset. Failed writes do not block gameplay.
- RoundGenerationService excludes words used within the match and prioritizes unseen/oldest words and normalized question text across sessions, scoped by language/category. Exhausted content can repeat.
- Free mode generates no question turns; FreeClueScreen manages clue laps before voting. Guided remains the default.
- Content language is captured on category selection and remains stable if UI language changes.

US packs and monetization (2026-10-20):
- `assets/content/us_game_night.json`: 3 English packs x 20 words, each with 9 prompts. IDs: us_backyard, us_roadtrip, us_holidays; bundle: game_night_collection.
- Existing 180 words, both modes, history and saved group remain free.
- PacksController uses PurchaseGateway/RevenueCat confirmed entitlements; bundle grants all three packs. Controller rechecks access when starting a match.
- Native purchase SDK is inactive without platform REVENUECAT_IOS_API_KEY / REVENUECAT_ANDROID_API_KEY Dart defines. Current offering custom package IDs and entitlement IDs must match catalog IDs. Only non-subscription products are offered; prices come from the store.
- Discovery library: `CategorySelectionScreen` listens to the shared `PacksController`, combines free categories + confirmed owned packs under readyToPlay, and exposes onExplorePacks separately. English-only pack cards use English names and EN semantics in every UI locale; `_DiscoveryCategoriesRoute` passes contentLanguage=en for pack selection. Notifications during shop route build defer the library rebuild until after the frame.
- /packs route, app resume refresh, restore and pending/cancellation/error handling are implemented. Real store sandbox checks and product configuration remain required; see `docs/us-release-and-monetization.md`.
- Store setup completed 2026-10-20: RevenueCat project f5b63206, iOS app appc66499b426, current offering default/ofrnga6b5593221. Four matching entitlements each have one corresponding Apple non-consumable. Apple product IDs are otl_us_backyard, otl_us_roadtrip, otl_us_holidays ($1.99 each) and otl_game_night_collection ($3.99), initially USA only. Existing otl_pro_lifetime preserved.
- Public SDK key configuration: `.env`; simulator debug build with this file succeeded. No actual sandbox transaction verified yet. Review image upload is blocked by Chrome extension local-file permission; new US sandbox tester awaits user email/password entry. See `docs/sandbox-setup-status.md` for IDs, build commands and remaining checks.
- `test/features/category_selection_test.dart`: compact two-column cards, individual/bundle/revoked access, separate shop navigation and pack start from Portuguese UI.
- Tests: session_history_test, packs_controller_test, free_play_flow_test and multilingual/responsive neon_refined_layout_test. Preview catalog must be preloaded/injected to avoid asset-loading spinners.

Content: `assets/content/seed_content.json`
- Verified 2026-10-20: 6 categories x 30 words (180 words total).
- Localized values/questions for `pt-BR`, `en`, `es`, `hi`, `ar`.
- Tests: `test/fixtures/content_seed_test.dart`, `test/data/content/local_content_repository_test.dart`

Gotcha: category screen stores its content future in state
- See `lib/src/features/setup/category_selection_screen.dart`
- Recreating the future in `build()` can leave widget tests on the loading spinner with large assets

Competitive research checks (2026-10-20):
- `lib/src/domain/models/game_models.dart:MatchSetup` limits local play to 3–9 players and up to 5 rounds.
- Previous first-question selection was replaced by history-based rotation in the US gameplay implementation above.
- `lib/src/data/analytics/analytics_events.dart` includes match start, completion, cancellation and rematch events, useful for measuring activation and replay.
- Public App Store listing `https://apps.apple.com/au/app/imposter-spy-out-of-the-loop/id6771190067` (Gustavo Maes) describes 20+ players and one-word clues. Verify released build before reconciling this with the local guided-question flow.

Updated: 2026-10-20

First-use onboarding (2026-10-20):
- `PreferencesRepository.load()` restores `onboarding.completed`; missing/false selects `/onboarding` before the router is first built in `OutOfTheLoopApp._loadPreferences()`.
- `lib/src/features/onboarding/onboarding_screen.dart`: three localized neon steps, isolated practice card, back navigation and save retry. Completing or skipping persists before navigating; interrupted sessions remain eligible.
- `AppRouter._routes()`: completion goes to categories, initial skip to home. `HowToPlayScreen` pushes `/onboarding`; Skip always opens home (Play), including replay from rules.
- `lib/previews/neon_previews.dart`: interactive onboarding preview. `test/features/onboarding_test.dart`: first launch, restart, skip each step, replay/back, interrupted session, save retry, compact layouts at 2x text in all five languages.
- App/game integration tests use `setEnglishAppPreferences()` with `onboarding.completed=true` to represent returning players.

App Review / TestFlight investigation (2026-10-22):
- User reports Explore packs is absent in TestFlight, not merely disabled purchase buttons.
- Local `build/ios/ipa/outoftheloop.ipa` and `build/ios/archive/Runner.xcarchive` identify as 1.2.0 (6); archive CreationDate is 2026-10-20 02:52:32 UTC (Oct 19 23:52 America/Sao_Paulo), before the documented Oct 20 pack implementation.
- Inspected the IPA ZIP: `assets/content/us_game_night.json` is absent. Archived App.framework binary does not contain the configured RevenueCat public key. This local release artifact predates current monetization; uploaded binary identity has not been independently verified.
- Current `_DiscoveryCategoriesRoute.build()` always supplies onExplorePacks; `CategorySelectionScreen.build()` displays the entry regardless of locale/store availability. Missing store products alone do not hide this button.
- Next release must rebuild current intended sources with the RevenueCat defines and a new build number, then verify the exported IPA includes premium content and test actual purchases. Do not assume current Generated.xcconfig describes the old exported IPA.
