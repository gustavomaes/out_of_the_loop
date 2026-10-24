import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../shared/widgets/otl_neon_action.dart';
import '../../theme/theme.dart';
import 'widgets/active_player_banner.dart';
import 'widgets/question_card.dart';

class FreeClueScreen extends StatefulWidget {
  const FreeClueScreen({
    required this.players,
    required this.outPlayerId,
    this.onComplete,
    this.onBack,
    super.key,
  });
  final List<Player> players;
  final String outPlayerId;
  final VoidCallback? onComplete;
  final VoidCallback? onBack;
  @override
  State<FreeClueScreen> createState() => _FreeClueScreenState();
}

class _FreeClueScreenState extends State<FreeClueScreen> {
  late final List<Player> _order;
  int _index = 0;
  bool _done = false;
  @override
  void initState() {
    super.initState();
    _order = List.of(widget.players)..shuffle(Random());
    if (_order.first.id == widget.outPlayerId) {
      final first = _order.removeAt(0);
      _order.add(first);
    }
  }

  Future<void> _back() => confirmExitGameOnBack(context, onBack: widget.onBack);
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) unawaited(_back());
      },
      child: Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(onBack: _back, showSettings: false),
        body: SafeArea(
          top: false,
          child: OtlContentWidth(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!_done)
                            ActivePlayerBanner(
                              player: _order[_index],
                              statusLabel: l10n.freeMode,
                            ),
                          const SizedBox(height: 20),
                          QuestionCard(
                            questionText: _done
                                ? l10n.cluesReady
                                : l10n.freeClueTitle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            l10n.freeClueBody,
                            style: DisplayTypography.plusJakartaBody(
                              color: BrutalistColors.sectionLabel,
                              fontSize: 16,
                            ),
                          ),
                          if (!_done)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                '${_index + 1} / ${_order.length}',
                                style: DisplayTypography.spaceGroteskMeta(
                                  color: BrutalistColors.sectionLabel,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (_done) ...[
                    OtlNeonAction(
                      label: l10n.voteNow,
                      onPressed: widget.onComplete,
                    ),
                    const SizedBox(height: 10),
                    OtlNeonAction(
                      label: l10n.anotherLap,
                      primary: false,
                      onPressed: () => setState(() {
                        _index = 0;
                        _done = false;
                      }),
                    ),
                  ] else
                    OtlNeonAction(
                      label: l10n.clueDone,
                      onPressed: () => setState(() {
                        if (_index == _order.length - 1) {
                          _done = true;
                        } else {
                          _index++;
                        }
                      }),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
