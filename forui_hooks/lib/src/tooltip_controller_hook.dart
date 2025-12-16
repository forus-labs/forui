import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FTooltipController] that is automatically disposed.
FTooltipController useFTooltipController({
  TickerProvider? vsync,
  bool shown = false,
  FTooltipMotion motion = const FTooltipMotion(),
  List<Object?>? keys,
}) => use(
  _TooltipControllerHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    shown: shown,
    motion: motion,
    keys: keys,
  ),
);

class _TooltipControllerHook extends Hook<FTooltipController> {
  final TickerProvider vsync;
  final bool shown;
  final FTooltipMotion motion;

  const _TooltipControllerHook({required this.vsync, required this.shown, required this.motion, super.keys});

  @override
  _TooltipControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(FlagProperty('shown', value: shown, ifTrue: 'shown'))
      ..add(DiagnosticsProperty('motion', motion));
  }
}

class _TooltipControllerHookState extends HookState<FTooltipController, _TooltipControllerHook> {
  late final _controller = FTooltipController(vsync: hook.vsync, shown: hook.shown, motion: hook.motion);

  @override
  FTooltipController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTooltipController';
}
