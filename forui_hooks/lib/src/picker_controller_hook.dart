import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FPickerController] that is automatically disposed.
FPickerController useFPickerController({required List<int> indexes, List<Object?>? keys}) =>
    use(_PickerControllerHook(indexes: indexes, keys: keys));

class _PickerControllerHook extends Hook<FPickerController> {
  final List<int> indexes;

  const _PickerControllerHook({required this.indexes, super.keys});

  @override
  _PickerControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('indexes', indexes));
  }
}

class _PickerControllerHookState extends HookState<FPickerController, _PickerControllerHook> {
  late final _controller = FPickerController(indexes: hook.indexes);

  @override
  FPickerController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFPickerController';
}
