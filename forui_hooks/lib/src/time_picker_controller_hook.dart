import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FTimePickerController] that is automatically disposed.
FTimePickerController useFTimePickerController({FTime time = const FTime(), List<Object?>? keys}) =>
    use(_TimePickerControllerHook(time: time, keys: keys));

class _TimePickerControllerHook extends Hook<FTimePickerController> {
  final FTime time;

  const _TimePickerControllerHook({required this.time, super.keys});

  @override
  _TimePickerControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('time', time));
  }
}

class _TimePickerControllerHookState extends HookState<FTimePickerController, _TimePickerControllerHook> {
  late final _controller = FTimePickerController(time: hook.time);

  @override
  FTimePickerController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTimePickerController';
}
