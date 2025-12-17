import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedController extends InheritedModel<UniqueKey> {
  static final extendable = UniqueKey();

  static final pixels = UniqueKey();

  static final pixelConstraints = UniqueKey();

  static InheritedController of(BuildContext context, [UniqueKey? aspect]) {
    assert(debugCheckHasAncestor<InheritedController>('$FSlider', context));
    return InheritedModel.inheritFrom<InheritedController>(context, aspect: aspect)!;
  }

  final FSliderController controller;
  final FTooltipController? minTooltipController;
  final FTooltipController? maxTooltipController;
  final FSliderValue _value;

  InheritedController({
    required this.controller,
    required this.minTooltipController,
    required this.maxTooltipController,
    required super.child,
    super.key,
  }) : _value = controller.value;

  @override
  bool updateShouldNotify(InheritedController old) =>
      _value != old._value ||
      controller != old.controller ||
      minTooltipController != old.minTooltipController ||
      maxTooltipController != old.maxTooltipController;

  @override
  bool updateShouldNotifyDependent(covariant InheritedController old, Set<UniqueKey> dependencies) =>
      controller != old.controller ||
      minTooltipController != old.minTooltipController ||
      maxTooltipController != old.maxTooltipController ||
      dependencies.contains(pixels) && _value.pixels != old._value.pixels ||
      dependencies.contains(pixelConstraints) && _value.pixelConstraints != old._value.pixelConstraints ||
      dependencies.contains(extendable) && controller.active != old.controller.active;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('minTooltipController', minTooltipController))
      ..add(DiagnosticsProperty('maxTooltipController', maxTooltipController));
  }
}
