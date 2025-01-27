import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FPickerController] that is automatically disposed.
FPickerController useFPickerController({
  required List<int> initialIndexes,
  List<Object?>? keys,
}) =>
    use(_PickerControllerHook(
      initialIndexes: initialIndexes,
      keys: keys,
    ));

class _PickerControllerHook extends Hook<FPickerController> {
  final List<int> initialIndexes;

  const _PickerControllerHook({
    required this.initialIndexes,
    super.keys,
  });

  @override
  _PickerControllerHookState createState() => _PickerControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('initialIndexes', initialIndexes));
  }
}

class _PickerControllerHookState extends HookState<FPickerController, _PickerControllerHook> {
  late final FPickerController _controller = FPickerController(initialIndexes: hook.initialIndexes);

  @override
  FPickerController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFPickerController';
}
