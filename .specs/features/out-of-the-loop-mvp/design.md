# Out of the Loop MVP Design

**Spec**: `.specs/features/out-of-the-loop-mvp/spec.md`
**Tasks**: `.specs/features/out-of-the-loop-mvp/tasks.md`
**Status**: Phase 0 complete

---

## Design Inputs

- Flutter app is currently minimal: `lib/main.dart` boots a default `MaterialApp` with `Hello World!`.
- Current dependencies are only Flutter SDK, `flutter_test`, and `flutter_lints`.
- `.agents/DESIGN.md` is the source of truth for tokens, components, accessibility, spacing, and implementation rules.
- Figma file `Q4zPj8JvM2JJh7EU8IfDg0` provides flow, composition, hierarchy, and frame-specific visual references.

When Figma and `.agents/DESIGN.md` disagree, implementation follows `.agents/DESIGN.md` and records the difference here.

---

## Architecture

Use a small layered Flutter architecture under `lib/src`:

```text
lib/
  main.dart
  src/
    app/
      out_of_the_loop_app.dart
      app_routes.dart
      app_shell.dart
      game_flow_controller.dart
    theme/
      app_colors.dart
      app_spacing.dart
      app_radii.dart
      app_shadows.dart
      app_text_styles.dart
      app_theme.dart
    domain/
      models/
      services/
    data/
      content/
      preferences/
    l10n/
    shared/
      widgets/
    features/
      home/
      setup/
      game/
      how_to_play/
      settings/
```

### Layer Responsibilities

| Layer | Responsibility | Must Not |
| --- | --- | --- |
| `app` | App bootstrap, route names, screen composition, in-memory match flow ownership. | Contain scoring rules or content parsing. |
| `theme` | Design tokens and `ThemeData` mapping from `.agents/DESIGN.md`. | Use raw colors in feature widgets. |
| `domain/models` | Immutable data shapes for game state, content, settings, and scoring. | Import Flutter widgets. |
| `domain/services` | Pure game rules: setup validation, round generation, voting/scoring, timers, progression. | Read assets or depend on UI state. |
| `data/content` | Load and validate local categories, words, questions, and localized content. | Decide gameplay outcomes. |
| `data/preferences` | Later local preference persistence for P3. | Block MVP flow before T34. |
| `shared/widgets` | Tokenized buttons, cards, inputs, avatars, timers, and layout primitives. | Own feature-specific state. |
| `features/*` | Screens and screen-local interaction state. | Duplicate domain rules. |

This keeps most game logic testable with plain unit tests and lets screen tasks focus on rendering and interaction.

---

## Navigation And State Ownership

The MVP can start with Flutter Navigator 2.0 only if T11 selects a declarative routing package. Until then, define route names and a simple in-memory flow contract:

| Route | Feature | Purpose |
| --- | --- | --- |
| `/` | Home | Entry point with start and how-to actions. |
| `/categories` | Setup | Pick local category. |
| `/players` | Setup | Add 3 to 9 players and choose round count. |
| `/game/reveal` | Game | Pass-and-reveal flow for each player. |
| `/game/questions` | Game | Public question progression. |
| `/game/vote` | Game | Secret vote collection. |
| `/game/results` | Game | Round result, vote totals, scoring, and optional guess entry point. |
| `/game/guess` | Game | Conditional out-player guess resolution. |
| `/game/final` | Game | Final leaderboard and restart actions. |
| `/how-to-play` | How To Play | Rules and scoring explanation. |
| `/settings` | Settings | Language and timer preferences, no login/profile. |

`GameFlowController` owns the current setup, active match, active round phase, and transient UI progression that spans screens. It should remain in-memory for MVP. Persistence is deferred to T34 and must not be required to complete a local game.

Discovery/configuration screens may use bottom navigation. Focused gameplay routes should suppress bottom navigation and provide only the action needed for the current phase.

---

## Services And Repositories

