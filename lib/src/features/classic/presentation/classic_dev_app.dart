import '../../../l10n/out_of_the_loop_localizations.dart';
import '../application/classic_experience.dart';
import 'package:flutter/material.dart';
import '../../../data/classic/classic_content_repository.dart';
import '../../../domain/classic/classic_models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/classic_controller.dart';
import 'classic_components.dart';
import 'classic_home.dart';

class ClassicDevApp extends StatelessWidget {
  const ClassicDevApp({
    super.key,
    this.textScaler,
    this.home,
    this.locale,
    this.experience,
  });
  final ClassicExperience? experience;
  final Locale? locale;
  final TextScaler? textScaler;
  final Widget? home;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([?experience]),
    builder: (context, _) => MaterialApp(
      theme: CoralTokens.theme,
      locale: experience?.locale ?? locale,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: experience == null
            ? child!
            : ClassicExperienceScope(experience: experience!, child: child!),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: OutOfTheLoopLocalizations.supportedLocales,
      localeResolutionCallback: (locale, _) =>
          OutOfTheLoopLocalizations.resolve(locale),
      home: home ?? const ClassicHome(),
    ),
  );
}

class ClassicGallery extends StatefulWidget {
  const ClassicGallery({super.key});
  @override
  State<ClassicGallery> createState() => _ClassicGalleryState();
}

class _ClassicGalleryState extends State<ClassicGallery> {
  late final controller = ClassicController(
    content: const ClassicContentRepository(),
    config: ClassicConfig(
      players: const [
        ClassicPlayer(id: '1', name: 'Alex'),
        ClassicPlayer(id: '2', name: 'Sam'),
        ClassicPlayer(id: '3', name: 'Robin'),
      ],
      categoryIds: {'food', 'animals', 'sports'},
    ),
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.classicDevTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Text(l.classicFixtureNotice),
            const SizedBox(height: 24),
            ClassicCard(
              child: Text(
                '${controller.config.players.length} · '
                '${controller.content.wordsFor(controller.config).length}',
              ),
            ),
            const SizedBox(height: 16),
            ClassicSwitch(
              label: l.classicHint,
              value: controller.config.hint,
              onChanged: (value) {
                final current = controller.config;
                if (controller.updateConfig(
                  ClassicConfig(
                    players: current.players,
                    categoryIds: current.categoryIds,
                    contentLanguage: current.contentLanguage,
                    manualImpostors: current.manualImpostors,
                    hint: value,
                    timerMinutes: current.timerMinutes,
                    troll: current.troll,
                  ),
                )) {
                  setState(() {});
                }
              },
            ),
            ClassicSwitch(label: l.classicHint, value: false),
            ClassicButton(
              label: l.classicSheet,
              onPressed: () => showClassicSheet(
                context,
                title: l.classicSheet,
                child: ClassicButton(
                  label: MaterialLocalizations.of(context).closeButtonLabel,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ClassicButton(label: l.classicUnavailable),
            const SizedBox(height: 16),
            ClassicButton(label: l.classicLoading, loading: true),
            const SizedBox(height: 16),
            ClassicCard(
              error: l.classicError,
              child: Text(l.classicFixtureNotice),
            ),
            ClassicButton(
              label: l.classicRetry,
              error: l.classicError,
              onPressed: () => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }
}
