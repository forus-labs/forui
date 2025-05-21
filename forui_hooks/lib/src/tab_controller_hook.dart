import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FTabController] that is automatically disposed.
FTabController useFTabController({
  required int length,
  int initialIndex = 0,
  TickerProvider? vsync,
  Duration? animationDuration,
  List<Object?>? keys,
}) => use(
  _TabControllerHook(
    initialIndex: initialIndex,
    length: length,
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    animationDuration: animationDuration,
    keys: keys,
  ),
);

class _TabControllerHook extends Hook<FTabController> {
  final int initialIndex;
  final int length;
  final TickerProvider vsync;
  final Duration? animationDuration;

  const _TabControllerHook({
    required this.initialIndex,
    required this.length,
    required this.vsync,
    required this.animationDuration,
    super.keys,
  });

  @override
  _TabControllerHookState createState() => _TabControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('initialIndex', initialIndex))
      ..add(IntProperty('length', length))
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('animationDuration', animationDuration));
  }
}

class _TabControllerHookState
    extends HookState<FTabController, _TabControllerHook> {
  late final FTabController _controller = FTabController(
    initialIndex: hook.initialIndex,
    length: hook.length,
    vsync: hook.vsync,
    animationDuration: hook.animationDuration,
  );

  @override
  FTabController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTabController';
}
