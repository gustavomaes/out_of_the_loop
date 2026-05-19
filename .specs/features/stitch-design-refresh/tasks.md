# Stitch Design Refresh Tasks

**Spec**: `.specs/features/stitch-design-refresh/spec.md`
**Status**: Phase 2 complete

---

## Planning Assumptions

- Tasks marked `[P]` are parallel-safe after their dependencies complete.
- Prefer one sub-agent per `[P]` task during implementation.
- Shared tokens/primitives must land before feature-screen redesign tasks to avoid conflicting edits.
- Feature-screen tasks can run in parallel once shared primitives and shell contracts are stable.
- This is a visual refresh only; gameplay rules, local content, localization behavior, and offline support must not change.
- No Stitch MCP is currently available; use the browser-loaded Stitch reference and recorded screenshots/notes for visual audit.

---

## Execution Plan

### Phase 0: Decisions And Audit Baseline

Resolved design-source ambiguity before implementation.

```text
T01 -> T02
```

### Phase 1: Shared Visual Foundation

Make the theme and reusable primitives ready for the refresh.

```text
T02 -> T03
T03 -> T04 [P]
T03 -> T05 [P]
T03 -> T06 [P]
T04 + T05 + T06 -> T07
```

### Phase 2: Parallel Screen Refresh

After the foundation is stable, redesign screens in parallel by ownership area.

```text
T07 -> T08 [P]
T07 -> T09 [P]
T07 -> T10 [P]
T07 -> T11 [P]
T07 -> T12 [P]
T07 -> T13 [P]
```

### Phase 3: Integration And Validation

Merge screen work, verify app behavior, and document visual acceptance.

```text
T08 + T09 + T10 + T11 + T12 + T13 -> T14
T14 -> T15 [P]
T14 -> T16 [P]
T14 -> T17 [P]
T15 + T16 + T17 -> T18
```

### Parallelism Summary

- Maximum parallel batch after T03: `T04`, `T05`, `T06`.
- Maximum parallel batch after T07: `T08`, `T09`, `T10`, `T11`, `T12`, `T13`.
- Maximum validation batch after T14: `T15`, `T16`, `T17`.

---

## Task Breakdown

### T01: Resolve Visual Source Of Truth

**What**: Decide and document whether Stitch updates `.agents/DESIGN.md` or whether implementation may diverge directly from it for this refresh.
**Where**: `.specs/features/stitch-design-refresh/spec.md`, optional `.agents/DESIGN.md`
**Depends on**: None
**Reuses**: Stitch reference URL, existing `.agents/DESIGN.md`, `.specs/features/out-of-the-loop-mvp/design.md`
**Requirement**: SDR-02, SDR-08

**Done when**:

- [x] Open questions about primary color, font embedding, nav labels, and source-of-truth order are answered.
- [x] The chosen rule is recorded in the spec or design docs.
- [x] Any accepted divergence from `.agents/DESIGN.md` is explicit.

**Tests**: none
**Gate**: docs review
**Verify**: Read the decision and confirm it unblocks token implementation.
**Status**: Complete

---

### T02: Create Visual Audit Baseline

**What**: Capture a baseline audit of current app screens versus the Stitch reference before changing code.
**Where**: `.specs/features/stitch-design-refresh/validation.md`
**Depends on**: T01
**Reuses**: Stitch browser reference, current Flutter screens, existing feature tests
**Requirement**: SDR-01 to SDR-08

**Done when**:

- [x] `validation.md` lists target screens: Home, categories, players, reveal, question, vote, results, leaderboard, how-to, settings.
- [x] Each screen has Stitch observations and current app gaps.
- [x] Functional non-goals are noted: no login, no Pro, no online features.

**Tests**: none
**Gate**: docs review
**Verify**: Review `validation.md` and confirm all target screens are covered.
**Status**: Complete

---

### T03: Update Theme Tokens

