import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FMultiValueNotifier] that manages a set of elements and is automatically disposed.
///
/// The [min] and [max] number of elements allowed. Defaults to no min and max.
FMultiValueNotifier<T> useFMultiValueNotifier<T>({
  Set<T> value = const {},
  int min = 0,
  int? max,
  List<Object?>? keys,
}) => use(_MultiNotifierHook<T>(value: value, min: min, max: max, keys: keys));

class _MultiNotifierHook<T> extends Hook<FMultiValueNotifier<T>> {
  final Set<T> value;
  final int min;
  final int? max;

  const _MultiNotifierHook({required this.value, required this.min, required this.max, super.keys});

  @override
  _MultiNotifierHookState<T> createState() => _MultiNotifierHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty('value', value))
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max));
  }
}

class _MultiNotifierHookState<T> extends HookState<FMultiValueNotifier<T>, _MultiNotifierHook<T>> {
  late final _controller = FMultiValueNotifier(value: hook.value, min: hook.min, max: hook.max);

  @override
  FMultiValueNotifier<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFMultiValueNotifier';
}

/// Creates a radio [FMultiValueNotifier] that allows only one element at a time.
FMultiValueNotifier<T> useFRadioMultiValueNotifier<T>({T? value, List<Object?>? keys}) =>
    use(_RadioNotifierHook<T>(value: value, keys: keys));

class _RadioNotifierHook<T> extends Hook<FMultiValueNotifier<T>> {
  final T? value;

  const _RadioNotifierHook({required this.value, super.keys});

  @override
  _RadioNotifierHookState<T> createState() => _RadioNotifierHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('value', value));
  }
}

class _RadioNotifierHookState<T> extends HookState<FMultiValueNotifier<T>, _RadioNotifierHook<T>> {
  late final _controller = FMultiValueNotifier.radio(hook.value);

  @override
  FMultiValueNotifier<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFRadioMultiValueNotifier';
}
