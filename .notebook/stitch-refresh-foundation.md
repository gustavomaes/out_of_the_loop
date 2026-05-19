# Stitch Refresh Foundation
> Phase 1 visual foundation for Stitch-inspired refresh

Entry: `.specs/features/stitch-design-refresh/tasks.md` (T03-T07)

Tokens: `lib/src/theme/app_tokens.dart`
- `AppColors.primary*` = lime action accent
- `AppColors.secondary*` = magenta contrast/accent
- `OutOfTheLoopTheme.dark` owns scaffold, app bar, input, nav theme

Shared primitives:
- `lib/src/shared/widgets/otl_button.dart` keeps primary/secondary/outline API
- `lib/src/shared/widgets/otl_card.dart` supports neutral, `selected`, `accented`
- `lib/src/shared/widgets/player_avatar.dart` uses deterministic neon palette
- `lib/src/shared/widgets/timers/` keeps timer behavior; visual accent only

Shell: `lib/src/app/app_shell.dart`
- Bottom nav only for `AppRoutes.bottomNavigationRoutes`
- Gameplay routes stay without bottom nav

Gate: Dart MCP `analyze_files` full project + targeted widget/app tests passed.

Updated: 2026-05-18
