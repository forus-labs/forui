import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

String? _defaultValidator(FTime? _) => null;

/// Creates a [FTimeFieldController] that allows time selection through a picker or input field and is automatically
/// disposed.
///
/// [validator] returns an error string to display if the input is invalid, or null otherwise.
/// Defaults to always returning null.
FTimeFieldController useFTimeFieldController({
  FTime? time,
  FormFieldValidator<FTime> validator = _defaultValidator,
  List<Object?>? keys,
}) => use(_TimeFieldHook(time: time, validator: validator, keys: keys));

class _TimeFieldHook extends Hook<FTimeFieldController> {
  final FTime? time;
  final FormFieldValidator<FTime> validator;

  const _TimeFieldHook({required this.time, required this.validator, super.keys});

  @override
  _TimeFieldHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('time', time))
      ..add(ObjectFlagProperty.has('validator', validator));
  }
}

class _TimeFieldHookState extends HookState<FTimeFieldController, _TimeFieldHook> {
  late final _controller = FTimeFieldController(time: hook.time, validator: hook.validator);

  @override
  FTimeFieldController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTimeFieldController';
}
