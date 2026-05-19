# Out of the Loop MVP Tasks

**Spec**: `.specs/features/out-of-the-loop-mvp/spec.md`
**Design**: `.specs/features/out-of-the-loop-mvp/design.md` (planned as T01)
**Status**: Phase 5 complete

---

## Planning Assumptions

- The repository is currently a minimal Flutter app with `flutter`, `flutter_test`, and `flutter_lints`.
- `.specs/codebase/TESTING.md` does not exist yet. T02 creates the official test matrix before implementation.
- Until T02 is approved, this plan assumes:
  - Logic/data layers use unit tests with `flutter test`.
  - Widgets/screens use widget tests with `flutter test`.
  - Full gates use `flutter analyze && flutter test`.
  - Dependency/config changes use `flutter pub get && flutter analyze`.
- Tasks marked `[P]` can run in parallel after their dependencies are complete and should be delegated to separate sub-agents during Execute.
- Tests are co-located in the same task that creates or changes the code layer.

---

## Execution Plan

### Phase 0: Planning Gates

Create the design and test guardrails before code work starts.

```text
T01 [P]
T02 [P]
  \   /
   T03
```

### Phase 1: Foundation

Prepare dependencies, project structure, theme, shared primitives, domain models, local content, and localization.

```text
T03 -> T04

T04 -> T05 [P] -> T09
T04 -> T06 [P] -> T07 [P] -> T12
T04 -> T08 [P]

T05 -> T10 [P]
T05 + T08 -> T11
```

### Phase 2: Core Game Logic

Build rules and state transitions independently before UI wiring.

```text
T06 + T12 -> T13 [P]
T06 + T12 -> T14 [P]
T06       -> T15 [P]
T06       -> T16 [P]

T13 + T14 + T15 + T16 -> T17
```

### Phase 3: Screen Components

Build screens as isolated widgets. Route wiring happens later in T28.

```text
T09 + T11 -> T18 [P]
T09 + T11 -> T19 [P]
T09 + T11 + T12 -> T20 [P]
T09 + T11 + T13 -> T21 [P]
T09 + T11 + T14 -> T22 [P]
T09 + T10 + T11 + T14 -> T23 [P]
T09 + T10 + T11 + T15 -> T24 [P]
T09 + T11 + T15 + T17 -> T25 [P]
T09 + T11 + T17 -> T26 [P]
T09 + T11 + T08 -> T27 [P]
```

### Phase 4: Integration And MVP Validation

Wire the full game loop, verify the vertical slice, and run final design checks.

```text
T18..T27 + T17 -> T28
T28 -> T29 [P]
T28 -> T30 [P]
T28 -> T31 [P]
T29 + T30 + T31 -> T32
```

### Phase 5: P2/P3 Enhancements

Can start after the MVP path is stable. These are parallel where they avoid shared files.

```text
T28 -> T33 [P]
T28 -> T34 [P]
T28 -> T35 [P]
T33 + T34 + T35 -> T36
```

---

## Task Breakdown

### T01: Create Feature Design Document [P]

**What**: Create the architecture design for the MVP, including layers, navigation flow, data models, Figma frame mapping, and how `.agents/DESIGN.md` maps into Flutter.
**Where**: `.specs/features/out-of-the-loop-mvp/design.md`
**Depends on**: None
**Reuses**: `.specs/features/out-of-the-loop-mvp/spec.md`, `.agents/DESIGN.md`, Figma nodes listed in the spec
**Requirement**: OTL-01, OTL-02, OTL-03, OTL-04, OTL-05, OTL-06, OTL-07, OTL-08, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for `get_design_context` on relevant frames
- Skill: `tlc-spec-driven`

**Done when**:

- [x] `design.md` defines app layers, navigation/state ownership, services, repositories, and UI component strategy.
- [x] `design.md` records Figma-to-screen mapping for Home, categories, players, secret reveal, question, vote, results, how-to, and settings.
- [x] `design.md` records design divergences between Figma and `.agents/DESIGN.md`.
- [x] `design.md` defines data models before implementation.

**Tests**: none
**Gate**: docs review
**Verify**: Read `design.md` and confirm every P1 requirement has an implementation path.

---

### T02: Create Test Coverage Matrix [P]

**What**: Define the official test strategy, gate commands, and parallelism rules for this Flutter project.
**Where**: `.specs/codebase/TESTING.md`
**Depends on**: None
**Reuses**: `pubspec.yaml`, `analysis_options.yaml`, Flutter default testing conventions
**Requirement**: OTL-01 to OTL-13

**Tools**:

- MCP: NONE
- Skill: `tlc-spec-driven`

**Done when**:

