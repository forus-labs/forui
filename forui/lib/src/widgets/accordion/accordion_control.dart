import 'package:flutter/foundation.dart';

import 'package:forui/src/widgets/accordion/accordion_controller.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'accordion_control.control.dart';

/// Defines how the accordion's expanded state is controlled.
sealed class FAccordionControl with Diagnosticable {
  /// Creates a [FAccordionControl] for controlling an accordion using lifted state.
  ///
  /// The [expanded] function should return true if the item at the given index is expanded. It must be idempotent.
  /// The [onChange] callback is invoked when the user toggles an item.
  const factory FAccordionControl.lifted({
    required bool Function(int index) expanded,
    required void Function(int index, bool expanded) onChange,
  }) = Lifted;

  /// Creates a [FAccordionControl] for controlling an accordion using a controller.
  ///
  /// Either [controller], or [min]/[max] constraints should be provided. If neither is provided, an internal controller
  /// with no min and max is created.
  ///
  /// The [onChange] callback is invoked when the expanded state changes, receiving the set of currently expanded indices.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [min]/[max] are provided.
  const factory FAccordionControl.managed({
    FAccordionController? controller,
    int? min,
    int? max,
    void Function(Set<int> expanded)? onChange,
  }) = Managed;

  const FAccordionControl._();

  FAccordionController _create(VoidCallback callback, int children);

  FAccordionController _update(
    FAccordionControl old,
    FAccordionController controller,
    VoidCallback callback,
    int children,
  );

  void _dispose(FAccordionController controller, VoidCallback callback);
}

@internal
final class Lifted extends FAccordionControl with _$LiftedFunctions {
  @override
  final bool Function(int index) expanded;
  @override
  final void Function(int index, bool expanded) onChange;

  const Lifted({required this.expanded, required this.onChange}) : super._();

  @override
  FAccordionController _create(VoidCallback _, int children) => LiftedController(expanded, onChange, children);

  @override
  void _updateController(FAccordionController controller, int children) =>
      (controller as LiftedController).update(expanded, onChange, children);
}

@internal
final class Managed extends FAccordionControl with _$ManagedFunctions {
  @override
  final FAccordionController? controller;
  @override
  final int? min;
  @override
  final int? max;
  @override
  final void Function(Set<int> expanded)? onChange;

  const Managed({this.controller, this.min, this.max, this.onChange})
    : assert(
        controller == null || (min == null && max == null),
        'Cannot provide both controller and min/max constraints',
      ),
      assert(min == null || min >= 0, 'min must be non-negative'),
      assert(max == null || min == null || max >= min, 'max must be greater than or equal to min'),
      super._();

  @override
  FAccordionController _create(VoidCallback callback, int children) =>
      (controller ?? .new(min: min ?? 0, max: max))..addListener(callback);
}
