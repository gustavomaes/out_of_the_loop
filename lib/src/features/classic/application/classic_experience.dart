import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/analytics/classic_analytics.dart';
import '../../../data/audio/background_music_service.dart';
import '../../../data/audio/sound_effects_service.dart';
import '../../../data/review/store_review_gateway.dart';

enum ClassicActionResult {
  opened,
  copied,
  completed,
  cancelled,
  unavailable,
  failed,
}

class ClassicExperience extends ChangeNotifier with WidgetsBindingObserver {
  ClassicExperience({
    this.persist = true,
    ClassicAnalytics? analytics,
    this.launch,
    this.reviewGateway,
  }) : analytics = analytics ?? ClassicAnalytics();
  final Future<bool> Function(Uri)? launch;
  final StoreReviewGateway? reviewGateway;
  Future<bool> _launch(Uri uri) =>
      launch?.call(uri) ?? launchUrl(uri, mode: LaunchMode.externalApplication);
  final bool persist;
  final ClassicAnalytics analytics;
  final music = BackgroundMusicService();
  final effects = SoundEffectsService();
  Locale? locale;
  bool musicEnabled = false;
  bool soundEnabled = true;
  bool hapticsEnabled = true;
  static const channel = MethodChannel('classic/share');
  static const appUrl = String.fromEnvironment('CLASSIC_APP_URL');
  static const supportEmail = String.fromEnvironment('CLASSIC_SUPPORT_EMAIL');

  Future<void> load() async {
    WidgetsBinding.instance.addObserver(this);
    if (!persist) return;
    try {
      final p = await SharedPreferences.getInstance();
      final parts = p.getString('settings.language')?.split('-');
      if (parts != null) {
        locale = Locale(
          parts.first,
          parts.first == 'pt' ? 'BR' : (parts.length > 1 ? parts[1] : null),
        );
      }
      musicEnabled = p.getBool('settings.music') ?? false;
      soundEnabled = p.getBool('settings.soundEffects') ?? true;
      hapticsEnabled = p.getBool('settings.haptics') ?? true;
      effects.soundEffectsEnabled = soundEnabled;
      await music.applyMusicEnabled(musicEnabled);
    } on Object {
      // Preferences and audio are optional; no raw errors enter telemetry.
    }
  }

  Future<bool> change(String key, Object value) async {
    try {
      if (persist) {
        final p = await SharedPreferences.getInstance();
        final saved = value is bool
            ? await p.setBool(key, value)
            : await p.setString(key, value as String);
        if (!saved) return false;
      }
      switch (key) {
        case 'settings.language':
          final parts = (value as String).split('-');
          locale = Locale(
            parts.first,
            parts.first == 'pt' ? 'BR' : (parts.length > 1 ? parts[1] : null),
          );
        case 'settings.music':
          musicEnabled = value as bool;
          await music.applyMusicEnabled(musicEnabled);
        case 'settings.soundEffects':
          soundEnabled = value as bool;
          effects.soundEffectsEnabled = soundEnabled;
        case 'settings.haptics':
          hapticsEnabled = value as bool;
      }
      notifyListeners();
      return true;
    } on Object {
      return false;
    }
  }

  void tap() {
    effects.playButtonTap();
    if (hapticsEnabled) _haptic();
  }

  Future<void> _haptic() async {
    try {
      await HapticFeedback.selectionClick();
    } on Object {
      /* optional */
    }
  }

  Future<ClassicActionResult> share({String url = appUrl}) async {
    analytics.record(ClassicEvent.shareRequested);
    final uri = Uri.tryParse(url);
    if (uri?.scheme != 'https' ||
        uri?.host != 'apps.apple.com' ||
        !RegExp(r'/id\d+').hasMatch(uri!.path)) {
      return ClassicActionResult.unavailable;
    }
    try {
      final result = await channel.invokeMethod<String>('share', url);
      if (result == 'completed') {
        analytics.record(ClassicEvent.shareCompleted);
        return ClassicActionResult.completed;
      }
      if (result == 'cancelled') {
        analytics.record(ClassicEvent.shareCancelled);
        return ClassicActionResult.cancelled;
      }
      return ClassicActionResult.failed;
    } on MissingPluginException {
      try {
        await Clipboard.setData(ClipboardData(text: url));
        analytics.record(ClassicEvent.shareCopied);
        return ClassicActionResult.copied;
      } on Object {
        return ClassicActionResult.failed;
      }
    } on Object {
      return ClassicActionResult.failed;
    }
  }

  Future<ClassicActionResult> feedback({String email = supportEmail}) async {
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return ClassicActionResult.unavailable;
    }
    try {
      if (!await _launch(Uri(scheme: 'mailto', path: email))) {
        return ClassicActionResult.failed;
      }
      analytics.record(ClassicEvent.feedbackOpened);
      return ClassicActionResult.opened;
    } on Object {
      return ClassicActionResult.failed;
    }
  }

  Future<ClassicActionResult> review() async {
    analytics.record(ClassicEvent.reviewRequested);
    try {
      await (reviewGateway ?? InAppStoreReviewGateway()).requestReview();
      return ClassicActionResult.opened;
    } on Object {
      return ClassicActionResult.failed;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    music.handleAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    music.dispose();
    effects.dispose();
    super.dispose();
  }
}

class ClassicExperienceScope extends InheritedNotifier<ClassicExperience> {
  const ClassicExperienceScope({
    super.key,
    required ClassicExperience experience,
    required super.child,
  }) : super(notifier: experience);
  static ClassicExperience? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<ClassicExperienceScope>()
      ?.notifier;
}
