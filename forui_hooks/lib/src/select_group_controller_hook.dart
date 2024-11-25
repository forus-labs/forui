import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FRadioSelectGroupController] that allows only one selection to be selected mimicking the behaviour of
/// radio buttons and is automatically disposed.
FRadioSelectGroupController<T> useFRadioSelectGroupController<T>({
  T? value,
  List<Object?>? keys,
}) =>
    use(_RadioControllerHook<T>(value: value));

class _RadioControllerHook<T> extends Hook<FRadioSelectGroupController<T>> {
  final T? value;

  const _RadioControllerHook({
    required this.value,
    super.keys,
  });

  @override
  _RadioControllerHookState<T> createState() => _RadioControllerHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('value', value));
  }
}

class _RadioControllerHookState<T> extends HookState<FRadioSelectGroupController<T>, _RadioControllerHook<T>> {
  late final FRadioSelectGroupController<T> _controller = FRadioSelectGroupController(value: hook.value);

  @override
  FRadioSelectGroupController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFRadioSelectGroupController';
}

/// Creates a [FMultiSelectGroupController] that allows only multiple selections and is automatically disposed.
///
/// The [min] and [max] values are the minimum and maximum number of selections allowed. Defaults to no minimum or
/// maximum.
FMultiSelectGroupController<T> useFMultiSelectGroupController<T>({
  Set<T> values = const {},
  int min = 0,
  int? max,
  List<Object?>? keys,
}) =>
    use(_MultiControllerHook<T>(
      values: values,
      min: min,
      max: max,
      keys: keys,
    ));

class _MultiControllerHook<T> extends Hook<FMultiSelectGroupController<T>> {
  final Set<T> values;
  final int min;
  final int? max;

  const _MultiControllerHook({
    required this.values,
    required this.min,
    required this.max,
    super.keys,
  });

  @override
  _MultiControllerHookState<T> createState() => _MultiControllerHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty('values', values))
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max));
  }
}

class _MultiControllerHookState<T> extends HookState<FMultiSelectGroupController<T>, _MultiControllerHook<T>> {
  late final FMultiSelectGroupController<T> _controller = FMultiSelectGroupController(
    values: hook.values,
    min: hook.min,
    max: hook.max,
  );

  @override
  FMultiSelectGroupController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFMultiSelectGroupController';
}