| Component | Where | Responsibility |
| --- | --- | --- |
| `MatchSetupService` | `lib/src/domain/services/match_setup_service.dart` | Validate 3 to 9 players, unique non-empty names, round count against content capacity. |
| `RoundGenerationService` | `lib/src/domain/services/round_generation_service.dart` | Select exactly one out player, choose an unused valid word, assign questions. |
| `VoteScoringService` | `lib/src/domain/services/vote_scoring_service.dart` | Record one vote per voter, calculate majority, determine round result and score events. |
| `TimerService` | `lib/src/domain/services/timer_service.dart` | Represent enabled/disabled timer settings, countdown state, and expiration. |
| `MatchProgressionService` | `lib/src/domain/services/match_progression_service.dart` | Apply score events, start next round, produce final ranking. |
| `ContentRepository` | `lib/src/data/content/content_repository.dart` | Load localized categories, words, and questions from bundled local assets. |
| `PreferencesRepository` | `lib/src/data/preferences/preferences_repository.dart` | Persist language/timer settings in P3 only. |

Content should start as bundled JSON assets because OTL-08 requires offline play and T12 can validate local fixtures without introducing database complexity. SQLite can be revisited after the MVP if content volume or querying needs justify it.

---

## Domain Model Design

Create immutable models with value semantics. Use explicit identifiers instead of relying on display names for equality where possible.

| Model / Enum | Key Fields |
| --- | --- |
| `Player` | `id`, `name`, `avatarSeed`, `totalScore` |
| `PlayerRole` | `inside`, `out` |
| `Category` | `id`, localized `name`, optional `iconKey` |
| `SecretWord` | `id`, `categoryId`, localized `value`, localized `questions` |
| `Question` | `id`, `wordId`, localized `text` |
| `SupportedLanguage` | `ptBr`, `en`, `es`, `hi` |
| `TimerSettings` | `enabled`, `durationSeconds` |
| `MatchSetup` | `categoryId`, `roundCount`, `players`, `language`, `timerSettings` |
| `MatchState` | `players`, `rounds`, `currentRoundIndex`, `usedWordIds`, `totalScores` |
| `RoundState` | `roundNumber`, `outPlayerId`, `secretWord`, `questions`, `phase`, `votes`, `scoreEvents` |
| `RoundPhase` | `reveal`, `questions`, `voting`, `results`, `guess`, `complete` |
| `Vote` | `voterId`, `suspectId` |
| `RoundResult` | `outPlayerId`, `voteCounts`, `wasOutFoundByMajority`, `guessWasCorrect`, `scoreEvents` |
| `ScoreEvent` | `playerId`, `points`, `reason` |

Rules represented by models:

- Player count boundary is 3 to 9.
- Majority is strictly more than half of players.
- A word is valid only when it has enough questions for the current player count.
- Used word ids are tracked at match level to prevent repeat words.
- Timer expiration never records a vote automatically.

---

## UI Component Strategy

Implement design tokens before screen work. Feature widgets should consume shared primitives rather than constructing bespoke styling.

| Primitive | Purpose |
| --- | --- |
| `OtlButton` | Primary, secondary, outline, disabled, pressed/focused states, min 44px touch target. |
| `OtlCard` | Tokenized card background, border, radius, shadow, optional accent. |
| `OtlTextField` | Player name entry and future simple inputs. |
| `PlayerAvatar` | Initials fallback, deterministic color/seed, 40px default. |
| `PlayerCard` | Reusable row for setup, voting, leaderboard contexts. |
| `BottomNavShell` | Discovery/configuration shell for Play/Categories/Settings. |
| `GameHeader` | Focused top app bar for gameplay screens. |
| `CircularTimer` | Question screen timer. |
| `ProgressTimer` | Voting screen timer. |

Use Flutter `ThemeData`, `ColorScheme`, `TextTheme`, and local token classes. Do not add Tailwind or web-only styling dependencies. Raw Figma asset URLs are temporary references only and should not be used as shipped runtime assets.

---

## Figma Frame Mapping

