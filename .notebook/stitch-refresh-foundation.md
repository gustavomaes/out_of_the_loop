# Neon Refined Visual Foundation
> Approved Neon refinado direction, implemented across discovery, setup and gameplay.

Updated: 2026-10-20

- Palette: `lib/src/theme/app_colors.dart` — purple #191323 canvas, #2C223F cards, lime #CAFF36 actions, pink #FF58BC occasional accents. Legacy BrutalistColors names remain compatible.
- Fonts: `lib/src/theme/app_tokens.dart` uses bundled PlusJakartaSans; display styles use bundled Rubik and SpaceGrotesk. No font downloads.
- Actions/footer/content width: `lib/src/shared/widgets/otl_neon_action.dart`. Wrapping labels and minimum 56px targets; footer SafeArea; constrained discovery/setup widths.
- Surfaces: `otl_brutalist_surface.dart` and `otl_brutalist_shadow_card.dart` now render rounded neutral cards and subtle borders. The names preserve existing caller APIs.
- Category cards: `otl_category_bento_grid.dart` uses 112px rows at normal text size, 32px icon containers and 12px padding. Rows grow with scaled text; narrow viewports with enlarged text retain the one-column accessibility fallback.
- Bottom navigation: `otl_discovery_bottom_bar.dart` delegates layout and accessibility to Material NavigationBar; existing shell branches unchanged.
- Voting: `VotingScreen` now selects a candidate, then commits via one VOTE action. Selection resets for every voter; final CONFIRM VOTES still completes the stage. Scoring rules unchanged.
- Questions retain their localized sentence case, rather than forcing uppercase.
- Dialogs scroll for smaller viewports. Confetti respects reduced-motion preferences.
- Native Android/iOS launch backgrounds match the purple canvas; app icon and store/app names unchanged.

Previews: `lib/previews/neon_previews.dart` — 13 isolated Flutter Widget Previewer entries with sample data; no production routes or paid/free modes were added.
Validation: `test/features/neon_refined_layout_test.dart` renders all 13 screens at 320x640 (1.4x text), 390x844, 768x1024 and 844x390 in all five supported languages. NEON_CAPTURE_DIR optionally captures Portuguese phone screens with actual bundled fonts/icons.

Note: preview data illustrates a barbecue question; it does not add a Brazilian content pack to production.
