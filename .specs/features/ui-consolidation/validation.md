# UI Consolidation — Validation Checklist

**Date**: 2026-05-19  
**Phase**: 4 (integration & validation)

## Automated checks

| Check | Command | Result |
| --- | --- | --- |
| No hardcoded colors in features/shared | `rg 'Color\(0x' lib/src/features lib/src/shared` | **0** (canonical hex only in `lib/src/theme/`) |
| Theme barrel in features | `rg "import.*theme/(brutalist\|display\|app_tokens\|app_colors)" lib/src/features` | **0** (all use `theme.dart`) |
| Analyze | `flutter analyze` | **Pass** |
| Full test gate | `flutter analyze && flutter test` | **89 tests pass** |

## Structural: one `build` per screen

| Screen | `build` count | Private widgets in file | `widgets/` folder |
| --- | ---: | --- | --- |
| `home_screen.dart` | 1 | None (State N/A) | `features/home/widgets/` |
| `how_to_play_screen.dart` | 1 | None | `features/how_to_play/widgets/` |
| `settings_screen.dart` | 1 | `_SettingsScreenState` only | `features/settings/widgets/` |
| `category_selection_screen.dart` | 1 | State only | `features/setup/widgets/` |
| `match_setup_screen.dart` | 1 | State only | `features/setup/widgets/` |
| `player_setup_screen.dart` | 1 | State only | `features/setup/widgets/` |
| `secret_reveal_screen.dart` | 1 | State only | `features/game/widgets/` |
| `question_round_screen.dart` | 1 | State only | `features/game/widgets/` |
| `voting_screen.dart` | 1 | State only | `features/game/widgets/` |
| `round_results_screen.dart` | 1 | None | `features/game/widgets/` |
| `guess_screen.dart` | 1 | None | `features/game/widgets/` |
| `final_leaderboard_screen.dart` | 1 | None | `features/game/widgets/` |

**11/11** inventoried screens comply with UIC-18 (single screen `build`; sub-widgets extracted).

## Screen file size (orientation &lt; 200 lines)

| Screen | Lines | Notes |
| --- | ---: | --- |
| home | 90 | ✓ |
| how_to_play | 107 | ✓ |
| category_selection | 106 | ✓ |
| guess | 113 | ✓ |
| secret_reveal | 131 | ✓ |
| final_leaderboard | 132 | ✓ |
| round_results | 165 | ✓ |
| voting | 177 | ✓ |
| match_setup | 196 | ✓ |
| settings | 198 | ✓ |
| question_round | 217 | Slightly above orientation |
| player_setup | 304 | Stateful form logic; widgets extracted |

## Shared primitives (UIC-13–17)

| Widget | Location | Exported in `shared_widgets.dart` |
| --- | --- | --- |
| `OtlShadowedText` | `lib/src/shared/widgets/otl_shadowed_text.dart` | Yes |
| `OtlBrutalistToggle` | `lib/src/shared/widgets/otl_brutalist_toggle.dart` | Yes |
| `OtlTimerExpiredMessage` | `lib/src/shared/widgets/otl_timer_expired_message.dart` | Yes |
| `OtlPartyAtmosphere` | `lib/src/shared/widgets/otl_party_atmosphere.dart` | Yes |

## Typography & fonts (UIC-05, UIC-06)

- `DisplayTypography` uses bundled variable fonts: Rubik, Plus Jakarta Sans, Space Grotesk (`assets/fonts/`).
- No `GoogleFonts.*` in `lib/`; `google_fonts` dependency removed (bundled variable fonts only).

## Success metrics (spec)

| Metric | Status |
| --- | --- |
| UIC-01: Colors centralized | ✓ `app_colors.dart` |
| UIC-05: No feature/shared hex literals | ✓ |
| UIC-18: Screen/widget file rules | ✓ |
| UIC-25: `theme.dart` barrel | ✓ |
| UIC-NFR-03: Tests green | ✓ 89 tests |
| Behavior unchanged | ✓ Refactor-only; integration tests updated for current copy |

## Manual smoke (recommended)

- [ ] Cold start → home → full 3-player round on device
- [ ] Settings language toggle + timer toggle persist
- [ ] Visual spot-check: home, voting, results vs Figma (no redesign expected)