- [x] `TESTING.md` lists code layers and required test types.
- [x] `TESTING.md` defines quick, build, and full gate commands.
- [x] `TESTING.md` identifies which tests are parallel-safe.
- [x] Future tasks can cite a concrete test type and gate from the matrix.

**Tests**: none
**Gate**: docs review
**Verify**: Read `TESTING.md` and confirm all task test assumptions are either accepted or updated.

---

### T03: Configure Flutter Dependencies And Assets

**What**: Add required packages and asset/font declarations selected by `design.md` for local data, localization, and design system assets.
**Where**: `pubspec.yaml`, asset/font directories as defined by `design.md`
**Depends on**: T01, T02
**Reuses**: Flutter SDK, current `pubspec.yaml`
**Requirement**: OTL-08, OTL-10, OTL-12

**Tools**:

- MCP: NONE
- Skill: use Flutter/Dart MCP tools if available

**Done when**:

- [x] Required dependencies are added through Flutter/Dart tooling.
- [x] Fonts/assets needed by `.agents/DESIGN.md` are declared.
- [x] Localization generation config is prepared if selected by design.
- [x] Gate check passes: `flutter pub get && flutter analyze`.

**Tests**: none
**Gate**: build
**Verify**: `flutter pub get && flutter analyze` exits successfully.

---

### T04: Create Project Structure

**What**: Create the feature-oriented Flutter directory structure for app, theme, domain, data, l10n, shared widgets, and screens.
**Where**: `lib/src/**`, `test/**`
**Depends on**: T03
**Reuses**: Existing `lib/main.dart`
**Requirement**: OTL-01 to OTL-13

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] `lib/main.dart` points to the new app entrypoint without changing behavior beyond app bootstrapping.
- [x] Empty directories or placeholder files establish the agreed structure.
- [x] Imports compile.
- [x] Gate check passes: `flutter analyze`.

**Tests**: none
**Gate**: build
**Verify**: `flutter analyze` exits successfully.

---

### T05: Implement Design Tokens Theme [P]