**What**: Update token constants and `ThemeData` for the Stitch-inspired palette, surfaces, borders, shadows, typography, focus, and navigation colors.
**Where**: `lib/src/theme/app_tokens.dart`, `test/theme/app_tokens_test.dart`
**Depends on**: T02
**Reuses**: `OutOfTheLoopTheme.dark`, existing token classes
**Requirement**: SDR-02

**Done when**:

- [x] Dark background and high-contrast surfaces remain tokenized.
- [x] Lime/magenta accent decisions are reflected in named tokens.
- [x] Focus, disabled, border, shadow/glow, and navigation colors are covered.
- [x] Theme tests assert representative new tokens and no white scaffold background.

**Tests**: `flutter test test/theme`
**Gate**: quick unit gate
**Verify**: Theme tests pass.
**Status**: Complete

---

### T04: Refresh Buttons And Inputs [P]

**What**: Restyle `OtlButton` and `OtlTextField` variants to match the new token system while preserving behavior and accessibility.
**Where**: `lib/src/shared/widgets/otl_button.dart`, `lib/src/shared/widgets/otl_text_field.dart`, `test/shared/widgets/otl_primitives_test.dart`
**Depends on**: T03
**Reuses**: `AppColors`, `AppSpacing`, `AppRadius`, `AppShadows`, existing widget APIs
**Requirement**: SDR-03

**Done when**:

- [x] Primary, secondary, outline, disabled and focus states use updated tokens.
- [x] Minimum touch targets remain covered by tests.
- [x] Inputs keep readable placeholder, text, border and focus states.

**Tests**: `flutter test test/shared/widgets/otl_primitives_test.dart`
**Gate**: quick widget gate
**Verify**: Shared primitive tests pass.
**Status**: Complete

---

### T05: Refresh Cards, Avatars And Player Rows [P]

**What**: Add/adjust card, avatar and player-row visual variants needed by category grids, voting, results and leaderboard.
**Where**: `lib/src/shared/widgets/otl_card.dart`, `lib/src/shared/widgets/player_avatar.dart`, related feature-local row widgets if any, `test/shared/widgets/otl_primitives_test.dart`
**Depends on**: T03
**Reuses**: Existing `OtlCard` selected/accent patterns
**Requirement**: SDR-03, SDR-04, SDR-05

**Done when**:

- [x] Cards support neutral, selected and accent/glow states without feature-level hardcoded colors.
- [x] Avatars remain deterministic and readable.
- [x] Tests cover selected/accent visual states at a behavior level.

**Tests**: `flutter test test/shared/widgets/otl_primitives_test.dart`
**Gate**: quick widget gate
**Verify**: Shared primitive tests pass.
**Status**: Complete

---

### T06: Refresh Timer Widgets [P]

**What**: Restyle circular and progress timers using the refreshed accent system while preserving disabled/expired behavior.
**Where**: `lib/src/shared/widgets/timers/**`, `test/shared/widgets/timers/timer_widgets_test.dart`
**Depends on**: T03
**Reuses**: `CircularTimer`, `ProgressTimer`, `TimerSettings`
**Requirement**: SDR-03, SDR-05

**Done when**:

- [x] Circular timer and progress timer use updated accent colors and warning/expired states.
- [x] Timer disabled state remains visually clear.
- [x] No timer behavior changes are introduced.

**Tests**: `flutter test test/shared/widgets/timers`
**Gate**: quick widget gate
**Verify**: Timer widget tests pass.
**Status**: Complete

---

### T07: Refresh App Shell And Navigation

**What**: Update discovery shell, top app bar treatment, safe-area layout, and bottom navigation visual states.
**Where**: `lib/src/app/app_shell.dart`, `test/app/out_of_the_loop_app_test.dart`
**Depends on**: T04, T05, T06
**Reuses**: Existing route names and discovery/game route split
**Requirement**: SDR-06

**Done when**:

- [x] Discovery routes show refreshed bottom navigation.
- [x] Gameplay routes remain focused without bottom navigation.
- [x] Shell padding/safe-area behavior remains mobile-first.

**Tests**: `flutter test test/app/out_of_the_loop_app_test.dart`
**Gate**: app flow gate
**Verify**: App shell tests pass.
**Status**: Complete

