import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedController extends InheritedModel<UniqueKey> {
  static final extendable = UniqueKey();

  static final rawOffset = UniqueKey();

  static final rawExtent = UniqueKey();

  static InheritedController of(BuildContext context, [UniqueKey? aspect]) {
    assert(debugCheckHasAncestor<InheritedController>('$FSlider', context));
    return InheritedModel.inheritFrom<InheritedController>(context, aspect: aspect)!;
  }

  final FSliderController controller;
  final FTooltipController? minTooltipController;
  final FTooltipController? maxTooltipController;
  final FSliderSelection _selection;

  InheritedController({
    required this.controller,
    required this.minTooltipController,
    required this.maxTooltipController,
    required super.child,
    super.key,
  }) : _selection = controller.selection;

  @override
  bool updateShouldNotify(InheritedController old) =>
      _selection != old._selection ||
      controller != old.controller ||
      minTooltipController != old.minTooltipController ||
      maxTooltipController != old.maxTooltipController;

  @override
  bool updateShouldNotifyDependent(covariant InheritedController old, Set<UniqueKey> dependencies) =>
      controller != old.controller ||
      minTooltipController != old.minTooltipController ||
      maxTooltipController != old.maxTooltipController ||
      dependencies.contains(rawOffset) && _selection.pixels != old._selection.pixels ||
      dependencies.contains(rawExtent) && _selection.pixelConstraints != old._selection.pixelConstraints ||
      dependencies.contains(extendable) && controller.extendable != old.controller.extendable;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('min', minTooltipController))
      ..add(DiagnosticsProperty('max', maxTooltipController));
  }
}
