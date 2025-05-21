import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FTimePickerController] that is automatically disposed.
FTimePickerController useFTimePickerController({
  FTime initial = const FTime(),
  List<Object?>? keys,
}) => use(_TimePickerControllerHook(initial: initial, keys: keys));

class _TimePickerControllerHook extends Hook<FTimePickerController> {
  final FTime initial;

  const _TimePickerControllerHook({required this.initial, super.keys});

  @override
  _TimePickerControllerHookState createState() =>
      _TimePickerControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('initial', initial));
  }
}

class _TimePickerControllerHookState
    extends HookState<FTimePickerController, _TimePickerControllerHook> {
  late final FTimePickerController _controller = FTimePickerController(
    initial: hook.initial,
  );

  @override
  FTimePickerController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTimePickerController';
}