---

### T08: Refresh Home Screen [P]

**What**: Redesign Home around a centered title and centered primary/secondary CTAs matching the Stitch note.
**Where**: `lib/src/features/home/home_screen.dart`, `test/features/home/home_screen_test.dart`
**Depends on**: T07
**Reuses**: `OtlButton`, `OtlCard`, `AppShell`
**Requirement**: SDR-01

**Done when**:

- [x] `OUT OF THE LOOP` is the dominant centered element.
- [x] Start and how-to actions are centered and visually prioritized.
- [x] Bottom navigation does not compete with the main CTAs.

**Tests**: `flutter test test/features/home`
**Gate**: quick widget gate
**Verify**: Home screen tests pass.
**Status**: Complete

---

### T09: Refresh Setup Screens [P]

**What**: Redesign category selection and player setup around richer cards, stronger selected states, and visible primary actions.
**Where**: `lib/src/features/setup/category_selection_screen.dart`, `lib/src/features/setup/player_setup_screen.dart`, `test/features/setup/setup_screens_test.dart`
**Depends on**: T07
**Reuses**: Local content repository, setup validation, shared primitives
**Requirement**: SDR-04

**Done when**:

- [x] Category grid visually matches the Stitch-inspired card direction.
- [x] Player setup remains fast, readable, and validates 3-9 players.
- [x] CTA disabled/enabled states are preserved.

**Tests**: `flutter test test/features/setup`
**Gate**: quick widget gate
**Verify**: Setup screen tests pass.
**Status**: Complete

---

### T10: Refresh Secret Reveal And Question Screens [P]

**What**: Make reveal and question screens more cinematic while preserving role secrecy and timer behavior.
**Where**: `lib/src/features/game/secret_reveal_screen.dart`, `lib/src/features/game/question_round_screen.dart`, `test/features/game/game_screens_test.dart`
**Depends on**: T07
**Reuses**: `SecretRevealScreen`, `QuestionRoundScreen`, `CircularTimer`
**Requirement**: SDR-05

**Done when**:

- [x] Reveal screen emphasizes `TOP SECRET`/handoff before revealing.
- [x] Out player still never sees the word.
- [x] Question screen highlights active player, prompt, timer and primary action.

**Tests**: `flutter test test/features/game/game_screens_test.dart`
**Gate**: quick widget gate
**Verify**: Targeted game screen tests pass.
**Status**: Complete

---

### T11: Refresh Voting Screen [P]

**What**: Redesign voting around voter context, candidate cards, selected state, disabled self-vote and handoff secrecy.
**Where**: `lib/src/features/game/voting_screen.dart`, `test/features/game/game_screens_test.dart`
**Depends on**: T07
**Reuses**: `VotingScreen`, `ProgressTimer`, vote flow tests
**Requirement**: SDR-05

**Done when**:

- [x] Active voter context is visually prominent.
- [x] Candidate cards and selected states use refreshed tokens.
- [x] Vote secrecy and self-vote restrictions remain intact.

**Tests**: `flutter test test/features/game/game_screens_test.dart`
**Gate**: quick widget gate
**Verify**: Targeted voting tests pass.
**Status**: Complete

---

### T12: Refresh Results, Guess And Leaderboard Screens [P]

**What**: Redesign round results, optional guess, and final leaderboard with stronger winner/score/secret-word hierarchy.
**Where**: `lib/src/features/game/round_results_screen.dart`, `lib/src/features/game/final_leaderboard_screen.dart`, `test/features/game/game_screens_test.dart`
**Depends on**: T07
**Reuses**: Current scoring result models and navigation callbacks
**Requirement**: SDR-05

**Done when**:

- [x] Vote totals, out player, word and score changes are visually distinct.
- [x] Guess branch stays conditional.
- [x] Final leaderboard highlights winner without changing scoring order.

**Tests**: `flutter test test/features/game/game_screens_test.dart`
**Gate**: quick widget gate
**Verify**: Targeted results/leaderboard tests pass.
**Status**: Complete

