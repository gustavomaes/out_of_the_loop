import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pins app integration tests to English copy and stable discovery labels.
void setEnglishAppPreferences() {
  SharedPreferences.setMockInitialValues({'settings.language': 'en'});
}

/// Taps the first enabled VOTE control (skips self-vote disabled buttons).
Future<void> tapFirstEnabledVote(WidgetTester tester) async {
  final voteLabels = find.text('VOTE');
  for (var index = 0; index < voteLabels.evaluate().length; index += 1) {
    final candidate = voteLabels.at(index);
    final inkWell = find.ancestor(of: candidate, matching: find.byType(InkWell));
    final widget = tester.widget<InkWell>(inkWell);
    if (widget.onTap != null) {
      await tester.ensureVisible(candidate);
      await tester.tap(candidate);
      await tester.pump();
      return;
    }
  }

  fail('No enabled vote button found');
}
