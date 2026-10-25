import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../src/features/classic/presentation/classic_dev_app.dart';
import '../src/features/classic/presentation/classic_home.dart';
import '../src/features/classic/application/classic_controller.dart';
import '../src/domain/classic/classic_models.dart';
import '../src/data/classic/classic_content_repository.dart';

@Preview(name: 'Coral Social / 320', group: 'Classic', size: Size(320, 640))
Widget classicSmallPreview() => const ClassicDevApp();

@Preview(
  name: 'Coral Social / text 200%',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicLargeTextPreview() =>
    const ClassicDevApp(textScaler: TextScaler.linear(2));

@Preview(
  name: 'Coral Social / components',
  group: 'Classic',
  size: Size(320, 640),
)
Widget classicComponentsPreview() =>
    const ClassicDevApp(home: ClassicGallery());

@Preview(name: 'Classic / private role', group: 'Classic', size: Size(320, 640))
Widget classicRolePreview() => const ClassicDevApp(home: _RoundPreview());

@Preview(name: 'Classic / discussion', group: 'Classic', size: Size(320, 640))
Widget classicDiscussionPreview() =>
    const ClassicDevApp(home: _RoundPreview(discussion: true));

class _RoundPreview extends StatefulWidget {
  const _RoundPreview({this.discussion = false});
  final bool discussion;
  @override
  State<_RoundPreview> createState() => _RoundPreviewState();
}

class _RoundPreviewState extends State<_RoundPreview> {
  late final controller = ClassicController(
    content: const ClassicContentRepository(),
    config: ClassicConfig(
      players: const [
        ClassicPlayer(id: '1', name: 'Alex'),
        ClassicPlayer(id: '2', name: 'Sam'),
        ClassicPlayer(id: '3', name: 'Robin'),
      ],
      categoryIds: {'food'},
      timerMinutes: 3,
    ),
  );
  @override
  void initState() {
    super.initState();
    controller.start();
    if (widget.discussion) {
      for (var i = 0; i < 3; i++) {
        controller.markViewed(i);
        controller.nextPlayer(i);
      }
      controller.pauseTimer();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClassicHome(controller: controller);
}
