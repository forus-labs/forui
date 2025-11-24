import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FTooltipController] that is automatically disposed.
FTooltipController useFTooltipController({
  TickerProvider? vsync,
  FTooltipMotion motion = const FTooltipMotion(),
  List<Object?>? keys,
}) => use(
  _TooltipControllerHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    motion: motion,
    keys: keys,
  ),
);

class _TooltipControllerHook extends Hook<FTooltipController> {
  final TickerProvider vsync;
  final FTooltipMotion motion;

  const _TooltipControllerHook({required this.vsync, required this.motion, super.keys});

  @override
  _TooltipControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('motion', motion));
  }
}

class _TooltipControllerHookState extends HookState<FTooltipController, _TooltipControllerHook> {
  late final _controller = FTooltipController(vsync: hook.vsync, motion: hook.motion);

  @override
  FTooltipController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTooltipController';
}
