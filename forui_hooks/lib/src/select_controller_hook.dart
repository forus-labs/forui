import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FSelectController] that allows an item to be selected.
FSelectController<T> useFSelectController<T>({
  TickerProvider? vsync,
  T? value,
  Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  List<Object?>? keys,
}) => use(
  _SelectHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    value: value,
    popoverAnimationDuration: popoverAnimationDuration,
    debugLabel: 'useFSelectController',
    keys: keys,
  ),
);

class _SelectHook<T> extends Hook<FSelectController<T>> {
  final TickerProvider vsync;
  final T? value;
  final Duration popoverAnimationDuration;
  final String _debugLabel;

  const _SelectHook({
    required this.vsync,
    required this.value,
    required this.popoverAnimationDuration,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _SelectHookState<T> createState() => _SelectHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('popoverAnimationDuration', popoverAnimationDuration));
  }
}

class _SelectHookState<T> extends HookState<FSelectController<T>, _SelectHook<T>> {
  late final FSelectController<T> _controller = FSelectController<T>(
    vsync: hook.vsync,
    value: hook.value,
    popoverAnimationDuration: hook.popoverAnimationDuration,
  );

  @override
  FSelectController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}

/// Creates a [FMultiSelectController] that allows an item to be selected.
FMultiSelectController<T> useFMultiSelectController<T>({
  TickerProvider? vsync,
  Set<T>? values,
  int min = 0,
  int? max,
  Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  List<Object?>? keys,
}) => use(
  _MultiSelectHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    values: values ?? {},
    min: min,
    max: max,
    popoverAnimationDuration: popoverAnimationDuration,
    debugLabel: 'useFSelectController',
    keys: keys,
  ),
);

class _MultiSelectHook<T> extends Hook<FMultiSelectController<T>> {
  final TickerProvider vsync;
  final Set<T> values;
  final int min;
  final int? max;
  final Duration popoverAnimationDuration;
  final String _debugLabel;

  const _MultiSelectHook({
    required this.vsync,
    required this.values,
    required this.min,
    required this.max,
    required this.popoverAnimationDuration,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _MultiSelectHookState<T> createState() => _MultiSelectHookState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(IterableProperty('values', values))
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max))
      ..add(DiagnosticsProperty('popoverAnimationDuration', popoverAnimationDuration));
  }
}

class _MultiSelectHookState<T> extends HookState<FMultiSelectController<T>, _MultiSelectHook<T>> {
  late final FMultiSelectController<T> _controller = FMultiSelectController<T>(
    vsync: hook.vsync,
    values: hook.values,
    min: hook.min,
    max: hook.max,
    popoverAnimationDuration: hook.popoverAnimationDuration,
  );

  @override
  FMultiSelectController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}
