# Stitch Design Refresh Validation

**Spec**: `.specs/features/stitch-design-refresh/spec.md`
**Status**: Phase 2 screen refresh complete
**Last updated**: 2026-05-18

---

## Phase 0 Scope

This document captures the baseline visual audit before implementation. It compares the current Flutter app against the Stitch reference notes recorded in the spec.

Reference constraints:

- No Stitch MCP/API is enabled in this workspace.
- Stitch observations come from the browser-loaded `Social Deduction Party Game` reference and the notes already recorded in `spec.md`.
- Exact layer names, measurements, typography metadata, and color tokens still need manual visual validation after implementation.

---

## Source-Of-Truth Decision

- Stitch is the visual source of truth for SDR-01 to SDR-08 when it conflicts with `.agents/DESIGN.md`.
- `.agents/DESIGN.md` remains the existing baseline until a separate design-system update is made.
- Accepted divergence from `.agents/DESIGN.md`: lime becomes the dominant primary/action accent for this refresh; magenta remains contrast/glow/secret emphasis.
- Current `Poppins` tokens remain, but no font assets are added during Phase 0. `pubspec.yaml` currently declares no bundled fonts.
- Bottom navigation keeps the current app destinations and does not add unsupported Stitch-only destinations.

---

## Functional Non-Goals

These are intentionally excluded even if they appear in the visual reference:

- No login, logout, account, profile, or identity system.
- No Pro, paywall, subscription, ads, or purchase flow.
- No online multiplayer, sync, cloud dependency, or remote Stitch asset at runtime.
- No setup-time role selection; the domain service keeps assigning exactly one out player.
- No light theme or audio controls.

---

## Baseline Screen Audit

| Screen | Stitch observation | Current app baseline | Current gap before refresh |
| --- | --- | --- | --- |
| Home | Centered title and primary actions; dark dotted/party background; strong lime primary CTA; magenta/neon contrast; bottom nav should not compete. | `HomeScreen` already centers `OUT OF THE LOOP`, intro card, `START GAME`, and `HOW TO PLAY` inside `AppShell`. Current CTA system is pink/yellow from `.agents/DESIGN.md`. | Needs Stitch-forward palette, stronger brand mark treatment, less card competition around the hero, and quieter bottom nav styling. |
| Categories | High-contrast mobile grid/card composition with strong selected state and bright accent. | `CategorySelectionScreen` uses a 2-column `GridView`, `OtlCard`, icon, title, selected state, and disabled `PLAY` until selection. | Needs richer card surface, lime-dominant selected state, stronger borders/glow, and possibly more visual texture while preserving local content loading. |
| Players | Clear host flow with player list, input, visible CTA, and no unsupported role controls. | `PlayerSetupScreen` has heading, 3-9 guidance, text field, `ADD`, player cards with avatars, count, and disabled/enabled `START MATCH`. | Needs more expressive list rows, stronger fixed/visible CTA treatment, and clearer accessible error feedback without adding role selection. |
| Reveal | Focused secret/handoff screen; `TOP SECRET` should feel cinematic before reveal. | `SecretRevealScreen` suppresses bottom nav via game route, shows `TOP SECRET`, active player turn, hidden lock card, reveal button, and hides the word from the out player. | Needs stronger secret state, glow/glitch/lock treatment, more centered cinematic composition, and clearer pass-the-phone affordance. |
| Question | Focused gameplay screen with active player, prompt, timer, and primary action hierarchy. | `QuestionRoundScreen` shows progress label, selected card with player and question, optional `CircularTimer`, expired copy, and primary CTA. | Needs more dramatic active-player emphasis, better question/timer hierarchy, and refreshed timer accent treatment. |
| Vote | Secret voter context, candidate cards, selected state, disabled self-vote, and progress timer. | `VotingScreen` shows active voter text, optional `ProgressTimer`, candidate `OtlCard` rows, disabled self-vote, selected state, and handoff across voters. | Needs stronger current-voter privacy framing, richer candidate cards, lime/magenta selected states, and clearer all-votes-in transition. |
| Results | Winner/out-player, vote totals, word/score hierarchy, and clear next branch. | `RoundResultsScreen` shows out player, majority result card, vote totals, round points, and conditional `CONTINUE` or `GUESS WORD`. | Needs stronger reveal moment, clearer score hierarchy, secret-word treatment where appropriate, and more cinematic result cards. |
| Leaderboard | Final game-over hierarchy with winner emphasis, leaderboard rows, and replay/home CTAs. | `FinalLeaderboardScreen` shows `GAME OVER`, winner text, ranked list with selected winner row, `NOVA PARTIDA`, and `VOLTAR AO INICIO`. | Needs stronger winner badge/spotlight, more distinctive score rows, Stitch palette, and consistent English/Portuguese CTA decision if copy changes later. |
| How-to | Rule cards with icons and strong visual hierarchy, aligned to refresh. | `HowToPlayScreen` has four rule cards with icons, titles, copy, and `ENTENDI`. | Needs refreshed icon/card treatments, stronger section rhythm, and palette alignment while preserving rule accuracy. |
| Settings | Settings should match visual language but keep only supported MVP controls. | `SettingsScreen` includes language cards, timer switch/slider, and an explicit out-of-scope note for profile/login/Pro/audio/light theme. | Needs refreshed settings card hierarchy, lime selected state, more polished timer control styling, and continued absence of unsupported controls. |

