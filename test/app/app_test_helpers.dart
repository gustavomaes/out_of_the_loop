import 'package:outoftheloop/src/features/game/widgets/voting_player_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pins app integration tests to English copy and stable discovery labels.
void setEnglishAppPreferences() {
  SharedPreferences.setMockInitialValues({
    'settings.language': 'en',
    'onboarding.completed': true,
  });
}

/// Selects a suspect, then explicitly commits the active player's vote.
Future<void> tapVoteAtCardIndex(WidgetTester tester, int cardIndex) async {
  final candidates = find.byType(VotingPlayerCard);
  final card = candidates.at(cardIndex);
  await tester.ensureVisible(card);
  await tester.tap(card);
  await tester.pump();
  final confirm = find.text('VOTE');
  await tester.ensureVisible(confirm);
  await tester.tap(confirm);
  await tester.pump();
}

Future<void> tapFirstEnabledVote(WidgetTester tester) =>
    tapVoteAtCardIndex(tester, 0);
