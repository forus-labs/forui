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
    _popover = InternalPopoverController.updateNested(_popover, vsync, popoverShown, onPopoverChange);
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

/// Defines how a [FSelect]'s value is controlled.
sealed class FSelectControl<T> with Diagnosticable {
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

  /// Creates a [FSelectControl] for controlling select using a controller.
  ///
  /// Either [controller] or [initial] can be provided. If neither is provided, an internal controller with no initial
  /// value is created.
  ///
  /// The [onChange] callback is invoked when the selected value changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  /// Throws [AssertionError] if both [controller] and [motion] are provided.
  const factory FSelectControl.managed({
    FSelectController<T>? controller,
    T? initial,
    bool toggleable,
    ValueChanged<T?>? onChange,
    FPopoverMotion? motion,
  }) = Managed<T>;

  const FSelectControl._();

  FSelectController<T> _create(VoidCallback callback, TickerProvider vsync);

  (FSelectController<T>, bool) _update(
    FSelectControl<T> old,
    FSelectController<T> controller,
    VoidCallback callback,
    TickerProvider vsync,
  );

  void _dispose(FSelectController<T> controller, VoidCallback callback);
}

@internal
class Lifted<T> extends FSelectControl<T> with _$LiftedFunctions<T> {
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
  FSelectController<T> _create(VoidCallback callback, TickerProvider vsync) => _Controller(
    value: value,
    vsync: vsync,
    onValueChange: onChange,
    popoverShown: popoverShown,
    onPopoverChange: onPopoverChange,
    popoverMotion: motion,
  )..addListener(callback);

  @override
  void _updateController(FSelectController<T> controller, TickerProvider vsync) =>
      (controller as _Controller<T>).update(vsync, value, onChange, popoverShown, onPopoverChange);
}

@internal
class Managed<T> extends FSelectControl<T> with Diagnosticable, _$ManagedFunctions<T> {
  @override
  final FSelectController<T>? controller;
  @override
  final T? initial;
  @override
  final bool toggleable;
  @override
  final ValueChanged<T?>? onChange;
  @override
  final FPopoverMotion? motion;

  const Managed({this.controller, this.initial, this.toggleable = false, this.onChange, this.motion})
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
  FSelectController<T> _create(VoidCallback callback, TickerProvider vsync) =>
      (controller ??
          FSelectController<T>(
            vsync: vsync,
            value: initial,
            toggleable: toggleable,
            popoverMotion: motion ?? const FPopoverMotion(),
          ))
        ..addListener(callback);
}
