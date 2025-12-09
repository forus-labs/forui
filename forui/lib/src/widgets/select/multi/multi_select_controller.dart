import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'multi_select_controller.control.dart';

/// The [FMultiSelect]'s controller.
class FMultiSelectController<T> extends FMultiValueNotifier<T> {
  /// The controller for the popover.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FMultiSelectController] instead.
  final FPopoverController popover;

  /// Creates a [FMultiSelectController].
  FMultiSelectController({
    required TickerProvider vsync,
    super.min,
    super.max,
    super.value,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : popover = FPopoverController(vsync: vsync, motion: popoverMotion);

  FMultiSelectController._({
    required super.value,
    required this.popover,
    super.min,
    super.max,
  });

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}

class _Controller<T> extends FMultiSelectController<T> {
  late FPopoverController _popover;
  ValueChanged<Set<T>> _onValueChange;

  _Controller({
    required super.value,
    required TickerProvider vsync,
    required ValueChanged<Set<T>> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : _onValueChange = onValueChange,
       super._(
         popover: popoverShown != null && onPopoverChange != null
             ? LiftedPopoverController(popoverShown, onPopoverChange, vsync: vsync, motion: popoverMotion)
             : FPopoverController(vsync: vsync, motion: popoverMotion),
       ) {
    _popover = super.popover; // This prevents the creation of two popover controllers, with one being shadowed.
  }

  void updateState(
    TickerProvider vsync,
    Set<T> value,
    ValueChanged<Set<T>> onValueChange,
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
  void update(T value, {required bool add}) {
    final copy = {...super.value};
    if ((add && copy.add(value)) || (!add && copy.remove(value))) {
      _onValueChange(copy);
    }
  }

  @override
  set value(Set<T> value) {
    if (super.value != value) {
      _onValueChange(value);
    }
  }

  @override
  FPopoverController get popover => _popover;
}

/// Defines how a [FMultiSelect]'s value is controlled.
sealed class FMultiSelectControl<T> with Diagnosticable, _$FMultiSelectControlMixin<T> {
  /// Creates a [FMultiSelectControl] for controlling multi-select using lifted state.
  ///
  /// The [value] parameter contains the current selected values.
  /// The [onChange] callback is invoked when the user selects or deselects an item.
  ///
  /// Content visibility is optionally lifted - if [popoverShown] is provided, [onPopoverChange] must also be provided.
  ///
  /// ## Contract
  /// Throws [AssertionError] if only one of [popoverShown]/[onPopoverChange] is provided.
  const factory FMultiSelectControl.lifted({
    required Set<T> value,
    required ValueChanged<Set<T>> onChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion motion,
  }) = Lifted<T>;

  /// Creates a [FMultiSelectControl] for controlling multi-select using a controller.
  ///
  /// Either [controller] or [initial] can be provided. If neither is provided, an internal controller with no initial
  /// values is created.
  ///
  /// The [min] and [max] parameters define the selection constraints.
  /// The [onChange] callback is invoked when the selected values change.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  /// Throws [AssertionError] if both [controller] and [min]/[max] are provided.
  /// Throws [AssertionError] if both [controller] and [motion] are provided.
  const factory FMultiSelectControl.managed({
    FMultiSelectController<T>? controller,
    Set<T>? initial,
    int min,
    int? max,
    ValueChanged<Set<T>>? onChange,
    FPopoverMotion? motion,
  }) = Managed<T>;

  const FMultiSelectControl._();

  (FMultiSelectController<T>, bool) _update(
    FMultiSelectControl<T> old,
    FMultiSelectController<T> controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

@internal
class Lifted<T> extends FMultiSelectControl<T> with _$LiftedMixin<T> {
  @override
  final Set<T> value;
  @override
  final ValueChanged<Set<T>> onChange;
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
  FMultiSelectController<T> _create(VoidCallback callback, TickerProvider vsync) => _Controller(
    value: value,
    vsync: vsync,
    onValueChange: onChange,
    popoverShown: popoverShown,
    onPopoverChange: onPopoverChange,
    popoverMotion: motion,
  )..addListener(callback);

  @override
  void _updateController(FMultiSelectController<T> controller, TickerProvider vsync) =>
      (controller as _Controller<T>).updateState(vsync, value, onChange, popoverShown, onPopoverChange);
}

@internal
class Managed<T> extends FMultiSelectControl<T> with Diagnosticable, _$ManagedMixin<T> {
  @override
  final FMultiSelectController<T>? controller;
  @override
  final Set<T>? initial;
  @override
  final int min;
  @override
  final int? max;
  @override
  final ValueChanged<Set<T>>? onChange;
  @override
  final FPopoverMotion? motion;

  const Managed({this.controller, this.initial, this.min = 0, this.max, this.onChange, this.motion})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Set the value directly in the controller.',
      ),
      assert(
        controller == null || min == 0,
        'Cannot provide both controller and min. Set the min directly in the controller.',
      ),
      assert(
        controller == null || max == null,
        'Cannot provide both controller and max. Set the max directly in the controller.',
      ),
      assert(
        controller == null || motion == null,
        'Cannot provide both controller and motion. Set the motion directly in the controller.',
      ),
      super._();

  @override
  FMultiSelectController<T> _create(VoidCallback callback, TickerProvider vsync) =>
      (controller ??
          FMultiSelectController<T>(
            vsync: vsync,
            value: initial ?? {},
            min: min,
            max: max,
            popoverMotion: motion ?? const FPopoverMotion(),
          ))
        ..addListener(callback);
}
