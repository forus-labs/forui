import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FPopoverController] that is automatically disposed.
FPopoverController useFPopoverController({
  TickerProvider? vsync,
  bool shown = false,
  FPopoverMotion motion = const FPopoverMotion(),
  List<Object?>? keys,
}) => use(
  _PopoverControllerHook(
    vsync: vsync ??= useSingleTickerProvider(keys: keys),
    shown: shown,
    motion: motion,
    keys: keys,
  ),
);

class _PopoverControllerHook extends Hook<FPopoverController> {
  final TickerProvider vsync;
  final bool shown;
  final FPopoverMotion motion;

  const _PopoverControllerHook({required this.vsync, required this.shown, required this.motion, super.keys});

  @override
  _PopoverControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(FlagProperty('shown', value: shown, ifTrue: 'shown'))
      ..add(DiagnosticsProperty('motion', motion));
  }
}

class _PopoverControllerHookState extends HookState<FPopoverController, _PopoverControllerHook> {
  late final _controller = FPopoverController(vsync: hook.vsync, shown: hook.shown, motion: hook.motion);

  @override
  FPopoverController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFPopoverController';
}
