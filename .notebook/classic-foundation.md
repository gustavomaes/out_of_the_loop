# Classic foundation

- Entry: `lib/main_classic.dart:main()` bypasses the legacy Firebase bootstrap; default `lib/main.dart` still enters Guided until stage 8.
- `ClassicHome` owns its default controller/demo gateway and leaves injected instances to the caller; `ClassicGallery` owns its stage-one controller; the catalog fixture is synchronous/offline and deliberately English-only. UI strings use the existing generated ARB system.
- `ClassicConfig` copies collections into unmodifiable views; controller updates validate configuration, known presentation category IDs and fixture language. Premium labels have no words yet; round creation must validate actual content in stage 3.
- Home sheets: `classic_home.dart` keeps names/categories/impostors as drafts; timer changes are immediate. `_ConfigSheet` fixes actions outside its scrolling body and above keyboard insets. The transparent Scaffold dock reserves its actual height, including text scaling.
- `ClassicDemoPremium` is a nonpersisted development fake. The 23 presentation categories mirror the prototype; only food/animals/sports have words. Content is English, independently of UI locale.
- Previews: `lib/previews/classic_previews.dart`. Text scaling is injected inside MaterialApp via its builder so the app's MediaQuery does not overwrite the 200% preview.
- Tests with the gallery loading spinner must use bounded pumps; pumpAndSettle never settles an indeterminate progress indicator. ListView children are lazy; scroll before locating lower actions.
- Delivery evidence and demos: `docs/classic/STAGE_1.md` and `docs/classic/STAGE_2.md`.
