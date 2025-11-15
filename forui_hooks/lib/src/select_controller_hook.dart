import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FSelectController] that allows an item to be selected.
FSelectController<T> useFSelectController<T>({
  TickerProvider? vsync,
  T? value,
  FPopoverMotion popoverMotion = const FPopoverMotion(),
  List<Object?>? keys,
}) => use(
  _SelectHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    value: value,
    popoverMotion: popoverMotion,
    debugLabel: 'useFSelectController',
    keys: keys,
  ),
);

class _SelectHook<T> extends Hook<FSelectController<T>> {
  final TickerProvider vsync;
  final T? value;
  final FPopoverMotion popoverMotion;
  final String _debugLabel;

  const _SelectHook({
    required this.vsync,
    required this.value,
    required this.popoverMotion,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _SelectHookState<T> createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('popoverMotion', popoverMotion));
  }
}

class _SelectHookState<T> extends HookState<FSelectController<T>, _SelectHook<T>> {
  late final _controller = FSelectController<T>(
    vsync: hook.vsync,
    value: hook.value,
    popoverMotion: hook.popoverMotion,
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
  Set<T>? value,
  int min = 0,
  int? max,
  FPopoverMotion popoverMotion = const FPopoverMotion(),
  List<Object?>? keys,
}) => use(
  _MultiSelectHook(
    vsync: vsync ?? useSingleTickerProvider(keys: keys),
    value: value ?? {},
    min: min,
    max: max,
    popoverMotion: popoverMotion,
    debugLabel: 'useFMultiSelectController',
    keys: keys,
  ),
);

class _MultiSelectHook<T> extends Hook<FMultiSelectController<T>> {
  final TickerProvider vsync;
  final Set<T> value;
  final int min;
  final int? max;
  final FPopoverMotion popoverMotion;
  final String _debugLabel;

  const _MultiSelectHook({
    required this.vsync,
    required this.value,
    required this.min,
    required this.max,
    required this.popoverMotion,
    required String debugLabel,
    super.keys,
  }) : _debugLabel = debugLabel;

  @override
  _MultiSelectHookState<T> createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(IterableProperty('value', value))
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max))
      ..add(DiagnosticsProperty('popoverMotion', popoverMotion));
  }
}

class _MultiSelectHookState<T> extends HookState<FMultiSelectController<T>, _MultiSelectHook<T>> {
  late final _controller = FMultiSelectController<T>(
    vsync: hook.vsync,
    value: hook.value,
    min: hook.min,
    max: hook.max,
    popoverMotion: hook.popoverMotion,
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
