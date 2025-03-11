import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FPaginationController] that is automatically disposed.
FPaginationController useFPaginationController({
  int pages = 1,
  int initialPage = 0,
  bool showEdges = true,
  int siblings = 1,
  VoidCallback? onPageChanged,
  List<Object?>? keys,
}) => use(
  _PaginationControllerHook(
    pages: pages,
    initialPage: initialPage,
    siblings: siblings,
    showEdges: showEdges,
    onPageChanged: onPageChanged,
    debugLabel: 'useFPaginationController',
    keys: keys,
  ),
);

class _PaginationControllerHook extends Hook<FPaginationController> {
  final int pages;
  final int initialPage;
  final int siblings;
  final bool showEdges;
  final VoidCallback? onPageChanged;
  final String _debugLabel;

  const _PaginationControllerHook({
    required this.pages,
    required this.initialPage,
    required this.siblings,
    required this.showEdges,
    required this.onPageChanged,

    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _PaginationControllerHookState createState() => _PaginationControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('pages', pages))
      ..add(IntProperty('initialPage', initialPage))
      ..add(IntProperty('siblings', siblings))
      ..add(FlagProperty('showEdges', value: showEdges, ifTrue: 'showEdges'))
      ..add(ObjectFlagProperty.has('onPageChanged', onPageChanged));
  }
}

class _PaginationControllerHookState extends HookState<FPaginationController, _PaginationControllerHook> {
  late final FPaginationController _controller = FPaginationController(
    pages: hook.pages,
    initialPage: hook.initialPage,
    siblings: hook.siblings,
    showEdges: hook.showEdges,
    onPageChanged: hook.onPageChanged,
  );

  @override
  FPaginationController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
