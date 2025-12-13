import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'select_controller.control.dart';

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

  FSelectController._(super._value, {required this.popover, this.toggleable = false});

  @override
  set value(T? value) => super.value = toggleable && super.value == value ? null : value;

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}

class _Controller<T> extends FSelectController<T> {
  late FPopoverController _popover;
  ValueChanged<T?> _onValueChange;

  _Controller({
    required T? value,
    required TickerProvider vsync,
    required ValueChanged<T?> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : _onValueChange = onValueChange,
       super._(
         value,
         popover: popoverShown != null && onPopoverChange != null
             ? LiftedPopoverController(popoverShown, onPopoverChange, vsync: vsync, motion: popoverMotion)
             : FPopoverController(vsync: vsync, motion: popoverMotion),
       ) {
    _popover = super.popover; // This prevents the creation of two popover controllers, with one being shadowed.
  }

  void update(
    TickerProvider vsync,
    T? value,
    ValueChanged<T?> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
  ) {
    if (super.value != value) {
      super.value = value;
    }

    _onValueChange = onValueChange;
    _popover = InternalFPopoverController.updateNested(_popover, vsync, popoverShown, onPopoverChange);
  }

  @override
  set value(T? value) {
    if (super.value != value) {
      _onValueChange(value);
    }
  }

  @override
  FPopoverController get popover => _popover;
}

/// A [FSelectControl] defines how a [FSelect] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FSelectControl<T> with Diagnosticable, _$FSelectControlMixin<T> {
  /// Creates a [FSelectControl] for controlling select using lifted state.
  ///
  /// The [value] parameter contains the current selected value.
  /// The [onChange] callback is invoked when the user selects an item.
  ///
  /// Content visibility is optionally lifted - if [popoverShown] is provided, [onPopoverChange] must also be provided.
  ///
  /// ## Contract
  /// Throws [AssertionError] if only one of [popoverShown]/[onPopoverChange] is provided.
  const factory FSelectControl.lifted({
    required T? value,
    required ValueChanged<T?> onChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion motion,
  }) = Lifted<T>;

  /// Creates a [FSelectControl].
  const factory FSelectControl.managed({
    FSelectController<T>? controller,
    T? initial,
    bool toggleable,
    ValueChanged<T?>? onChange,
    FPopoverMotion? motion,
  }) = FSelectManagedControl<T>;

  const FSelectControl._();

  (FSelectController<T>, bool) _update(
    FSelectControl<T> old,
    FSelectController<T> controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

@internal
class Lifted<T> extends FSelectControl<T> with _$LiftedMixin<T> {
  @override
  final T? value;
  @override
  final ValueChanged<T?> onChange;
  @override
  final bool? popoverShown;
  @override
  final ValueChanged<bool>? onPopoverChange;
  @override
  final FPopoverMotion motion;

  const Lifted({
    required this.value,
    required this.onChange,
    this.popoverShown,
    this.onPopoverChange,
    this.motion = const FPopoverMotion(),
  }) : assert(
         (popoverShown == null) == (onPopoverChange == null),
         'popoverShown and onPopoverChange must both be provided or both be null.',
       ),
       super._();

  @override
  FSelectController<T> createController(TickerProvider vsync) => _Controller(
    value: value,
    vsync: vsync,
    onValueChange: onChange,
    popoverShown: popoverShown,
    onPopoverChange: onPopoverChange,
    popoverMotion: motion,
  );

  @override
  void _updateController(FSelectController<T> controller, TickerProvider vsync) =>
      (controller as _Controller<T>).update(vsync, value, onChange, popoverShown, onPopoverChange);
}

/// A [FSelectManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FSelectManagedControl<T> extends FSelectControl<T> with Diagnosticable, _$FSelectManagedControlMixin<T> {
  /// The controller.
  @override
  final FSelectController<T>? controller;

  /// The initial value. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final T? initial;

  /// Whether the selection is toggleable. Defaults to false.
  @override
  final bool toggleable;

  /// Called when the selected value changes.
  @override
  final ValueChanged<T?>? onChange;

  /// The popover motion. Defaults to [FPopoverMotion].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [motion] and [controller] are both provided.
  @override
  final FPopoverMotion? motion;

  /// Creates a [FSelectControl].
  const FSelectManagedControl({this.controller, this.initial, this.toggleable = false, this.onChange, this.motion})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initialValue. Set the value directly in the controller.',
      ),
      assert(
        controller == null || motion == null,
        'Cannot provide both controller and motion. Set the motion directly in the controller.',
      ),
      super._();

  @override
  FSelectController<T> createController(TickerProvider vsync) =>
      controller ??
      FSelectController<T>(
        vsync: vsync,
        value: initial,
        toggleable: toggleable,
        popoverMotion: motion ?? const FPopoverMotion(),
      );
}
