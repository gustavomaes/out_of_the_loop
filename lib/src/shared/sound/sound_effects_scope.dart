import 'package:flutter/material.dart';

import '../../data/audio/sound_effects_service.dart';

/// Provides [SoundEffectsService] to the widget tree for button tap sounds.
class SoundEffectsScope extends InheritedWidget {
  const SoundEffectsScope({
    required this.service,
    required super.child,
    super.key,
  });

  final SoundEffectsService service;

  static SoundEffectsService? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SoundEffectsScope>()
        ?.service;
  }

  @override
  bool updateShouldNotify(SoundEffectsScope oldWidget) {
    return oldWidget.service != service;
  }
}

/// Wraps [callback] so a button tap sound plays when sound effects are enabled.
VoidCallback? otlTap(BuildContext context, VoidCallback? callback) {
  if (callback == null) {
    return null;
  }
  return () {
    SoundEffectsScope.maybeOf(context)?.playButtonTap();
    callback();
  };
}
