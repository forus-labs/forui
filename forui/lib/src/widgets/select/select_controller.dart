import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class SelectControllerData<T> extends InheritedWidget {
  final FPopoverController popoverController;
  final bool Function(T) contains;
  final ValueChanged<T> onPress;

  const SelectControllerData({
    required this.popoverController,
    required this.contains,
    required this.onPress,
    required super.child,
    super.key,
  });

  static SelectControllerData<T> of<T>(BuildContext context) {
    final SelectControllerData<T>? result = context.dependOnInheritedWidgetOfExactType<SelectControllerData<T>>();
    assert(
      result != null,
      "No FSelect<$T> found in context. This is likely because Dart could not infer FSelect's type parameter. "
      'Try specifying the type parameter for FSelect, FSelectSection, and FSelectItem (e.g., FSelect<MyType>).',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(SelectControllerData<T> old) =>
      popoverController != old.popoverController || contains != old.contains || onPress != old.onPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(ObjectFlagProperty.has('contains', contains))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

/// The [FSelect]'s controller.
class FSelectController<T> extends FValueNotifier<T?> {
  /// The controller for the popover. Does nothing if the time field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FSelectController] instead.
  final FPopoverController popover;

  /// True if the items in the select can toggled (unselected). Defaults to false.
  final bool toggleable;

  /// Creates a [FSelectController].
  FSelectController({
    required TickerProvider vsync,
    T? value,
    this.toggleable = false,
    Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  }) : popover = FPopoverController(vsync: vsync, animationDuration: popoverAnimationDuration),
       super(value);

  @override
  set value(T? value) => super.value = toggleable && super.value == value ? null : value;

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}
