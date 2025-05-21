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
  TickerProvider? vsync,
  FTime? initialTime,
  FormFieldValidator<FTime> validator = _defaultValidator,
  Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  List<Object?>? keys,
}) => use(
  _TimeFieldHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    initialTime: initialTime,
    validator: validator,
    popoverAnimationDuration: popoverAnimationDuration,
    debugLabel: 'useFDatePickerController',
    keys: keys,
  ),
);

class _TimeFieldHook extends Hook<FTimeFieldController> {
  final TickerProvider vsync;
  final FTime? initialTime;
  final FormFieldValidator<FTime> validator;
  final Duration popoverAnimationDuration;
  final String _debugLabel;

  const _TimeFieldHook({
    required this.vsync,
    required this.initialTime,
    required this.validator,
    required this.popoverAnimationDuration,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _TimeFieldHookState createState() => _TimeFieldHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('initialTime', initialTime))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(
        DiagnosticsProperty(
          'popoverAnimationDuration',
          popoverAnimationDuration,
        ),
      );
  }
}

class _TimeFieldHookState
    extends HookState<FTimeFieldController, _TimeFieldHook> {
  late final FTimeFieldController _controller = FTimeFieldController(
    vsync: hook.vsync,
    initialTime: hook.initialTime,
    validator: hook.validator,
    popoverAnimationDuration: hook.popoverAnimationDuration,
  );

  @override
  FTimeFieldController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
