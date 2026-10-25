import 'dart:async';
import 'dart:ui' show ViewFocusEvent, ViewFocusState;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../domain/classic/classic_models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/classic_controller.dart';
import 'classic_components.dart';

/// Secrets exist only in this mounted screen's ephemeral presentation state.
class ClassicRoundScreen extends StatefulWidget {
  const ClassicRoundScreen({
    super.key,
    required this.controller,
    this.onPremium,
  });
  final VoidCallback? onPremium;
  final ClassicController controller;
  @override
  State<ClassicRoundScreen> createState() => _ClassicRoundScreenState();
}

class _ClassicRoundScreenState extends State<ClassicRoundScreen>
    with WidgetsBindingObserver {
  ClassicController get c => widget.controller;
  AppLocalizations get l => AppLocalizations.of(context)!;
  bool _visible = false;
  bool _dialog = false;
  int? _pointer;
  Timer? _ticker;
  Duration? _lastTick;
  static const _privacy = MethodChannel('classic/privacy');
  Future<void> _nativePrivacy(String method, [bool? enabled]) async {
    try {
      await _privacy.invokeMethod<void>(method, enabled);
    } on MissingPluginException {
      // Web, previews and widget tests have no native window.
    } on PlatformException {
      // Dart still covers secrets; native failures never log role data.
    }
  }

  void _readyFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && c.foreground) _nativePrivacy('ready');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _nativePrivacy('protect', true);
    _readyFrame();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || c.phase != ClassicPhase.discussion) return;
      final left = c.remaining;
      if (left != _lastTick) {
        _lastTick = left;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _nativePrivacy('protect', false);
    _ticker?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) _hide();
    c.setForeground(state == AppLifecycleState.resumed);
    if (state == AppLifecycleState.resumed) _readyFrame();
  }

  @override
  void didChangeViewFocus(ViewFocusEvent event) {
    if (event.state == ViewFocusState.unfocused) {
      _hide();
      c.setForeground(false);
    } else {
      c.setForeground(true);
      _readyFrame();
    }
  }

  @override
  void didChangeMetrics() => _hide();

  void _hide() {
    _pointer = null;
    if (_visible && mounted) setState(() => _visible = false);
  }

  void _show(int index) {
    if (_dialog || !c.markViewed(index)) return;
    setState(() => _visible = true);
  }

  Future<void> _confirm({required bool result}) async {
    if (_dialog) return;
    _hide();
    _dialog = true;
    final roundId = c.round!.id;
    if (!result) c.pauseTimer();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result ? l.classicRevealQuestion : l.classicExitQuestion),
        content: Text(result ? l.classicRevealWarning : l.classicExitWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.classicCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(result ? l.classicReveal : l.classicEnd),
          ),
        ],
      ),
    );
    _dialog = false;
    if (!mounted ||
        confirmed != true ||
        c.round?.id != roundId ||
        !c.foreground) {
      return;
    }
    if (result) {
      c.revealResult();
    } else {
      c.endRound();
    }
  }

  Widget _role() {
    final round = c.round!;
    final index = c.revealIndex;
    final player = round.config.players[index];
    final impostor = round.impostorIds.contains(player.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${index + 1} / ${round.config.players.length}',
          textAlign: TextAlign.center,
        ),
        Text(
          player.name,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Focus(
          onFocusChange: (focused) {
            if (!focused) _hide();
          },
          child: Listener(
            key: ValueKey('role-card-${round.id}-$index'),
            behavior: HitTestBehavior.opaque,
            onPointerDown: (event) {
              if (_pointer != null) return;
              _pointer = event.pointer;
              _show(index);
            },
            onPointerUp: (event) {
              if (_pointer == event.pointer) _hide();
            },
            onPointerCancel: (event) {
              if (_pointer == event.pointer) _hide();
            },
            child: MouseRegion(
              onExit: (_) => _hide(),
              child: Builder(
                builder: (cardContext) => Listener(
                  onPointerMove: (event) {
                    final box = cardContext.findRenderObject()! as RenderBox;
                    if (!(Offset.zero & box.size).contains(
                      box.globalToLocal(event.position),
                    )) {
                      _hide();
                    }
                  },
                  child: ClassicCard(
                    child: SizedBox(
                      height: 220,
                      child: Center(
                        child: SingleChildScrollView(
                          child: _visible && c.foreground
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      impostor
                                          ? l.classicYouImpostor
                                          : l.classicYourWord,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                    if (!impostor)
                                      Text(
                                        round.word.text,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    if (!impostor || round.config.hint)
                                      Text(
                                        round.categoryName,
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                )
                              : Text(
                                  l.classicHold,
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(l.classicRelease, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        Focus(
          onFocusChange: (focused) {
            if (!focused) _hide();
          },
          child: OutlinedButton(
            key: const Key('accessible-reveal'),
            onPressed: () => _visible ? _hide() : _show(index),
            child: Text(_visible ? l.classicHideRole : l.classicShowRole),
          ),
        ),
        const SizedBox(height: 16),
        ClassicButton(
          key: const Key('next-player'),
          label: index + 1 == round.config.players.length
              ? l.classicDiscuss
              : l.classicNext,
          onPressed: c.viewed && !_visible && c.foreground
              ? () => c.nextPlayer(index)
              : null,
        ),
      ],
    );
  }

  Widget _discussion() {
    final round = c.round!;
    final starter = round.config.players.firstWhere(
      (p) => p.id == round.starterId,
    );
    final left = c.remaining;
    final seconds = left == null ? 0 : (left.inMilliseconds / 1000).ceil();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l.classicDiscuss,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        ClassicCard(
          child: Column(
            children: [
              Text(
                l.classicStarts,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                starter.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(l.classicInPerson),
            ],
          ),
        ),
        if (left != null) ...[
          const SizedBox(height: 24),
          Text(
            '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}',
            key: const Key('discussion-timer'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          if (left == Duration.zero)
            Semantics(liveRegion: true, child: Text(l.classicTimeUp)),
          if (left > Duration.zero)
            TextButton(
              onPressed: c.timerRunning ? c.pauseTimer : c.resumeTimer,
              child: Text(c.timerRunning ? l.classicPause : l.classicResume),
            ),
        ],
        const SizedBox(height: 24),
        ClassicButton(
          label: l.classicReveal,
          onPressed: () => _confirm(result: true),
        ),
      ],
    );
  }

  Widget _result() {
    final round = c.round!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          round.troll ? l.classicTrollResult : l.classicResult,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        ClassicCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.classicYourWord),
              Text(
                round.word.text,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(round.categoryName),
              const Divider(height: 32),
              Text(
                l.classicImpostors,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              for (final p in round.config.players.where(
                (p) => round.impostorIds.contains(p.id),
              ))
                Text(p.name),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClassicButton(
          label: l.classicAgain,
          onPressed: () {
            _hide();
            if (!c.playAgain() && c.phase == ClassicPhase.result) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    c.accessAdjusted
                        ? l.classicAccessChanged
                        : l.classicContentMissing,
                  ),
                ),
              );
            }
          },
        ),
        if (widget.onPremium != null)
          TextButton(
            onPressed: widget.onPremium,
            child: Text(l.classicPremium),
          ),
        TextButton(onPressed: c.endRound, child: Text(l.classicEditGame)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) _confirm(result: false);
    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Classic'),
        leading: IconButton(
          tooltip: l.classicEnd,
          icon: const Icon(Icons.close),
          onPressed: () => _confirm(result: false),
        ),
      ),
      body: SafeArea(
        child: c.foreground
            ? ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  switch (c.phase) {
                    ClassicPhase.revealing => _role(),
                    ClassicPhase.discussion => _discussion(),
                    ClassicPhase.result => _result(),
                    _ => const SizedBox.shrink(),
                  },
                ],
              )
            : const ColoredBox(
                color: CoralTokens.canvas,
                child: SizedBox.expand(),
              ),
      ),
    ),
  );
}
