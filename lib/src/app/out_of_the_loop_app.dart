import 'dart:async';

import 'package:flutter/material.dart';

import '../data/analytics/analytics_service.dart';
import '../data/audio/background_music_service.dart';
import '../data/audio/sound_effects_service.dart';
import '../data/preferences/preferences_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../l10n/out_of_the_loop_localizations.dart';
import '../shared/sound/sound_effects_scope.dart';
import '../theme/theme.dart';
import 'app_router.dart';
import 'game_flow_controller.dart';

class OutOfTheLoopApp extends StatefulWidget {
  const OutOfTheLoopApp({
    this.preferencesRepository = const PreferencesRepository(),
    super.key,
  });

  final PreferencesRepository preferencesRepository;

  @override
  State<OutOfTheLoopApp> createState() => _OutOfTheLoopAppState();
}

class _OutOfTheLoopAppState extends State<OutOfTheLoopApp>
    with WidgetsBindingObserver {
  final _flow = GameFlowController();
  final _analytics = AnalyticsService();
  final _soundEffects = SoundEffectsService();
  final _backgroundMusic = BackgroundMusicService();
  final _routerRefresh = ValueNotifier<int>(0);
  late final AppRouter _appRouter = AppRouter(
    flow: _flow,
    analytics: _analytics,
    preferencesRepository: widget.preferencesRepository,
    soundEffects: _soundEffects,
    backgroundMusic: _backgroundMusic,
    refreshListenable: _routerRefresh,
    onFlowChanged: _notifyFlowChanged,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _restorePreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _routerRefresh.dispose();
    _soundEffects.dispose();
    _backgroundMusic.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    unawaited(_backgroundMusic.handleAppLifecycleState(state));
  }

  @override
  Widget build(BuildContext context) {
    return SoundEffectsScope(
      service: _soundEffects,
      child: MaterialApp.router(
        title: 'Out of the Loop',
        debugShowCheckedModeBanner: false,
        theme: OutOfTheLoopTheme.dark,
        locale: OutOfTheLoopLocalizations.localeFor(_flow.language),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: OutOfTheLoopLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) =>
            OutOfTheLoopLocalizations.resolve(locale),
        routerConfig: _appRouter.router,
      ),
    );
  }

  void _notifyFlowChanged() {
    setState(() {});
    _routerRefresh.value++;
  }

  Future<void> _restorePreferences() async {
    final preferences = await widget.preferencesRepository.load();
    if (!mounted) {
      return;
    }
    final languageChanged = _flow.language != preferences.language;
    final musicChanged =
        _backgroundMusic.musicEnabled != preferences.musicEnabled;
    final soundChanged =
        _soundEffects.soundEffectsEnabled != preferences.soundEffectsEnabled;
    if (!languageChanged && !musicChanged && !soundChanged) {
      return;
    }
    setState(() {
      if (languageChanged) {
        _flow.language = preferences.language;
      }
      if (soundChanged) {
        _soundEffects.soundEffectsEnabled = preferences.soundEffectsEnabled;
      }
    });
    if (musicChanged) {
      unawaited(
        _backgroundMusic.applyMusicEnabled(preferences.musicEnabled),
      );
    }
    if (languageChanged) {
      _notifyFlowChanged();
    }
  }
}
