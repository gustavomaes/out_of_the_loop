# Out of the Loop MVP Validation

**Date**: 2026-05-18
**Scope**: Phase 4 design system and Figma audit for T30
**Spec**: `.specs/features/out-of-the-loop-mvp/spec.md`

---

## Figma References Checked

Figma MCP metadata for file `Q4zPj8JvM2JJh7EU8IfDg0`, page `0:1`, confirms the expected MVP frames are present:

| Screen | Figma Node | Implementation |
| --- | --- | --- |
| Home | `2:2` | `HomeScreen` |
| Category Selection | `2:50` | `CategorySelectionScreen` |
| Cadastro de Jogadores | `2:131` | `PlayerSetupScreen` |
| The Secret Reveal | `2:196` | `SecretRevealScreen` |
| Question Round | `2:225` | `QuestionRoundScreen` |
| The Vote | `2:264` | `VotingScreen` |
| Game Results | `2:338` | `RoundResultsScreen`, `GuessScreen`, `FinalLeaderboardScreen` |
| Como Jogar | `2:441` | `HowToPlayScreen` |
| Configuracoes | `2:545` | `SettingsScreen` |

Detailed context for Home `2:2` shows the Figma reference uses lime primary actions, Rubik/Space Grotesk typography, decorative floating icons, and a `PROFILE` bottom-nav item. The implementation intentionally follows `.agents/DESIGN.md` instead, per the feature design decision.

---

## Screen Audit

| Screen | Result | Notes |
| --- | --- | --- |
| Home | Pass | Shows title, primary start action, how-to action, dark shell, and discovery navigation. Uses app tokens rather than Figma lime/Rubik styling. |
| Category Selection | Pass | Uses local repository content, two-column grid, selected card state, disabled play action before selection, and bottom navigation. |
| Player Setup | Pass | Supports 3-9 player entry, validation feedback, disabled start below 3 players, and excludes manual IN/OUT role toggles from Figma. |
| Secret Reveal | Pass | Focused no-bottom-nav gameplay screen; secret is hidden before reveal and cleared between players. |
| Question Round | Pass | Shows one question at a time, assigned responder, circular timer, and progression to voting. |
| Voting | Pass | Shows active voter context, candidate cards, self-vote disabled state, progress timer, hidden choices between voters, and aggregate confirmation. |
| Results / Guess / Final | Pass | Splits the Figma result concept into round result, conditional guess, and final leaderboard per spec scoring phases. |
| How To Play | Pass | Covers objective, roles, questions, voting/majority, guessing, and scoring with a return action. |
| Settings | Pass | Includes language and timer controls only; login/profile/Pro purchase remain excluded from MVP. |

---

## Design System Checks

| Check | Result | Evidence |
| --- | --- | --- |
| No pure white backgrounds | Pass | `OutOfTheLoopTheme.dark` uses `AppColors.backgroundPrimary` for scaffold and canvas. |
| Tokenized colors | Pass | Theme, shared widgets, and screens use `AppColors` tokens. |
| Typography tokens | Pass | Text styles come from `AppTypography`; Figma font differences are accepted by design. |
| Primary actions | Pass | `OtlButton.primary` applies tokenized color, full radius, padding, and disabled state. |
| Touch target minimum | Pass | `OtlButton` sets `minimumSize: Size(44, 44)` and padded tap targets. |
| Contrast rules | Pass | Implemented foreground/background pairs use the documented high-contrast token pairs. |
| Focus state | Pass | Buttons and inputs use warning/focus border tokens instead of default white focus treatment. |

---

## Documented Divergences

These are accepted MVP divergences, not blockers:

- Figma Home uses lime `#b7f700`, Rubik/Space Grotesk, heavier black borders, and arcade-style decorative assets. Implementation follows `.agents/DESIGN.md`: primary `#FF4D6D`, secondary `#FFB703`, Poppins/Inter fallback, and dark token surfaces.
- Figma bottom navigation includes `PROFILE`. MVP replaces account/profile behavior with settings/how-to navigation because login/profile is out of scope.
- Figma player setup includes IN/OUT language. MVP removes manual role selection because roles are randomly assigned by `RoundGenerationService`.
- Figma result frame is a single `GAME OVER` concept. MVP separates round result, optional out-player guess, next-round flow, and final leaderboard to satisfy scoring requirements.
- Decorative floating icon assets and glitch effects are not implemented in this pass. The MVP retains the dark, social, high-contrast visual direction without adding remote runtime assets.

---

## Gate Result

- `flutter analyze`: Pass
- Blocking visual issues: None
- Follow-up visual polish: optional decorative effects, richer Figma-specific category art, and final typography/font asset loading.
