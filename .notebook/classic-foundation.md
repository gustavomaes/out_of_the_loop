# Classic foundation

- Entry: `lib/main_classic.dart:main()` bypasses the legacy Firebase bootstrap; default `lib/main.dart` still enters Guided until stage 8.
- `ClassicHome` owns its default controller/demo gateway and leaves injected instances to the caller; `ClassicGallery` owns its stage-one controller; the catalog initial catalog is synchronous/offline and deliberately English-only. UI strings use the existing generated ARB system.
- `ClassicConfig` copies collections into unmodifiable views; controller updates validate configuration, known presentation category IDs and fixture language. Premium labels have no words yet; `ClassicRoundFactory.create()` rejects any selected category without actual content.
- Home sheets: `classic_home.dart` keeps names/categories/impostors as drafts; timer changes are immediate. `_ConfigSheet` fixes actions outside its scrolling body and above keyboard insets. The transparent Scaffold dock reserves its actual height, including text scaling.
- `ClassicDemoPremium` is a nonpersisted development fake. The 23 presentation categories mirror the prototype; food/animals/sports have 12 playable words each. Content is English, independently of UI locale.
- Previews: `lib/previews/classic_previews.dart`. Text scaling is injected inside MaterialApp via its builder so the app's MediaQuery does not overwrite the 200% preview.
- Tests with the gallery loading spinner must use bounded pumps; pumpAndSettle never settles an indeterminate progress indicator. ListView children are lazy; scroll before locating lower actions.
- Runtime: `ClassicHome` switches to `ClassicRoundScreen` based on controller phase; no route parameters carry secrets. `ClassicRoundFactory.create()` owns pure rules/recency; controller owns in-memory progress and monotonic clock; screen owns ephemeral visibility.
- Privacy handshake: `ClassicRoundScreen._nativePrivacy()` → iOS `AppDelegate` channel → `SceneDelegate` cover. Resume sends ready after a safe frame; native cover must not be removed on a time delay. Android activity uses FLAG_SECURE for both entries.
- Lifecycle tests use synchronous `handleAppLifecycleStateChanged`; focus events use dart:ui `ViewFocusEvent.state`. Physical background/preview acceptance is pending; simulator evidence is in `docs/classic/STAGE_3.md`.
- Delivery evidence and demos: `docs/classic/STAGE_1.md`, `STAGE_2.md`, `STAGE_3.md`.

Updated: 2026-10-25
