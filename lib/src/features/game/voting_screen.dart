import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/voting_confirm_cta.dart';
import 'widgets/voting_headline.dart';
import 'widgets/voting_player_card.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({
    required this.players,
    this.onComplete,
    VoteScoringService? scoringService,
    this.onBack,
    super.key,
  }) : scoringService = scoringService ?? const VoteScoringService();

  final List<Player> players;
  final ValueChanged<List<Vote>>? onComplete;
  final VoteScoringService scoringService;
  final VoidCallback? onBack;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  var _voterIndex = 0;
  List<Vote> _votes = const [];

  Player get _activeVoter => widget.players[_voterIndex];
  bool get _allVotesCollected => _votes.length == widget.players.length;

  Future<void> _onBackPressed() async {
    await confirmExitGameOnBack(context, onBack: widget.onBack);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final votingDisabled = _allVotesCollected;

    return BrutalistScreenTheme.wrap(
      context,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            unawaited(_onBackPressed());
          }
        },
        child: Scaffold(
          appBar: OtlBrutalistDiscoveryAppBar(
            onBack: _onBackPressed,
            showSettings: false,
          ),
          body: Stack(
          fit: StackFit.expand,
          children: [
            const OtlPartyAtmosphere.voting(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, viewport) {
                  final compact = viewport.maxHeight < 700;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    VotingHeadline(l10n: l10n),
                                    SizedBox(height: compact ? 16 : 24),
                                    ...widget.players.asMap().entries.map(
                                      (entry) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: entry.key <
                                                  widget.players.length - 1
                                              ? 16
                                              : 0,
                                        ),
                                        child: VotingPlayerCard(
                                          player: entry.value,
                                          index: entry.key,
                                          isSelf:
                                              entry.value.id ==
                                              _activeVoter.id,
                                          voteLabel: l10n.votingVote,
                                          youLabel: l10n.votingYou,
                                          cannotVoteSelfLabel:
                                              l10n.votingCannotVoteSelf,
                                          onVote: votingDisabled
                                              ? null
                                              : () => _recordVote(
                                                  entry.value.id,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_allVotesCollected)
                              VotingConfirmCta(
                                label: l10n.confirmVotes,
                                onPressed: () =>
                                    widget.onComplete?.call(_votes),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  void _recordVote(String suspectId) {
    if (_allVotesCollected) {
      return;
    }

    final vote = Vote(voterId: _activeVoter.id, suspectId: suspectId);
    final nextVotes = widget.scoringService.recordVote(
      existingVotes: _votes,
      vote: vote,
    );
    setState(() {
      _votes = nextVotes;
      if (_voterIndex < widget.players.length - 1) {
        _voterIndex += 1;
      }
    });
  }
}
