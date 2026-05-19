import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../domain/models/models.dart';
import '../../domain/services/vote_scoring_service.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({
    required this.players,
    this.timerSettings = const TimerSettings(),
    this.onComplete,
    VoteScoringService? scoringService,
    super.key,
  }) : scoringService = scoringService ?? const VoteScoringService();

  final List<Player> players;
  final TimerSettings timerSettings;
  final ValueChanged<List<Vote>>? onComplete;
  final VoteScoringService scoringService;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  var _voterIndex = 0;
  String? _selectedSuspectId;
  List<Vote> _votes = const [];

  Player get _activeVoter => widget.players[_voterIndex];
  bool get _allVotesCollected => _votes.length == widget.players.length;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: AppRoutes.gameVote,
      title: 'Vote',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('WHO IS OUT OF THE LOOP?', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _allVotesCollected
                ? 'All votes are in. Reveal the totals next.'
                : '${_activeVoter.name}, choose secretly.',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.md),
          if (widget.timerSettings.enabled)
            ProgressTimer(
              remainingSeconds: widget.timerSettings.durationSeconds,
              totalSeconds: widget.timerSettings.durationSeconds,
            ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: ListView.separated(
              itemCount: widget.players.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final player = widget.players[index];
                final isSelf = player.id == _activeVoter.id;
                final selected = player.id == _selectedSuspectId;

                return OtlCard(
                  selected: selected,
                  child: Row(
                    children: [
                      PlayerAvatar(name: player.name, seed: player.avatarSeed),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          player.name,
                          style: AppTypography.body.copyWith(
                            color: isSelf
                                ? AppColors.textTertiary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      OtlButton.outline(
                        label: isSelf
                            ? 'YOU'
                            : selected
                            ? 'SELECTED'
                            : 'VOTE',
                        onPressed: isSelf || _allVotesCollected
                            ? null
                            : () => setState(
                                () => _selectedSuspectId = player.id,
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OtlButton.primary(
            label: _allVotesCollected ? 'CONFIRM VOTES' : 'CONFIRM VOTE',
            onPressed: _allVotesCollected
                ? () => widget.onComplete?.call(_votes)
                : _selectedSuspectId == null
                ? null
                : _recordVote,
          ),
        ],
      ),
    );
  }

  void _recordVote() {
    final vote = Vote(voterId: _activeVoter.id, suspectId: _selectedSuspectId!);
    final nextVotes = widget.scoringService.recordVote(
      existingVotes: _votes,
      vote: vote,
    );
    setState(() {
      _votes = nextVotes;
      _selectedSuspectId = null;
      if (_voterIndex < widget.players.length - 1) {
        _voterIndex += 1;
      }
    });
  }
}
