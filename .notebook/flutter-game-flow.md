# Flutter Game Flow
> In-memory game flow with local content and preferences

Entry: `lib/src/app/out_of_the_loop_app.dart:_buildRoute()` (L55-152)
Flow: home -> category -> players -> reveal -> questions -> vote -> results -> guess/final

State owner: `lib/src/app/game_flow_controller.dart`
- Holds selected category, language, timer settings, match, round, result
- Content via `lib/src/data/content/local_content_repository.dart`
- Preferences via `lib/src/data/preferences/preferences_repository.dart`

Content: `assets/content/seed_content.json`
- Verified 2026-10-20: 6 categories x 30 words (180 words total).
- Localized values/questions for `pt-BR`, `en`, `es`, `hi`, `ar`.
- Tests: `test/fixtures/content_seed_test.dart`, `test/data/content/local_content_repository_test.dart`

Gotcha: category screen stores its content future in state
- See `lib/src/features/setup/category_selection_screen.dart`
- Recreating the future in `build()` can leave widget tests on the loading spinner with large assets

Competitive research checks (2026-10-20):
- `lib/src/domain/models/game_models.dart:MatchSetup` limits local play to 3–9 players and up to 5 rounds.
- `lib/src/domain/services/round_generation_service.dart:generateRound()` excludes words used within a match; questions use the first eligible entries. Cross-session content rotation is not provided by this service.
- `lib/src/data/analytics/analytics_events.dart` includes match start, completion, cancellation and rematch events, useful for measuring activation and replay.
- Public App Store listing `https://apps.apple.com/au/app/imposter-spy-out-of-the-loop/id6771190067` (Gustavo Maes) describes 20+ players and one-word clues. Verify released build before reconciling this with the local guided-question flow.

Updated: 2026-10-20
