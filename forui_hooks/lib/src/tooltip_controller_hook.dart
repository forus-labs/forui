import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FTooltipController] that is automatically disposed.
FTooltipController useFTooltipController({
  TickerProvider? vsync,
  Duration animationDuration = const Duration(milliseconds: 100),
  List<Object?>? keys,
}) =>
    use(_TooltipControllerHook(
      vsync: vsync ??= useSingleTickerProvider(keys: keys),
      animationDuration: animationDuration,
      keys: keys,
    ));

class _TooltipControllerHook extends Hook<FTooltipController> {
  final TickerProvider vsync;
  final Duration animationDuration;

  const _TooltipControllerHook({
    required this.vsync,
    required this.animationDuration,
    super.keys,
  });

  @override
  _TooltipControllerHookState createState() => _TooltipControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('vsync', vsync))
      ..add(DiagnosticsProperty('duration', animationDuration));
  }
}

class _TooltipControllerHookState extends HookState<FTooltipController, _TooltipControllerHook> {
  late final FTooltipController _controller = FTooltipController(
    vsync: hook.vsync,
    animationDuration: hook.animationDuration,
  );

  @override
  FTooltipController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFTooltipController';
}
