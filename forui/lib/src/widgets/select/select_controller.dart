import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedSelectController<T> extends InheritedWidget {
  static InheritedSelectController<T> of<T>(BuildContext context) {
    assert(
      debugCheckHasAncestor<InheritedSelectController<T>>('${FSelect<T>}/${FMultiSelect<T>}', context, generic: true),
    );
    return context.dependOnInheritedWidgetOfExactType<InheritedSelectController<T>>()!;
  }

  final FPopoverController popover;
  final bool Function(T) contains;
  final bool Function(T) focus;
  final ValueChanged<T> onPress;

  const InheritedSelectController({
    required this.popover,
    required this.contains,
    required this.focus,
    required this.onPress,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedSelectController<T> old) =>
      popover != old.popover || contains != old.contains || focus != old.focus || onPress != old.onPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popover', popover))
      ..add(ObjectFlagProperty.has('contains', contains))
      ..add(ObjectFlagProperty.has('focus', focus))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

/// The [FSelect]'s controller.
class FSelectController<T> extends FValueNotifier<T?> {
  /// The controller for the popover.
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
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : popover = FPopoverController(vsync: vsync, motion: popoverMotion),
       super(value);

  @override
  set value(T? value) => super.value = toggleable && super.value == value ? null : value;

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}

/// The [FMultiSelect]'s controller.
class FMultiSelectController<T> extends FMultiValueNotifier<T> {
  /// The controller for the popover.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FSelectController] instead.
  final FPopoverController popover;

  /// Creates a [FMultiSelectController].
  FMultiSelectController({
    required TickerProvider vsync,
    super.min,
    super.max,
    super.value,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : popover = FPopoverController(vsync: vsync, motion: popoverMotion);

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}
