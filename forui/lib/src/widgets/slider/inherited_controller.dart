import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedController extends InheritedModel<UniqueKey> {
  static final extendable = UniqueKey();

  static final rawOffset = UniqueKey();

  static final rawExtent = UniqueKey();

  static FSliderController of(BuildContext context, [UniqueKey? aspect]) {
    assert(debugCheckHasAncestor<InheritedController>('$FSlider', context));
    return InheritedModel.inheritFrom<InheritedController>(context, aspect: aspect)!.controller;
  }

  final FSliderController controller;
  final FSliderSelection _selection;

  InheritedController({required this.controller, required super.child, super.key}) : _selection = controller.selection;

  @override
  bool updateShouldNotify(InheritedController old) => _selection != old._selection || controller != old.controller;

  @override
  bool updateShouldNotifyDependent(covariant InheritedController old, Set<UniqueKey> dependencies) =>
      controller != old.controller ||
      dependencies.contains(rawOffset) && _selection.rawOffset != old._selection.rawOffset ||
      dependencies.contains(rawExtent) && _selection.rawExtent != old._selection.rawExtent ||
      dependencies.contains(extendable) && controller.extendable != old.controller.extendable;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}
