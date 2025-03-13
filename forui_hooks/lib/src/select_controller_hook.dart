import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FSelectController] that allows multiple selections and is automatically disposed.
///
/// The [min] and [max] values are the min and max number of selections allowed. Defaults to no min and max.
FSelectController<T> useFSelectController<T>({
  Set<T> values = const {},
  int min = 0,
  int? max,
  List<Object?>? keys,
}) => use(_MultiControllerHook<T>(values: values, min: min, max: max, keys: keys));

class _MultiControllerHook<T> extends Hook<FSelectController<T>> {
  final Set<T> values;
  final int min;
  final int? max;

  const _MultiControllerHook({required this.values, required this.min, required this.max, super.keys});

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

class _MultiControllerHookState<T> extends HookState<FSelectController<T>, _MultiControllerHook<T>> {
  late final _controller = FSelectController(
    values: hook.values,
    min: hook.min,
    max: hook.max,
  );

  @override
  FSelectController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFSelectController';
}

/// Creates a radio [FSelectController] that allows only one selection and is automatically disposed.
FSelectController<T> useFRadioSelectController<T>({T? value, List<Object?>? keys}) =>
    use(_RadioControllerHook<T>(value: value, keys: keys));

class _RadioControllerHook<T> extends Hook<FSelectController<T>> {
  final T? value;

  const _RadioControllerHook({required this.value, super.keys});

  @override
  _RadioControllerHookState<T> createState() => _RadioControllerHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('value', value));
  }
}

class _RadioControllerHookState<T> extends HookState<FSelectController<T>, _RadioControllerHook<T>> {
  late final _controller = FSelectController.radio(value: hook.value);

  @override
  FSelectController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFRadioSelectController';
}
