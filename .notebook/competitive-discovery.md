# PRD discovery — 2026-10-25

User requests a complete redesign/development PRD including screens, flows and ASO. Discovery must proceed one question at a time before drafting. No implementation requested.

## Verified baseline
- `lib/src/app/app_routes.dart` and `app_router.dart`: onboarding, home, categories, setup, players, secret reveal, ready, guided questions/free clues, voting, results, guess, final leaderboard, rules, settings, packs.
- `game_flow_controller.dart`: guided is the initial mode. `domain/models/game_models.dart:MatchSetup` limits players to 3–9.
- `domain/services/vote_scoring_service.dart`: strict majority finds imposter; correct voters receive 25, non-imposters receive 100 if majority succeeds, escaped imposter receives 50 and another 125 for a correct guess. Guess opportunity only after escaping majority.
- Existing notebook documents content, purchase integration and visual foundation; no need to duplicate those details.
- Public US listing retrieved through web still describes 20+ players and one-word clues. This differs from local player limit and default guided mode; deployed build was not verified. URL: https://apps.apple.com/us/app/imposter-spy-out-of-the-loop/id6771190067

## ScreensDesign competitor evidence
User explicitly requested ScreensDesign. App store ID 6746781192, library app 2516, replay 3355; 47 recorded screens. No conversation_id was supplied in either app_detail or describe response; do not invent one.
- Setup screen 291010: Classic/Online selector, players, categories, imposter count on a single main setup surface. Other settings include optional timer (1–10 minutes), imposter hint and Troll Mode.
- Recorded local round: reveal each player's word/role → conversation starter and timer (291049) → confirmation → reveal imposter and word (291053) → new game. No individual voting/scoreboard shown in this recorded flow; do not infer absence from every version.
- Online screen 291060: shareable link, external voice/video call suggestions, next round and moderator controls. This does not establish in-app voice or public matchmaking.
- Recorded onboarding has testimonials, permissions and a subscription offer with annual trial/weekly option; replay classified as soft paywall. Recording is evidence of a captured version, not a live installation.
- Comparison hypothesis: current app manages more of the social game through on-device turns and scoring. Competitor's recorded local flow delegates discussion to the group. Interview must determine desired direction before assuming simplification or feature parity.
- Screen evidence: https://screensdesign.com/apps/imposter-who-word-game/?vs=291010&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens
- Round evidence: https://screensdesign.com/apps/imposter-who-word-game/?av=3355&flow=46089&ts=101.000&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens
- App evidence: https://screensdesign.com/apps/imposter-who-word-game/?utm_source=screensdesign&utm_medium=mcp&utm_content=app_detail

Do not conclude causes of search ranking from UI or competitor revenue estimates. Need actual acquisition, conversion, retention, territories and storefront metadata during discovery.
