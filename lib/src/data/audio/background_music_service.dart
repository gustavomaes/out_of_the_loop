import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Plays looping background music while the app is in the foreground.
final class BackgroundMusicService {
  BackgroundMusicService({AudioPlayer? player}) : _player = player;

  AudioPlayer? _player;
  bool musicEnabled = false;
  bool _pausedByLifecycle = false;

  static final _themeSource = AssetSource('sounds/theme.mp3');

  Future<void> applyMusicEnabled(bool enabled) async {
    musicEnabled = enabled;
    _pausedByLifecycle = false;
    if (!enabled) {
      await _stop();
      return;
    }
    await _start();
  }

  Future<void> handleAppLifecycleState(AppLifecycleState state) async {
    if (!musicEnabled || _isWidgetTest) {
      return;
    }
    switch (state) {
      case AppLifecycleState.resumed:
        if (_pausedByLifecycle) {
          _pausedByLifecycle = false;
          await _start();
        }
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        _pausedByLifecycle = true;
        await _pause();
    }
  }

  Future<void> _start() async {
    if (_isWidgetTest) {
      return;
    }
    try {
      final player = _player ??= AudioPlayer();
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(_themeSource);
    } on MissingPluginException {
      // Platform channel unavailable (e.g. some test environments).
    } on Object {
      // Ignore other playback errors.
    }
  }

  Future<void> _pause() async {
    if (_isWidgetTest) {
      return;
    }
    try {
      await _player?.pause();
    } on Object {
      // Ignore pause errors.
    }
  }

  Future<void> _stop() async {
    if (_isWidgetTest) {
      return;
    }
    try {
      await _player?.stop();
    } on Object {
      // Ignore stop errors.
    }
  }

  static bool get _isWidgetTest =>
      WidgetsBinding.instance.runtimeType.toString().contains('Test');

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}
