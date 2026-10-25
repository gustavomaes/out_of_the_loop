# Out of the Loop — Classic

Flutter party game for 3–20 players on one device. The default `lib/main.dart`
starts Classic, including persistence/migration, localized settings and Premium.
`lib/main_classic.dart` forwards to the same entry for older development commands.
Guided screens and routes have been retired.

```sh
flutter pub get
flutter run
flutter analyze --no-fatal-infos
flutter test
python3 tool/classic_catalog.py --check
flutter build ios --release --no-codesign
python3 tool/classic_rc_check.py build/ios/iphoneos/Runner.app
```

For builds with real commerce/support, use the confirmed build defines described in
[stage 6](docs/classic/STAGE_6.md) and [stage 7](docs/classic/STAGE_7.md).
Unconfigured purchases remain unavailable; free gameplay works offline.
Never commit credentials or substitute sample product IDs/prices.

The versioned Classic catalog is compiled from `assets/content/classic_catalog.json`.
Legacy content files are retained as editorial/migration audit inputs and excluded
from the Flutter asset bundle. Regenerate/check with `tool/classic_catalog.py`.

See [stage 8](docs/classic/STAGE_8.md) for candidate evidence, QA and remaining
release blockers. A local unsigned build is not a TestFlight candidate or release
approval. Bundle ID and native distribution settings remain those of the existing app.
