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
      ..add(
        DiagnosticsProperty(
          'popoverAnimationDuration',
          popoverAnimationDuration,
        ),
      );
  }
}

class _SelectHookState<T>
    extends HookState<FSelectController<T>, _SelectHook<T>> {
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
