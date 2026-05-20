import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Plays short UI sound effects when enabled in settings.
final class SoundEffectsService {
  SoundEffectsService({AudioPlayer? player}) : _player = player;

  AudioPlayer? _player;

  bool soundEffectsEnabled = true;

  static final _buttonSource = AssetSource('sounds/button.mp3');

  Future<void> playButtonTap() async {
    if (!soundEffectsEnabled || _isWidgetTest) {
      return;
    }
    try {
      final player = _player ??= AudioPlayer();
      await player.play(_buttonSource);
    } on MissingPluginException {
      // Platform channel unavailable (e.g. some test environments).
    } on Object {
      // Ignore other playback errors.
    }
  }

  static bool get _isWidgetTest =>
      WidgetsBinding.instance.runtimeType.toString().contains('Test');

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}
