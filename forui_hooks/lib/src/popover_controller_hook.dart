import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FPopoverController] that is automatically disposed.
FPopoverController useFPopoverController({
  TickerProvider? vsync,
  Duration animationDuration = const Duration(milliseconds: 100),
  List<Object?>? keys,
}) =>
    use(_PopoverControllerHook(
      vsync: vsync ??= useSingleTickerProvider(keys: keys),
      animationDuration: animationDuration,
      keys: keys,
    ));

class _PopoverControllerHook extends Hook<FPopoverController> {
  final TickerProvider vsync;
  final Duration animationDuration;

  const _PopoverControllerHook({
    required this.vsync,
    required this.animationDuration,
    super.keys,
  });

  @override
  _PopoverControllerHookState createState() => _PopoverControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('duration', animationDuration));
  }
}

class _PopoverControllerHookState extends HookState<FPopoverController, _PopoverControllerHook> {
  late final FPopoverController _controller = FPopoverController(
    vsync: hook.vsync,
    animationDuration: hook.animationDuration,
  );

  @override
  FPopoverController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFPopoverController';
}
