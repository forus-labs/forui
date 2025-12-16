import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FPaginationController] that is automatically disposed.
FPaginationController useFPaginationController({
  required int pages,
  int page = 0,
  int siblings = 1,
  bool showEdges = true,
  List<Object?>? keys,
}) => use(_PaginationControllerHook(pages: pages, page: page, siblings: siblings, showEdges: showEdges, keys: keys));

class _PaginationControllerHook extends Hook<FPaginationController> {
  final int pages;
  final int page;
  final int siblings;
  final bool showEdges;

  const _PaginationControllerHook({
    required this.pages,
    required this.page,
    required this.siblings,
    required this.showEdges,
    super.keys,
  });

  @override
  _PaginationControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('pages', pages))
      ..add(IntProperty('page', page))
      ..add(IntProperty('siblings', siblings))
      ..add(FlagProperty('showEdges', value: showEdges, ifTrue: 'showEdges'));
  }
}

class _PaginationControllerHookState extends HookState<FPaginationController, _PaginationControllerHook> {
  late final _controller = FPaginationController(
    page: hook.page,
    pages: hook.pages,
    siblings: hook.siblings,
    showEdges: hook.showEdges,
  );

  @override
  FPaginationController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFPaginationController';
}
