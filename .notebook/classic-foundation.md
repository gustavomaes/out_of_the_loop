# Classic foundation

- Entry: `lib/main_classic.dart:main()` bypasses the legacy Firebase bootstrap; default `lib/main.dart` still enters Guided until stage 8.
- `ClassicGallery` owns and disposes its injected `ClassicController`; the catalog fixture is synchronous/offline and deliberately English-only. UI strings use the existing generated ARB system.
- `ClassicConfig` copies collections into unmodifiable views; controller updates reject missing fixture content without changing state.
- Previews: `lib/previews/classic_previews.dart`. Text scaling is injected inside MaterialApp via its builder so the app's MediaQuery does not overwrite the 200% preview.
- Tests with the gallery loading spinner must use bounded pumps; pumpAndSettle never settles an indeterminate progress indicator. ListView children are lazy; scroll before locating lower actions.
- Delivery evidence and demo: `docs/classic/STAGE_1.md`.