**What**: Convert `.agents/DESIGN.md` tokens into Flutter theme constants and text styles.
**Where**: `lib/src/theme/**`
**Depends on**: T04
**Reuses**: `.agents/DESIGN.md`
**Requirement**: OTL-10

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Color, typography, spacing, radius, shadow, and animation tokens exist in Flutter code.
- [x] Theme prevents white backgrounds by default.
- [x] Token tests verify representative values.
- [x] Gate check passes: `flutter test test/theme`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/theme` passes.

---

### T06: Define Domain Models [P]

**What**: Create immutable models/enums for player, category, secret word, question, role, vote, round, match, score event, language, and timer settings.
**Where**: `lib/src/domain/models/**`
**Depends on**: T04
**Reuses**: Data shape from `spec.md`
**Requirement**: OTL-01, OTL-02, OTL-03, OTL-04, OTL-05, OTL-06, OTL-07, OTL-08, OTL-11, OTL-12, OTL-13

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Models cover all gameplay states and content fields.
- [x] Boundaries for 3 to 9 players are representable.
- [x] Model tests cover equality/value behavior and simple constructors.
- [x] Gate check passes: `flutter test test/domain/models`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/domain/models` passes.

---

### T07: Create Local Content Seed [P]

**What**: Add an initial local content seed format with categories, words, and questions for development and tests.
**Where**: `assets/content/**`, `test/fixtures/**`
**Depends on**: T06
**Reuses**: `word`, `category`, `questions` data shape from the PRD
**Requirement**: OTL-08, OTL-12

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Seed content has at least enough data to run a 3-player test round.
- [x] Content schema supports future expansion to 20 categories x 30 words x 4 languages.
- [x] Fixture validation test rejects words with fewer questions than required.
- [x] Gate check passes: `flutter test test/fixtures`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/fixtures` passes.

---

### T08: Configure Localization Scaffold [P]

**What**: Add localization scaffold for `pt-BR`, `en`, `es`, and `hi`, including runtime locale switching contract.
**Where**: `lib/src/l10n/**`, `l10n.yaml`, `lib/l10n/**` or design-selected path
**Depends on**: T04
**Reuses**: Flutter localization support selected in T03
**Requirement**: OTL-12

**Tools**:

- MCP: NONE
- Skill: `flutter-setup-localization` if execution needs localization setup

**Done when**:

- [x] Supported locales are declared.
- [x] Fallback to `pt-BR` is represented.
- [x] Core UI strings exist for the MVP flow.
- [x] Localization tests verify supported locale list and fallback behavior.
- [x] Gate check passes: `flutter test test/l10n`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/l10n` passes.

---

### T09: Build Shared UI Primitives

**What**: Create reusable button, card, input, player avatar, and layout primitives based on design tokens.
**Where**: `lib/src/shared/widgets/**`
**Depends on**: T05
**Reuses**: `lib/src/theme/**`, `.agents/DESIGN.md`
**Requirement**: OTL-10

**Tools**:

- MCP: NONE
- Skill: `flutter-add-widget-preview` optional during execution

**Done when**:

- [x] Primary, secondary, and outline buttons support disabled/focus/pressed states.
- [x] Card/input/avatar primitives match tokenized styling.
- [x] Widget tests cover disabled button and minimum touch target behavior.
- [x] Gate check passes: `flutter test test/shared/widgets`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/shared/widgets` passes.

---

### T10: Build Timer Widgets [P]

**What**: Create circular timer and progress bar timer widgets for question and voting screens.
**Where**: `lib/src/shared/widgets/timers/**`
**Depends on**: T05
**Reuses**: `lib/src/theme/**`
**Requirement**: OTL-03, OTL-10, OTL-11

**Tools**:

- MCP: NONE
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Circular timer renders countdown display.
- [x] Progress timer renders proportional progress.
- [x] Warning state appears for final 5 seconds.
- [x] Widget tests cover normal and warning states.
- [x] Gate check passes: `flutter test test/shared/widgets/timers`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/shared/widgets/timers` passes.

---

### T11: Build App Shell And Navigation Contract

**What**: Create app shell, route names, navigation contract, and bottom navigation shell for non-game screens.
**Where**: `lib/src/app/**`
**Depends on**: T05, T08
**Reuses**: `lib/main.dart`, shared design tokens
**Requirement**: OTL-01, OTL-09, OTL-10, OTL-12

**Tools**:

- MCP: NONE
- Skill: `flutter-setup-declarative-routing` only if design chooses `go_router`

**Done when**:

- [x] App starts through the new shell.
- [x] Route names exist for all MVP screens.
- [x] Bottom navigation shell exists for discovery/configuration screens only.
- [x] Shell widget test verifies app boot and initial route.
- [x] Gate check passes: `flutter test test/app`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/app` passes.

---

### T12: Implement Local Content Repository

**What**: Load localized categories, words, and questions from local storage using the adapter selected in `design.md`.
**Where**: `lib/src/data/content/**`
**Depends on**: T07, T08
**Reuses**: Domain models, content fixtures
**Requirement**: OTL-08, OTL-12

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Repository lists categories for a locale.
- [x] Repository returns words/questions by category and locale.
- [x] Repository works with no network.
- [x] Unit tests cover valid content and missing/invalid content.
- [x] Gate check passes: `flutter test test/data/content`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/data/content` passes.

---

### T13: Implement Match Setup Validation [P]

**What**: Create validation logic for player names, player count, round count, and category availability.
**Where**: `lib/src/domain/services/match_setup_service.dart`
**Depends on**: T06, T12
**Reuses**: Domain models, content repository contract
**Requirement**: OTL-01, OTL-08

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Start is allowed only for 3 to 9 valid unique names.
- [x] Empty and duplicate names are rejected.
- [x] Round count is validated against category content capacity.
- [x] Unit tests cover 2, 3, 9, and 10 player cases.
- [x] Gate check passes: `flutter test test/domain/services/match_setup_service_test.dart`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/domain/services/match_setup_service_test.dart` passes.

---

### T14: Implement Round Generation Service [P]

**What**: Create logic to choose the out player, choose a non-repeated secret word, and select enough questions for the round.
**Where**: `lib/src/domain/services/round_generation_service.dart`
**Depends on**: T06, T12
**Reuses**: Domain models, content repository contract
**Requirement**: OTL-02, OTL-03, OTL-07, OTL-08

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Exactly one player is marked out per round.
- [x] Used words are not repeated in the same match.
- [x] Words with too few questions are skipped for the current player count.
- [x] Unit tests cover repeat prevention and question count.
- [x] Gate check passes: `flutter test test/domain/services/round_generation_service_test.dart`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/domain/services/round_generation_service_test.dart` passes.

---

### T15: Implement Vote And Scoring Service [P]

**What**: Create vote recording, majority detection, round result, and scoring rules.
**Where**: `lib/src/domain/services/vote_scoring_service.dart`
**Depends on**: T06
**Reuses**: Domain models
**Requirement**: OTL-04, OTL-05, OTL-06

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Each player can vote once.
- [x] Majority is calculated as more than half.
- [x] Inside players receive +25 for correct votes.
- [x] Inside players receive +100 when majority finds the out player.
- [x] Out player receives +50 when not found and +125 when guess is correct.
- [x] Unit tests cover majority, no-majority, tie, correct guess, and wrong guess cases.
- [x] Gate check passes: `flutter test test/domain/services/vote_scoring_service_test.dart`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/domain/services/vote_scoring_service_test.dart` passes.

---

### T16: Implement Timer State Service [P]

**What**: Create timer configuration and countdown state logic without UI.
**Where**: `lib/src/domain/services/timer_service.dart`
**Depends on**: T06
**Reuses**: Timer settings model
**Requirement**: OTL-03, OTL-11, OTL-13

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Default duration is 30 seconds.
- [x] Timer can be enabled/disabled and configured.
- [x] Expiration does not auto-record a vote.
- [x] Unit tests cover default, configured, and expired states.
- [x] Gate check passes: `flutter test test/domain/services/timer_service_test.dart`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/domain/services/timer_service_test.dart` passes.

---

### T17: Implement Match Progression Service

**What**: Create match-level state transitions across rounds, final ranking, and next-round setup.
**Where**: `lib/src/domain/services/match_progression_service.dart`
**Depends on**: T13, T14, T15, T16
**Reuses**: Domain models and game services
**Requirement**: OTL-07, OTL-05, OTL-06

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Round completion updates total scores.
- [x] Next round carries players and used words forward.
- [x] Final round produces ranking.
- [x] Unit tests cover 2-round completion and final ranking.
- [x] Gate check passes: `flutter test test/domain/services/match_progression_service_test.dart`.

**Tests**: unit
**Gate**: quick
**Verify**: `flutter test test/domain/services/match_progression_service_test.dart` passes.

---

### T18: Build Home Screen [P]

**What**: Build the Home screen matching Figma `Home` and the design system.
**Where**: `lib/src/features/home/home_screen.dart`
**Depends on**: T09, T11
**Reuses**: App shell, shared buttons, theme tokens
**Requirement**: OTL-01, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for node `2:2` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Screen shows `OUT OF THE LOOP`, `START GAME`, and `HOW TO PLAY`.
- [x] Bottom navigation state matches discovery screen behavior.
- [x] Widget test verifies primary actions are present.
- [x] Gate check passes: `flutter test test/features/home`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/home` passes.

---

### T19: Build How To Play Screen [P]

**What**: Build the rules screen with objective, roles, questions, voting, majority, guessing, and scoring.
**Where**: `lib/src/features/how_to_play/how_to_play_screen.dart`
**Depends on**: T09, T11
**Reuses**: Shared cards, theme tokens, localization strings
**Requirement**: OTL-09, OTL-10, OTL-12

**Tools**:

- MCP: `plugin-figma-figma` for node `2:441` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Four-section rule layout is implemented.
- [x] Majority is explained as more than half.
- [x] Back/understood action returns to the previous/home screen.
- [x] Widget test verifies rule sections and navigation action.
- [x] Gate check passes: `flutter test test/features/how_to_play`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/how_to_play` passes.

---

### T20: Build Category Selection Screen [P]

**What**: Build category grid/bento UI and category selection state.
**Where**: `lib/src/features/setup/category_selection_screen.dart`
**Depends on**: T09, T11, T12
**Reuses**: Shared cards, content repository, app shell
**Requirement**: OTL-01, OTL-08, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for node `2:50` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Categories render from local repository.
- [x] Selected category state is visually distinct.
- [x] Continue/play action is disabled until a category is selected.
- [x] Widget test verifies category render and selection.
- [x] Gate check passes: `flutter test test/features/setup`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/setup` passes.

---

### T21: Build Player Setup Screen [P]

**What**: Build player name entry, player list, validation messages, and start action state.
**Where**: `lib/src/features/setup/player_setup_screen.dart`
**Depends on**: T09, T11, T13
**Reuses**: Shared input/button/avatar widgets, setup validation service
**Requirement**: OTL-01, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for node `2:131` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Names can be added and displayed.
- [x] Start is disabled below 3 players and above invalid state.
- [x] Empty, duplicate, and tenth player attempts show validation feedback.
- [x] Widget test covers 2-to-3 player enablement.
- [x] Gate check passes: `flutter test test/features/setup`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/setup` passes.

---

### T22: Build Secret Reveal Screen [P]

**What**: Build the pass-and-reveal flow for each player, preserving the secret.
**Where**: `lib/src/features/game/secret_reveal_screen.dart`
**Depends on**: T09, T11, T14
**Reuses**: Round model, shared buttons/cards
**Requirement**: OTL-02, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for node `2:196` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Screen first shows player name and reveal action.
- [x] Inside player sees the word only after reveal.
- [x] Out player sees only the out-of-loop message.
- [x] Next player flow hides previous result.
- [x] Widget test verifies secret is hidden before reveal and hidden again after advancing.
- [x] Gate check passes: `flutter test test/features/game`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/game` passes.

---

### T23: Build Question Round Screen [P]

**What**: Build question display, assigned responder, optional circular timer, and done-answering action.
**Where**: `lib/src/features/game/question_round_screen.dart`
**Depends on**: T09, T10, T11, T14
**Reuses**: Timer widgets, round model
**Requirement**: OTL-03, OTL-10, OTL-11

**Tools**:

- MCP: `plugin-figma-figma` for node `2:225` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] One question is shown at a time.
- [x] Assigned player name is visible.
- [x] Number of questions equals player count.
- [x] Done action advances through questions and then proceeds to voting.
- [x] Widget test covers multi-question progression.
- [x] Gate check passes: `flutter test test/features/game`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/game` passes.

---

### T24: Build Voting Screen [P]

**What**: Build secret vote collection UI with player cards, progress timer, and confirm behavior.
**Where**: `lib/src/features/game/voting_screen.dart`
**Depends on**: T09, T10, T11, T15
**Reuses**: Vote/scoring service, timer widgets, player card widgets
**Requirement**: OTL-04, OTL-10, OTL-11

**Tools**:

- MCP: `plugin-figma-figma` for node `2:264` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Each voter gets one turn.
- [x] Vote choices are hidden before next voter.
- [x] Confirmation is enabled only when the active voter selected a candidate or all votes are collected as designed.
- [x] Widget test verifies each player can vote once and prior choices are hidden.
- [x] Gate check passes: `flutter test test/features/game`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/game` passes.

---

### T25: Build Round Results And Guess Screen [P]

**What**: Build round result display plus conditional out-player guessing flow.
**Where**: `lib/src/features/game/round_results_screen.dart`, `lib/src/features/game/guess_screen.dart`
**Depends on**: T09, T11, T15, T17
**Reuses**: Vote/scoring service, match progression service
**Requirement**: OTL-05, OTL-06, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for node `2:338` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Results reveal the out player and vote totals.
- [x] Round points are shown per player.
- [x] Guess screen appears only when out player was not found by majority.
- [x] `Acertou` grants +125 and `Errou` does not.
- [x] Widget tests cover discovered and not-discovered branches.
- [x] Gate check passes: `flutter test test/features/game`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/game` passes.

---

### T26: Build Final Leaderboard Screen [P]

**What**: Build final ranking screen with replay and back-to-home actions.
**Where**: `lib/src/features/game/final_leaderboard_screen.dart`
**Depends on**: T09, T11, T17
**Reuses**: Shared leaderboard/card widgets, match progression service
**Requirement**: OTL-07, OTL-10

**Tools**:

- MCP: `plugin-figma-figma` for node `2:338` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Players are sorted by total score.
- [x] Winner is visually highlighted.
- [x] `Nova partida` and `Voltar ao inicio` actions exist.
- [x] Widget test verifies ranking order and actions.
- [x] Gate check passes: `flutter test test/features/game`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/game` passes.

---

### T27: Build Settings Screen [P]

**What**: Build settings UI for language and timer preferences, excluding account/profile features.
**Where**: `lib/src/features/settings/settings_screen.dart`
**Depends on**: T09, T11, T08
**Reuses**: Shared widgets, localization scaffold
**Requirement**: OTL-11, OTL-12, OTL-13

**Tools**:

- MCP: `plugin-figma-figma` for node `2:545` if visual details are needed
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Supported languages are selectable.
- [x] Timer configuration UI is present.
- [x] Profile/login/Pro purchase are not implemented in MVP.
- [x] Widget test verifies language options and timer control render.
- [x] Gate check passes: `flutter test test/features/settings`.

**Tests**: widget
**Gate**: quick
**Verify**: `flutter test test/features/settings` passes.

---

### T28: Wire Complete MVP Navigation And State

**What**: Connect setup, gameplay, results, next-round, final-ranking, how-to, and settings screens into a playable in-memory app flow.
**Where**: `lib/src/app/**`, feature route wiring files
**Depends on**: T17, T18, T19, T20, T21, T22, T23, T24, T25, T26, T27
**Reuses**: App shell, screens, services
**Requirement**: OTL-01, OTL-02, OTL-03, OTL-04, OTL-05, OTL-06, OTL-07, OTL-09, OTL-10, OTL-11, OTL-12

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] User can navigate from Home to setup to gameplay.
- [x] Round phases advance in the required order.
- [x] Next round and final leaderboard routing works.
- [x] How-to and settings are reachable as designed.
- [x] App-level widget test completes one 3-player round.
- [x] Gate check passes: `flutter test test/app`.

**Tests**: widget
**Gate**: full
**Verify**: `flutter analyze && flutter test test/app` passes.

---

### T29: Add Full Vertical Slice Widget Test [P]

**What**: Add a complete 3-player MVP flow test from app launch through one round result.
**Where**: `test/app/out_of_the_loop_vertical_slice_test.dart`
**Depends on**: T28
**Reuses**: Existing app wiring and fixtures
**Requirement**: OTL-01 to OTL-10

**Tools**:

- MCP: NONE
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Test starts at Home.
- [x] Test configures category and 3 players.
- [x] Test reveals roles, completes questions, votes, and sees result.
- [x] Test asserts out player secrecy before reveal.
- [x] Gate check passes: `flutter test test/app/out_of_the_loop_vertical_slice_test.dart`.

**Tests**: widget
**Gate**: full
**Verify**: `flutter test test/app/out_of_the_loop_vertical_slice_test.dart` passes.

---

### T30: Run Design System And Figma Audit [P]

**What**: Validate MVP screens against `.agents/DESIGN.md` and the main Figma frames.
**Where**: `.specs/features/out-of-the-loop-mvp/validation.md` or `tasks.md` execution notes
**Depends on**: T28
**Reuses**: `.agents/DESIGN.md`, Figma nodes in `spec.md`
**Requirement**: OTL-10

**Tools**:

- MCP: `plugin-figma-figma`
- Skill: NONE

**Done when**:

- [x] Home, category, player setup, reveal, question, vote, results, how-to, and settings are reviewed.
- [x] Differences from `.agents/DESIGN.md` are fixed or documented.
- [x] Touch target and contrast rules are checked.
- [x] Gate check passes: `flutter analyze`.

**Tests**: manual visual review plus analyze
**Gate**: full
**Verify**: `flutter analyze` passes and audit notes list no blocking visual issues.

---

### T31: Run Offline And No-Login Validation [P]

**What**: Verify the app path does not require login, network, or remote services.
**Where**: `test/app/offline_mode_test.dart`
**Depends on**: T28
**Reuses**: Content repository, app wiring
**Requirement**: OTL-08, OTL-01

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Test confirms no login/account screen blocks gameplay.
- [x] Test uses local fixture/content repository only.
- [x] Test verifies a 3-player round can start offline.
- [x] Gate check passes: `flutter test test/app/offline_mode_test.dart`.

**Tests**: widget
**Gate**: full
**Verify**: `flutter test test/app/offline_mode_test.dart` passes.

---

### T32: Final MVP Gate

**What**: Run final static analysis and test suite for the P1 MVP.
**Where**: Whole repository
**Depends on**: T29, T30, T31
**Reuses**: All implemented tasks
**Requirement**: OTL-01 to OTL-10

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] `flutter analyze` passes.
- [x] `flutter test` passes.
- [x] `tasks.md` task statuses are updated.
- [x] Any spec deviations are documented.

**Tests**: full suite
**Gate**: full
**Verify**: `flutter analyze && flutter test` passes.

---

### T33: Complete Content And Localization Expansion [P]

**What**: Expand local content and localized strings toward the full PRD requirement.
**Where**: `assets/content/**`, localization files
**Depends on**: T28
**Reuses**: T07, T08, T12
**Requirement**: OTL-08, OTL-12

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Content structure supports 20 categories and 30 words per category.
- [x] Localization files cover UI text for `pt-BR`, `en`, `es`, and `hi`.
- [x] Validation tests catch missing localized categories/words/questions.
- [x] Gate check passes: `flutter test test/data/content test/l10n`.

**Tests**: unit
**Gate**: full
**Verify**: `flutter test test/data/content test/l10n` passes.

---

### T34: Persist Local Preferences [P]

**What**: Persist language and timer preferences locally and restore them on app restart.
**Where**: `lib/src/data/preferences/**`, `lib/src/features/settings/**`
**Depends on**: T28
**Reuses**: Settings screen, timer service, localization scaffold
**Requirement**: OTL-13, OTL-11, OTL-12

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] Selected language is persisted locally.
- [x] Timer preference is persisted locally.
- [x] App startup restores saved values.
- [x] Tests cover save/restore behavior.
- [x] Gate check passes: `flutter test test/data/preferences test/features/settings`.

**Tests**: unit + widget
**Gate**: full
**Verify**: `flutter test test/data/preferences test/features/settings` passes.

---

### T35: Integrate Configurable Timer Behavior [P]

**What**: Apply timer preferences consistently to question and voting screens.
**Where**: `lib/src/features/game/question_round_screen.dart`, `lib/src/features/game/voting_screen.dart`, timer state wiring
**Depends on**: T28
**Reuses**: Timer service, timer widgets, settings screen
**Requirement**: OTL-11

**Tools**:

- MCP: NONE
- Skill: `flutter-add-widget-test`

**Done when**:

- [x] Question screen uses configured timer value.
- [x] Voting screen uses configured timer value.
- [x] Expiration behavior matches spec: no automatic vote recording.
- [x] Widget tests cover configured timer and expiration state.
- [x] Gate check passes: `flutter test test/features/game`.

**Tests**: widget
**Gate**: full
**Verify**: `flutter test test/features/game` passes.

---

### T36: Final P2/P3 Gate

**What**: Run full validation after content, persistence, and timer enhancements.
**Where**: Whole repository
**Depends on**: T33, T34, T35
**Reuses**: All P2/P3 tasks
**Requirement**: OTL-08, OTL-11, OTL-12, OTL-13

**Tools**:

- MCP: NONE
- Skill: NONE

**Done when**:

- [x] `flutter analyze` passes.
- [x] `flutter test` passes.
- [x] Requirement traceability is updated.
- [x] Remaining open questions are resolved or explicitly deferred.

**Tests**: full suite
**Gate**: full
**Verify**: `flutter analyze && flutter test` passes.

---

## Parallel Execution Map

```text
Phase 0:
  T01 [P]   T02 [P]
      \     /
       T03

Phase 1:
  T03 -> T04
  T04 -> T05 [P] -> T09
  T04 -> T06 [P] -> T07 [P] -> T12
  T04 -> T08 [P]
  T05 -> T10 [P]
  T05 + T08 -> T11

Phase 2:
  After T06:
    T15 [P], T16 [P]
  After T06/T12:
    T13 [P], T14 [P]
  Then:
    T17

Phase 3:
  After shared UI/app shell/services:
    T18 [P], T19 [P], T20 [P], T21 [P], T22 [P], T23 [P], T24 [P], T25 [P], T26 [P], T27 [P]

Phase 4:
  T18..T27 + T17 -> T28
  T28 -> T29 [P], T30 [P], T31 [P] -> T32

Phase 5:
  T28 -> T33 [P], T34 [P], T35 [P] -> T36
```

---

## Requirement Coverage

| Requirement | Covered By |
| --- | --- |
| OTL-01 | T13, T18, T20, T21, T28, T29, T31, T32 |
| OTL-02 | T14, T22, T28, T29, T32 |
| OTL-03 | T10, T14, T16, T23, T28, T29, T32 |
| OTL-04 | T15, T24, T28, T29, T32 |
| OTL-05 | T15, T17, T25, T28, T29, T32 |
| OTL-06 | T15, T17, T25, T28, T29, T32 |
| OTL-07 | T14, T17, T26, T28, T32 |
| OTL-08 | T07, T12, T13, T14, T20, T31, T33 |
| OTL-09 | T19, T28 |
| OTL-10 | T05, T09, T10, T11, T18, T19, T20, T21, T22, T23, T24, T25, T26, T27, T30 |
| OTL-11 | T10, T16, T23, T24, T27, T35 |
| OTL-12 | T08, T12, T19, T27, T33, T34 |
| OTL-13 | T16, T27, T34 |

---

## Task Granularity Check

| Task | Scope | Status |
| --- | --- | --- |
| T01 | 1 design document | OK |
| T02 | 1 testing document | OK |
| T03 | 1 dependency/config pass | OK |
| T04 | 1 project structure pass | OK |
| T05 | 1 theme/token layer | OK |
| T06 | 1 model layer | OK |
| T07 | 1 content seed format | OK |
| T08 | 1 localization scaffold | OK |
| T09 | 1 shared primitive set | OK, cohesive |
| T10 | 1 timer widget set | OK |
| T11 | 1 app shell contract | OK |
| T12 | 1 repository layer | OK |
| T13 | 1 validation service | OK |
| T14 | 1 round generation service | OK |
| T15 | 1 vote/scoring service | OK |
| T16 | 1 timer state service | OK |
| T17 | 1 match progression service | OK |
| T18-T27 | 1 screen or screen group each | OK |
| T28 | 1 integration wiring pass | OK |
| T29-T31 | 1 validation target each | OK |
| T33-T35 | 1 enhancement target each | OK |

---

## Diagram-Definition Cross-Check

| Task | Depends On (task body) | Diagram Shows | Status |
| --- | --- | --- | --- |
| T01 | None | None | OK |
| T02 | None | None | OK |
| T03 | T01, T02 | T01 + T02 -> T03 | OK |
| T04 | T03 | T03 -> T04 | OK |
| T05 | T04 | T04 -> T05 | OK |
| T06 | T04 | T04 -> T06 | OK |
| T07 | T06 | T06 -> T07 | OK |
| T08 | T04 | T04 -> T08 | OK |
| T09 | T05 | T05 -> T09 | OK |
| T10 | T05 | T05 -> T10 | OK |
| T11 | T05, T08 | T05 + T08 -> T11 | OK |
| T12 | T07, T08 | T07 + T08 -> T12 | OK |
| T13 | T06, T12 | T06 + T12 -> T13 | OK |
| T14 | T06, T12 | T06 + T12 -> T14 | OK |
| T15 | T06 | T06 -> T15 | OK |
| T16 | T06 | T06 -> T16 | OK |
| T17 | T13, T14, T15, T16 | T13 + T14 + T15 + T16 -> T17 | OK |
| T18 | T09, T11 | T09 + T11 -> T18 | OK |
| T19 | T09, T11 | T09 + T11 -> T19 | OK |
| T20 | T09, T11, T12 | T09 + T11 + T12 -> T20 | OK |
| T21 | T09, T11, T13 | T09 + T11 + T13 -> T21 | OK |
| T22 | T09, T11, T14 | T09 + T11 + T14 -> T22 | OK |
| T23 | T09, T10, T11, T14 | T09 + T10 + T11 + T14 -> T23 | OK |
| T24 | T09, T10, T11, T15 | T09 + T10 + T11 + T15 -> T24 | OK |
| T25 | T09, T11, T15, T17 | T09 + T11 + T15 + T17 -> T25 | OK |
| T26 | T09, T11, T17 | T09 + T11 + T17 -> T26 | OK |
| T27 | T09, T11, T08 | T09 + T11 + T08 -> T27 | OK |
| T28 | T17-T27 | T18..T27 + T17 -> T28 | OK |
| T29 | T28 | T28 -> T29 | OK |
| T30 | T28 | T28 -> T30 | OK |
| T31 | T28 | T28 -> T31 | OK |
| T32 | T29, T30, T31 | T29 + T30 + T31 -> T32 | OK |
| T33 | T28 | T28 -> T33 | OK |
| T34 | T28 | T28 -> T34 | OK |
| T35 | T28 | T28 -> T35 | OK |
| T36 | T33, T34, T35 | T33 + T34 + T35 -> T36 | OK |

---

## Test Co-location Validation

| Task | Code Layer Created/Modified | Matrix Requires | Task Says | Status |
| --- | --- | --- | --- | --- |
| T01 | docs | none | none | OK |
| T02 | docs | none | none | OK |
| T03 | config/dependencies | build gate | none + build | OK |
| T04 | app structure | analyze | none + build | OK |
| T05 | theme constants | unit | unit | OK |
| T06 | domain models | unit | unit | OK |
| T07 | content fixtures | unit | unit | OK |
| T08 | localization scaffold | unit | unit | OK |
| T09 | shared widgets | widget | widget | OK |
| T10 | timer widgets | widget | widget | OK |
| T11 | app shell | widget | widget | OK |
| T12 | data repository | unit | unit | OK |
| T13 | domain service | unit | unit | OK |
| T14 | domain service | unit | unit | OK |
| T15 | domain service | unit | unit | OK |
| T16 | domain service | unit | unit | OK |
| T17 | domain service | unit | unit | OK |
| T18-T27 | screens/widgets | widget | widget | OK |
| T28 | route/state integration | widget/full gate | widget | OK |
| T29 | app flow test | widget | widget | OK |
| T30 | visual audit | manual + analyze | manual + analyze | OK |
| T31 | app flow/offline test | widget | widget | OK |
| T32 | repository-wide gate | full suite | full suite | OK |
| T33 | content/l10n | unit | unit | OK |
| T34 | preferences data/settings widget | unit + widget | unit + widget | OK |
| T35 | timer UI integration | widget | widget | OK |
| T36 | repository-wide gate | full suite | full suite | OK |

---

## Phase 3 Execution Notes

- T18-T27 implemented isolated Flutter screens under `lib/src/features/**`.
- Screen widgets expose data/callback constructor contracts so T28 can wire navigation and in-memory game state without rewriting the UI.
- Flutter widget-test skill was used for screen validation.
- Gate run: `flutter test test/features` passed with 11 tests.

---

## Phase 5 Execution Notes

- T33 expanded bundled offline content to 20 categories x 30 words with `pt-BR`, `en`, `es`, and `hi` localized values and question text.
- T34 added local preference persistence for selected language and timer settings using `shared_preferences`, plus startup restore in `OutOfTheLoopApp`.
- T35 wired configurable timer values and explicit expiration messaging into question and voting screens without automatic vote recording.
- Gate runs: `flutter analyze` passed; `flutter test` passed with 68 tests.

---

## Execution Tooling Decisions

Resolved during Phase 0:

- T02 gate commands use `flutter analyze`, targeted `flutter test <path>`, and full `flutter analyze && flutter test`, as defined in `.specs/codebase/TESTING.md`.
- T12 starts with a bundled local asset repository; SQLite is deferred until a later task proves it is necessary.
- Execution should prefer Flutter/Dart MCP tools whenever available for run/test/debug.
- Figma MCP is required for the final design audit and should be used during UI screen tasks when frame details are unclear.
- P2/P3 tasks T33-T36 stay deferred until the P1 MVP slice is accepted.
