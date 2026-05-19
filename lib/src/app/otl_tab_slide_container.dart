import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Slides between [StatefulShellRoute] branches in the direction of tab travel.
class OtlTabSlideContainer extends StatefulWidget {
  const OtlTabSlideContainer({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<OtlTabSlideContainer> createState() => _OtlTabSlideContainerState();
}

class _OtlTabSlideContainerState extends State<OtlTabSlideContainer> {
  late final PageController _pageController = PageController(
    initialPage: widget.navigationShell.currentIndex,
  );

  void _syncToIndex(int targetIndex, {required bool animate}) {
    if (!_pageController.hasClients) {
      return;
    }
    final currentIndex = _pageController.page?.round();
    if (currentIndex == targetIndex) {
      return;
    }
    if (animate) {
      _pageController.animateToPage(
        targetIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _pageController.jumpToPage(targetIndex);
    }
  }

  @override
  void didUpdateWidget(OtlTabSlideContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncToIndex(widget.navigationShell.currentIndex, animate: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _syncToIndex(widget.navigationShell.currentIndex, animate: false);

    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final child in widget.children) _KeepAliveTab(child: child),
      ],
    );
  }
}

class _KeepAliveTab extends StatefulWidget {
  const _KeepAliveTab({required this.child});

  final Widget child;

  @override
  State<_KeepAliveTab> createState() => _KeepAliveTabState();
}

class _KeepAliveTabState extends State<_KeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
