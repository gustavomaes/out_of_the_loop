import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/theme.dart';
import 'widgets/voting_confirm_cta.dart';
import 'widgets/voting_headline.dart';
import 'widgets/voting_player_card.dart';
import 'widgets/voting_timer_dock.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({
    required this.players,
    this.timerSettings = const TimerSettings(),
    this.remainingSeconds,
    this.onComplete,
    VoteScoringService? scoringService,
    this.onBack,
    this.onSettings,
    super.key,
  }) : scoringService = scoringService ?? const VoteScoringService();

  final List<Player> players;
  final TimerSettings timerSettings;
  final int? remainingSeconds;
  final ValueChanged<List<Vote>>? onComplete;
  final VoteScoringService scoringService;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  var _voterIndex = 0;
  List<Vote> _votes = const [];

  Player get _activeVoter => widget.players[_voterIndex];
  bool get _allVotesCollected => _votes.length == widget.players.length;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final remainingSeconds =
        widget.remainingSeconds ?? widget.timerSettings.durationSeconds;
    final timerExpired = widget.timerSettings.enabled && remainingSeconds == 0;
    final votingDisabled = timerExpired || _allVotesCollected;

    return BrutalistScreenTheme.wrap(
      context,
      Scaffold(
        appBar: OtlBrutalistDiscoveryAppBar(
          onBack: widget.onBack ?? () => context.pop(),
          onSettings: widget.onSettings,
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
                  final bottomInset = _allVotesCollected
                      ? (compact ? 100.0 : 112.0)
                      : widget.timerSettings.enabled
                      ? (compact ? 120.0 : 140.0)
                      : 24.0;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset),
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
                                    if (timerExpired && !_allVotesCollected)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                        ),
                                        child: OtlTimerExpiredMessage(
                                          line1: l10n.votingTimerExpiredLine1,
                                          line2: l10n.votingTimerExpiredLine2,
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
            if (widget.timerSettings.enabled && !_allVotesCollected)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: VotingTimerDock(
                  timeToVoteLabel: l10n.votingTimeToVote,
                  secondsLabel: l10n.votingTimeSeconds(remainingSeconds),
                  remainingSeconds: remainingSeconds,
                  totalSeconds: widget.timerSettings.durationSeconds,
                ),
              ),
          ],
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