| Figma Frame | Node | Flutter Screen / Task | Notes |
| --- | --- | --- | --- |
| Home | `2:2` | `HomeScreen` / T18 | Use title, start, how-to, and discovery bottom nav composition. Apply `.agents/DESIGN.md` colors/fonts instead of Figma lime/Rubik palette. |
| Category Selection | `2:50` | `CategorySelectionScreen` / T20 | Use header, 2-column/bento category grid, selected category state, bottom nav. Content comes from local repository. |
| Cadastro de Jogadores | `2:131` | `PlayerSetupScreen` / T21 | Use fixed primary action, player list, input, and 3-9 player affordance. Remove any manual IN/OUT role toggle from implementation. |
| The Secret Reveal | `2:196` | `SecretRevealScreen` / T22 | Use focused no-bottom-nav flow, pass-to-player instructions, unrevealed secret card, reveal action. |
| Question Round | `2:225` | `QuestionRoundScreen` / T23 | Use focused game header, player turn chip, question card, timer/progress feedback, done action. |
| The Vote | `2:264` | `VotingScreen` / T24 | Use voter context, player candidate cards, disabled self-vote state, progress timer. Hide each vote before next voter. |
| Game Results | `2:338` | `RoundResultsScreen`, `GuessScreen`, `FinalLeaderboardScreen` / T25-T26 | Split into round result, conditional guess, and final leaderboard because spec has separate scoring phases. |
| Como Jogar | `2:441` | `HowToPlayScreen` / T19 | Use four rule cards and understood/back action. Ensure majority and scoring rules are explicit. |
| Configuracoes | `2:545` | `SettingsScreen` / T27 | Keep language and timer controls. Exclude login/logout, profile, pro purchase, light theme, music/audio unless later scoped. |
| Assinatura Pro | `2:625` | Out of scope | Do not implement in MVP. |

---

## Design Divergences

| Area | Figma Shows | `.agents/DESIGN.md` / Spec Decision |
| --- | --- | --- |
| Typography | Figma reference uses Rubik, Space Grotesk, Plus Jakarta Sans in generated code. | Implement Poppins with Inter fallback unless design system changes. |
| Primary action color | Figma emphasizes lime `#b7f700` and high-contrast black borders. | Implement `color-primary-main` `#FF4D6D` for primary actions and `color-secondary-main` `#FFB703` for timer/accent. |
| Background | Figma generated code uses `#111125` and frame-specific gradients. | Use `color-background-primary` `#0B0B2B` and tokenized dark surfaces. |
| Category cards | Figma uses colorful arcade cards. | Use tokenized dark cards with selected/focus states unless later visual audit decides controlled accent variants. |
| Player setup | Figma includes visual IN/OUT language. | Roles are randomly assigned by the domain service; setup must not let users choose roles. |
| Settings | Figma includes light theme, audio, terms/privacy, logout. | MVP includes language and timer preferences only; no login/logout/profile and no Pro purchase. |
| Result screen | Figma labels a round-style result as `GAME OVER`. | MVP separates round result, optional guess, next round, and final leaderboard. |

---

## Requirement Implementation Path

| Requirement | Implementation Path |
| --- | --- |
| OTL-01 | `HomeScreen`, setup routes, `MatchSetupService`, category/player setup, app flow wiring. |
| OTL-02 | `RoundGenerationService`, `RoundState`, `SecretRevealScreen`, hidden/revealed state. |
| OTL-03 | `QuestionRoundScreen`, question assignment in `RoundGenerationService`, optional `TimerService`. |
| OTL-04 | `VotingScreen`, `VoteScoringService`, one-vote-per-player validation. |
| OTL-05 | `VoteScoringService`, `RoundResultsScreen`, score events. |
| OTL-06 | `GuessScreen`, conditional branch from `RoundResult`, out-player score event. |
| OTL-07 | `MatchProgressionService`, `FinalLeaderboardScreen`, used-word tracking. |
| OTL-08 | `ContentRepository`, local JSON assets, fixture validation, offline app tests. |
| OTL-09 | `HowToPlayScreen`, localized rule strings. |
| OTL-10 | `theme`, shared widgets, Figma audit, tokenized screens. |
| OTL-11 | `TimerSettings`, `TimerService`, timer widgets, settings control. |
| OTL-12 | Flutter localization scaffold, supported locale list, localized content repository. |
| OTL-13 | Deferred `PreferencesRepository` and app startup restore in P3. |

Every P1 requirement has an implementation path. P2/P3 paths are designed so they can be built without blocking the first playable P1 slice.

---

## Implementation Decisions For Next Phase

- T03 should add localization dependencies/config and asset declarations selected by this design.
- T03 should not add SQLite for the MVP; use bundled local JSON assets first.
- T08 should use Flutter localization tooling and support `pt-BR`, `en`, `es`, and `hi`.
- T11 may choose `go_router` if deep linking/browser history becomes useful, but a simple named route contract is enough for the first mobile-first MVP.
- UI screen tasks should use Flutter widget-test skills when adding screen tests.
- Flutter/Dart MCP tools should be preferred for running/analyzing/debugging when available.
