import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FAccordionController] that is automatically disposed.
FAccordionController useFAccordionController({int min = 0, int? max, List<Object?>? keys}) =>
    use(_AccordionControllerHook(min: min, max: max, keys: keys));

class _AccordionControllerHook extends Hook<FAccordionController> {
  final int min;
  final int? max;

  const _AccordionControllerHook({required this.min, required this.max, super.keys});

  @override
  _AccordionControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max));
  }
}

class _AccordionControllerHookState extends HookState<FAccordionController, _AccordionControllerHook> {
  late final _controller = FAccordionController(min: hook.min, max: hook.max);

  @override
  FAccordionController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFAccordionController';
}
