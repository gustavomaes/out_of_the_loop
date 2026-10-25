# Classic foundation

- Entry: `lib/main_classic.dart:main()` bypasses the legacy Firebase bootstrap; default `lib/main.dart` still enters Guided until stage 8.
- `ClassicHome` owns its default controller/demo gateway and leaves injected instances to the caller; `ClassicGallery` owns its stage-one controller; the catalog initial catalog is synchronous/offline and deliberately English-only. UI strings use the existing generated ARB system.
- `ClassicConfig` copies collections into unmodifiable views; controller updates validate configuration, known presentation category IDs and supported runtime language. All 23 categories now have real content; `ClassicRoundFactory.create()` rejects any selected category without actual content.
- Home sheets: `classic_home.dart` keeps names/categories/impostors as drafts; timer changes are immediate. `_ConfigSheet` fixes actions outside its scrolling body and above keyboard insets. The transparent Scaffold dock reserves its actual height, including text scaling.
- `ClassicDemoPremium` is a nonpersisted development fake used only when explicitly injected. The 23 categories mirror the prototype; the stage-five catalog supplies all words. Runtime content remains English, independently of UI locale.
- Previews: `lib/previews/classic_previews.dart`. Text scaling is injected inside MaterialApp via its builder so the app's MediaQuery does not overwrite the 200% preview.
- Tests with the gallery loading spinner must use bounded pumps; pumpAndSettle never settles an indeterminate progress indicator. ListView children are lazy; scroll before locating lower actions.
- Runtime: `ClassicHome` switches to `ClassicRoundScreen` based on controller phase; no route parameters carry secrets. `ClassicRoundFactory.create()` owns pure rules/recency; controller owns progress, serialized persistence and monotonic clock; screen owns ephemeral visibility.
- Privacy handshake: `ClassicRoundScreen._nativePrivacy()` → iOS `AppDelegate` channel → `SceneDelegate` cover. Resume sends ready after a safe frame; native cover must not be removed on a time delay. Android activity uses FLAG_SECURE for both entries.
- Lifecycle tests use synchronous `handleAppLifecycleStateChanged`; focus events use dart:ui `ViewFocusEvent.state`. Physical background/preview acceptance is pending; simulator evidence is in `docs/classic/STAGE_3.md`.
- Delivery evidence and demos: `docs/classic/STAGE_1.md`, `STAGE_2.md`, `STAGE_3.md`.

Updated: 2026-10-25

- Stage 4: executable entry wraps `ClassicHome` in `ClassicSessionHost`; plain `ClassicDevApp` remains isolated for existing tests/previews. Injected host repositories bypass native preferences; main reads the existing UI language key.
- `ClassicSessionRepository` validates complete envelopes and queues captured JSON; write errors are observed by controller/host. The saved envelope is the migration marker after read-back verification; no separate marker can race a failed write. Future schemas remain untouched during explicitly temporary play.
- Session lifecycle: keep the round screen mounted beneath saving/error overlays so native privacy observers remain active; replacing it with a spinner would remove those observers. Role visibility/viewed and running timer origin never persist. `markViewed` deliberately does not enqueue a write.
- Legacy history keys use colons; Classic uses language/category/word ID separated by slashes. Explicit equivalents live in `classic_legacy_migration.dart`; unmapped count is local metadata, source remains available for stage 5. UI-language migration must not switch the English-only content language.
- `classicResume` already means Resume timer; the stage-four CTA uses `classicResumeGame` to avoid changing the existing discussion control.
- Stage-four evidence: `docs/classic/STAGE_4.md`; physical update/kill scenarios are pending, simulator update and revealing-process restart were checked.

- Stage 5: `assets/content/classic_catalog.json` is the editable source; `tool/classic_catalog.py` validates and generates the synchronous Dart bundle and editorial report. Run `--check` to detect drift. There are 959 category entries / 920 distinct English texts, with 120 free and 800 exclusive Premium texts. Translations do not inflate counts.
- `classic_catalog_parser.dart:ClassicCatalog.parse()` validates schema/IDs/localized values/examples/mapping. The full mapping preserves all 960 legacy localized references; `classic_convert_legacy.py` exports question-free equivalents. Existing completed migrations are not replayed. Human review is pending, see `docs/classic/STAGE_5.md`.
- Restored rounds keep their frozen catalog version; `ClassicController._create()` switches the next new round to the current version. Free categories have full five-language values; three Premium categories retain partial legacy translations, others are English-only. Billing rights are still stage 6.

- Stage 6: `ClassicSessionHost` owns `PremiumAccess`, SDK refresh/listener lifecycle and an explicit product-to-entitlement map from build defines. `ClassicController.categoryAllowed` validates only new rounds; a revocation cannot mutate the frozen current round. Invalid next selection is adjusted with acknowledgement before another Start/replay.
- `ClassicHome` keeps contextual category sheet mounted beneath `PremiumSheet`; entitlement validation adds desired category to draft only. Settings keeps Premium management available after subscribing. Audited legacy grants come from `CLASSIC_LEGACY_RIGHTS_JSON`, never inferred from category/package names. See `docs/classic/STAGE_6.md` for configuration and pending sandbox acceptance.
