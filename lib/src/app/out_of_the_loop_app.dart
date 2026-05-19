import 'dart:async';

import 'package:flutter/material.dart';

import '../data/preferences/preferences_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../l10n/out_of_the_loop_localizations.dart';
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

class _OutOfTheLoopAppState extends State<OutOfTheLoopApp> {
  final _flow = GameFlowController();
  final _routerRefresh = ValueNotifier<int>(0);
  late final AppRouter _appRouter = AppRouter(
    flow: _flow,
    preferencesRepository: widget.preferencesRepository,
    refreshListenable: _routerRefresh,
    onFlowChanged: _notifyFlowChanged,
  );

  @override
  void initState() {
    super.initState();
    _restorePreferences();
  }

  @override
  void dispose() {
    _routerRefresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Out of the Loop',
      debugShowCheckedModeBanner: false,
      theme: OutOfTheLoopTheme.dark,
      locale: OutOfTheLoopLocalizations.localeFor(_flow.language),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: OutOfTheLoopLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) =>
          OutOfTheLoopLocalizations.resolve(locale),
      routerConfig: _appRouter.router,
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
    if (_flow.language == preferences.language &&
        _flow.timerSettings == preferences.timerSettings) {
      return;
    }
    _notifyFlowChanged();
    setState(() {
      _flow.language = preferences.language;
      _flow.timerSettings = preferences.timerSettings;
    });
  }
}