---

## Baseline Implementation Notes

- `AppShell` currently shows bottom navigation only for Home, Categories, How To, and Settings; gameplay routes stay focused.
- `AppColors` currently use pink primary `#FF4D6D` and yellow secondary `#FFB703`; Phase 1 should introduce lime/magenta naming without scattering raw colors into feature screens.
- `OtlCard` supports selected and accent color states, but only one selected/glow model today.
- `OtlButton` already covers primary, secondary, outline, disabled, pressed, and focused states; Phase 1 should retarget those states to the new tokens.
- The game screens already preserve role secrecy, self-vote disablement, and timer behavior. Visual tasks must not weaken those behaviors.

---

## Phase 0 Gate Review

- T01 docs review: complete. Decisions are recorded in `spec.md` and summarized here.
- T02 docs review: complete. All target screens are listed with Stitch observations and current gaps.
- Automated tests: not run for Phase 0 because this phase changed documentation only.

---

## Phase 1 Foundation Review

- T03 theme tokens: complete. `primary*` now carries the lime action accent, `secondary*` carries magenta contrast, and dark surfaces/borders/focus/glow remain tokenized.
- T04 buttons and inputs: complete. Button variants and text fields consume the refreshed focus, disabled, foreground, border, and glow tokens without API changes.
- T05 cards and avatars: complete. `OtlCard` supports neutral, selected, and accented glow states; avatars keep deterministic initials and tokenized neon colors.
- T06 timers: complete. Circular and progress timers use the refreshed lime accent and retain error styling for final-five-second warning states.
- T07 app shell/navigation: complete. Discovery routes keep bottom navigation with refreshed styling, while gameplay routes remain focused without bottom navigation.

Gate results:

- `analyze_files` on the full project via Dart MCP: pass, no errors.
- `flutter test test/theme test/shared/widgets/otl_primitives_test.dart test/shared/widgets/timers test/app/out_of_the_loop_app_test.dart` via Dart MCP: pass, 16 tests.

---

## Phase 2 Screen Refresh Review

- T08 Home: centered hero title with party backdrop, removed competing intro card, primary/secondary CTAs centered.
- T09 Setup: lime-forward category selection, numbered player rows, glow-framed start CTA, accessible error semantics.
- T10 Game reveal/question: magenta secret lock state, pass-the-phone copy, active-player avatar and timer hierarchy.
- T11 Voting: secret-vote context card, refreshed candidate selection states, gameplay rules unchanged.
- T12 Results/leaderboard: distinct out-player, majority, secret-word, vote and points sections; winner spotlight on final board.
- T13 How-to/settings: accented rule cards, lime language selection, polished timer slider theme.

Gate results:

- `flutter analyze`: pass.
- `flutter test test/features/home test/features/setup test/features/game test/features/how_to_play test/features/settings`: pass, 13 tests.

---

## Residual Risks For Later Phases

- Stitch details are screenshot/browser-derived, not structured API data.
- Font rendering may differ from the token name until bundled font assets are added.
- Lime as dominant primary may require contrast checks in disabled, selected, and navigation states.
- Existing widget tests may depend on current copy or hierarchy; update only where visual intent changes, not to loosen gameplay rules.
