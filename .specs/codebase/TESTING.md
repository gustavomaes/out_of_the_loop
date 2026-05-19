# Flutter Testing Matrix

**Project**: Out of the Loop
**Status**: Phase 0 complete
**Applies to**: `.specs/features/out-of-the-loop-mvp/tasks.md`

---

## Current Baseline

- Stack: Flutter / Dart.
- Existing test dependency: `flutter_test`.
- Existing lint config: `flutter_lints` via `analysis_options.yaml`.
- Current app surface is minimal and should be replaced incrementally behind focused tests.

All gates should run from the repository root.

---

## Gate Commands

| Gate | Command | Use When |
| --- | --- | --- |
| Dependency/config gate | `flutter pub get && flutter analyze` | `pubspec.yaml`, assets, fonts, localization config, or generated package changes. |
| Analyze gate | `flutter analyze` | Structure-only changes, docs-backed wiring, visual audit validation. |
| Quick unit gate | `flutter test <path>` | Pure Dart models, services, repositories, fixtures, localization contracts. |
| Quick widget gate | `flutter test <path>` | A screen or shared widget test directory/file. |
| App flow gate | `flutter analyze && flutter test test/app` | Route/state integration and vertical-slice widget flows. |
| Full gate | `flutter analyze && flutter test` | End of MVP/P2 phases and before handoff. |

If localization generation is introduced, T03/T08 must update these gates with the exact generated-code command required by Flutter tooling.

---

## Test Types By Layer

| Layer / Area | Required Test Type | Typical Location | Notes |
| --- | --- | --- | --- |
| Theme tokens | Unit tests | `test/theme/**` | Verify representative colors, spacing, text styles, radii, and no white default scaffold background. |
| Domain models | Unit tests | `test/domain/models/**` | Constructors, equality/value behavior, enum coverage, player-count boundaries where model-level. |
| Domain services | Unit tests | `test/domain/services/**` | Game rules, scoring, majority, timer state, progression, deterministic seeded behavior where random selection exists. |
| Content fixtures | Unit tests | `test/fixtures/**` | Validate schema, supported locales, question counts, and enough data for a 3-player test round. |
| Data repositories | Unit tests | `test/data/**` | Load valid assets, handle missing/invalid content, remain offline. |
| Localization contracts | Unit tests | `test/l10n/**` | Supported locale list, fallback to `pt-BR`, required MVP keys. |
| Shared widgets | Widget tests | `test/shared/widgets/**` | Rendering, disabled/focused/pressed states, touch target expectations. |
| Screens/features | Widget tests | `test/features/**` | Visible copy, primary actions, validation messages, basic interaction flow. |
| App shell/navigation | Widget tests | `test/app/**` | App boot, initial route, route transitions, complete 3-player round flow. |
| Visual/Figma audit | Manual plus analyze | `.specs/features/out-of-the-loop-mvp/validation.md` or task notes | Record differences, blockers, and accepted divergences. |

---

## Parallel-Safe Rules

Parallel-safe:

- Unit tests for different service/model/content directories.
- Widget tests for different feature screens after shared primitives and app shell are stable.
- Docs-only validation tasks.
- Visual audit and offline validation after T28, as long as they do not edit the same files.

Not parallel-safe:

- Edits to `pubspec.yaml`, `l10n.yaml`, or generated localization files.
- Shared theme/widget changes while feature screens are being updated to consume them.
- App route/state wiring changes while full app flow tests are being written.
- Any task that rewrites the same fixture/content files.

When tasks run in parallel, each task should run only its scoped quick gate. The orchestrating agent runs the broader gate after merging task results.

---

## Task Gate Mapping

| Task Group | Required Gate |
| --- | --- |
| T01-T02 docs | Docs review: read the created document and verify task-specific done criteria. |
| T03 dependencies/assets | `flutter pub get && flutter analyze` |
| T04 structure | `flutter analyze` |
| T05 theme | `flutter test test/theme` |
| T06 models | `flutter test test/domain/models` |
| T07 fixtures | `flutter test test/fixtures` |
| T08 localization | `flutter test test/l10n` |
| T09 shared primitives | `flutter test test/shared/widgets` |
| T10 timer widgets | `flutter test test/shared/widgets/timers` |
| T11 app shell | `flutter test test/app` |
| T12 content repository | `flutter test test/data/content` |
| T13-T17 domain services | Targeted `flutter test test/domain/services/<service>_test.dart` |
| T18-T27 screens | Targeted `flutter test test/features/<feature>` or named screen test file |
| T28 integration wiring | `flutter analyze && flutter test test/app` |
| T29 vertical slice | `flutter test test/app/out_of_the_loop_vertical_slice_test.dart` |
| T30 design audit | `flutter analyze` plus written audit notes |
| T31 offline validation | `flutter test test/app/offline_mode_test.dart` |
| T32 final MVP | `flutter analyze && flutter test` |
| T33 content/l10n expansion | `flutter test test/data/content test/l10n` |
| T34 preferences | `flutter test test/data/preferences test/features/settings` |
| T35 timer behavior | `flutter test test/features/game` |
| T36 final P2/P3 | `flutter analyze && flutter test` |

---

## Minimum Coverage Expectations

The MVP should have tests for each shipped gameplay rule:

- 2 players cannot start; 3 and 9 players can; 10 players cannot.
- Duplicate and empty names are rejected.
- Exactly one player is out per round.
- Secret word is hidden from the out player before guess phase.
- Words do not repeat within a match.
- Words with too few questions are skipped.
- Question count equals player count up to 9.
- Each player can vote exactly once.
- Votes are hidden during collection and revealed only as aggregate counts.
- Majority is strictly more than half.
- Scoring covers +25, +100, +50, +125, tie/no-majority, correct guess, and wrong guess.
- Timer expiration does not automatically record a vote.
- A 3-player round can be completed with local content and no login/network dependency.

---

## Flutter Skill Usage Guidance

Use Flutter-specific skills when the task matches the scope:

- `flutter-add-widget-test`: screen/widget tasks and vertical slice widget tests.
- `flutter-add-widget-preview`: shared visual primitives or screens where previewing accelerates design validation.
- `flutter-setup-localization`: T08 localization scaffold and any generated localization troubleshooting.
- `flutter-setup-declarative-routing`: T11 only if `go_router` or equivalent is selected.
- `flutter-fix-layout-issues`: overflow/unbounded constraint failures during screen implementation.
- `flutter-build-responsive-layout`: tablet/desktop adaptations after mobile-first screens work.
- `flutter-implement-json-serialization`: content model JSON parsing if manual `fromJson`/`toJson` is used.

Prefer Dart/Flutter MCP tools over shell commands for run/test/debug when available.

---

## Acceptance For Future Tasks

Every implementation task should report:

- Files changed.
- Test type used from this matrix.
- Gate command run.
- Gate result.
- Any `SPEC_DEVIATION` from `.specs/features/out-of-the-loop-mvp/spec.md` or `.specs/features/out-of-the-loop-mvp/design.md`.
