import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

String? _defaultValidator(DateTime? _) => null;

/// Creates a [FDateFieldController] that allows date selection through a calendar and/or input field and is
/// automatically disposed.
///
/// [validator] returns an error string to display if the input is invalid, or null otherwise.
/// It is also used to determine whether a date in a calendar is selectable.
/// Defaults to always returning null.
FDateFieldController useFDateFieldController({
  DateTime? date,
  FormFieldValidator<DateTime> validator = _defaultValidator,
  List<Object?>? keys,
}) => use(_DateFieldHook(date: date, validator: validator, keys: keys));

class _DateFieldHook extends Hook<FDateFieldController> {
  final DateTime? date;
  final FormFieldValidator<DateTime> validator;

  const _DateFieldHook({required this.date, required this.validator, super.keys});

  @override
  _DateFieldHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('initial', date))
      ..add(ObjectFlagProperty.has('validator', validator));
  }
}

class _DateFieldHookState extends HookState<FDateFieldController, _DateFieldHook> {
  late final _controller = FDateFieldController(date: hook.date, validator: hook.validator);

  @override
  FDateFieldController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFDateFieldController';
}