---

### T13: Refresh How-To And Settings [P]

**What**: Update explanatory and settings screens to match the refresh without adding unsupported features.
**Where**: `lib/src/features/how_to_play/how_to_play_screen.dart`, `lib/src/features/settings/settings_screen.dart`, `test/features/how_to_play/how_to_play_screen_test.dart`, `test/features/settings/settings_screen_test.dart`
**Depends on**: T07
**Reuses**: Existing localization strings, timer/language settings
**Requirement**: SDR-07

**Done when**:

- [x] How-to cards are visually aligned with new card system.
- [x] Settings keeps only language and timer preferences.
- [x] No Pro/login/audio/light-theme controls are introduced.

**Tests**: `flutter test test/features/how_to_play test/features/settings`
**Gate**: quick widget gate
**Verify**: How-to and settings tests pass.
**Status**: Complete

---

### T14: Integrate Screen Refresh

**What**: Resolve visual inconsistencies across parallel screen work and run the app-level route/flow checks.
**Where**: `lib/src/app/**`, `lib/src/features/**`, `test/app/**`
**Depends on**: T08, T09, T10, T11, T12, T13
**Reuses**: Existing app flow and vertical slice tests
**Requirement**: SDR-01 to SDR-07

**Done when**:

- [ ] Routes compile and no screen has unresolved import/style conflicts.
- [ ] Discovery/game navigation split still works.
- [ ] Vertical slice still completes a local game flow.

**Tests**: `flutter analyze && flutter test test/app`
**Gate**: app flow gate
**Verify**: Analyze and app tests pass.

---

### T15: Run Feature Test Sweep [P]

**What**: Run all feature widget tests and fix regressions caused by visual/copy changes without weakening gameplay assertions.
**Where**: `test/features/**`
**Depends on**: T14
**Reuses**: Existing feature tests
**Requirement**: SDR-01, SDR-04, SDR-05, SDR-07

**Done when**:

- [ ] Home, setup, game, how-to and settings feature tests pass.
- [ ] Test updates reflect intended visual/copy changes only.

**Tests**: `flutter test test/features`
**Gate**: quick widget gate
**Verify**: Feature tests pass.

---

### T16: Run Full App Regression [P]

**What**: Run broader analyze/test gate for regression confidence after the refresh.
**Where**: entire repo
**Depends on**: T14
**Reuses**: `.specs/codebase/TESTING.md`
**Requirement**: SDR-01 to SDR-08

**Done when**:

- [ ] Static analysis passes.
- [ ] Full Flutter test suite passes.

**Tests**: `flutter analyze && flutter test`
**Gate**: full gate
**Verify**: Full gate passes.

---

### T17: Complete Stitch Visual Audit [P]

**What**: Compare the implemented app against the Stitch reference and record accepted divergences/follow-ups.
**Where**: `.specs/features/stitch-design-refresh/validation.md`
**Depends on**: T14
**Reuses**: Browser-loaded Stitch reference, app screens, spec acceptance criteria
**Requirement**: SDR-08

**Done when**:

- [ ] Each target screen has pass/partial/fail notes.
- [ ] Divergences are categorized as accepted, blocker, or follow-up.
- [ ] No functional out-of-scope item from Stitch was accidentally introduced.

**Tests**: `flutter analyze`
**Gate**: analyze plus docs review
**Verify**: Audit document is complete and analyze passes.

---

### T18: Final Handoff

**What**: Produce final implementation summary, test results, and remaining decisions/follow-ups.
**Where**: `.specs/features/stitch-design-refresh/validation.md`, final response or handoff note
**Depends on**: T15, T16, T17
**Reuses**: Task results and validation notes
**Requirement**: SDR-01 to SDR-08

**Done when**:

- [ ] Summary maps completed work back to SDR requirements.
- [ ] Test commands/results are recorded.
- [ ] Any remaining open questions are listed with recommended next decisions.

**Tests**: none
**Gate**: handoff review
**Verify**: Requirements, tests and residual risks are all accounted for.
