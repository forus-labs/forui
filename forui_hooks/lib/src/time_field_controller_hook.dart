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
  FTime? initialTime,
  FormFieldValidator<FTime> validator = _defaultValidator,
  List<Object?>? keys,
}) => use(
  _TimeFieldHook(initialTime: initialTime, validator: validator, debugLabel: 'useFTimeFieldController', keys: keys),
);

class _TimeFieldHook extends Hook<FTimeFieldController> {
  final FTime? initialTime;
  final FormFieldValidator<FTime> validator;
  final String _debugLabel;

  const _TimeFieldHook({
    required this.initialTime,
    required this.validator,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _TimeFieldHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('initialTime', initialTime))
      ..add(ObjectFlagProperty.has('validator', validator));
  }
}

class _TimeFieldHookState extends HookState<FTimeFieldController, _TimeFieldHook> {
  late final _controller = FTimeFieldController(initialTime: hook.initialTime, validator: hook.validator);

  @override
  FTimeFieldController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
