# Flutter Game Flow
> In-memory game flow with local content and preferences

Entry: `lib/src/app/out_of_the_loop_app.dart:_buildRoute()` (L55-152)
Flow: home -> category -> players -> reveal -> questions -> vote -> results -> guess/final

State owner: `lib/src/app/game_flow_controller.dart`
- Holds selected category, language, timer settings, match, round, result
- Content via `lib/src/data/content/local_content_repository.dart`
- Preferences via `lib/src/data/preferences/preferences_repository.dart`

Content: `assets/content/seed_content.json`
- 20 categories x 30 words
- Localized values/questions for `pt-BR`, `en`, `es`, `hi`
- Tests: `test/fixtures/content_seed_test.dart`, `test/data/content/local_content_repository_test.dart`

Gotcha: category screen stores its content future in state
- See `lib/src/features/setup/category_selection_screen.dart`
- Recreating the future in `build()` can leave widget tests on the loading spinner with large assets

Updated: 2026-05-18
