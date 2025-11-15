import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

typedef _Create = FResizableController Function(_ResizableControllerHook);

/// Creates a [FResizableController] that allows only a single date to be selected and is automatically disposed.
FResizableController useFResizableController({
  void Function(List<FResizableRegionData> resized)? onResizeUpdate,
  void Function(List<FResizableRegionData> resized)? onResizeEnd,
  List<Object?>? keys,
}) => use(
  _ResizableControllerHook(
    onResizeUpdate: onResizeUpdate,
    onResizeEnd: onResizeEnd,
    debugLabel: 'useFResizableController',
    create: (hook) => .new(onResizeUpdate: hook.onResizeUpdate, onResizeEnd: hook.onResizeEnd),
  ),
);

/// Creates a [FResizableController] that cascades shrinking of a region below their minimum extents to its neighbours
/// and is automatically disposed.
FResizableController useFCascadeResizableController({
  void Function(List<FResizableRegionData> resized)? onResizeUpdate,
  void Function(List<FResizableRegionData> resized)? onResizeEnd,
  List<Object?>? keys,
}) => use(
  _ResizableControllerHook(
    onResizeUpdate: onResizeUpdate,
    onResizeEnd: onResizeEnd,
    debugLabel: 'useFResizableCascadeController',
    create: (hook) => .cascade(onResizeUpdate: hook.onResizeUpdate, onResizeEnd: hook.onResizeEnd),
    keys: keys,
  ),
);

class _ResizableControllerHook extends Hook<FResizableController> {
  final void Function(List<FResizableRegionData> resized)? onResizeUpdate;
  final void Function(List<FResizableRegionData> resized)? onResizeEnd;
  final String _debugLabel;
  final _Create _create;

  const _ResizableControllerHook({
    required this.onResizeUpdate,
    required this.onResizeEnd,
    required String debugLabel,
    required _Create create,
    super.keys,
  }) : _debugLabel = debugLabel,
       _create = create;

  @override
  _ResizableControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('onResizeUpdate', onResizeUpdate))
      ..add(ObjectFlagProperty.has('onResizeEnd', onResizeEnd));
  }
}

class _ResizableControllerHookState<T> extends HookState<FResizableController, _ResizableControllerHook> {
  late final FResizableController _controller;

  @override
  void initHook() => _controller = hook._create(hook);

  @override
  FResizableController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
