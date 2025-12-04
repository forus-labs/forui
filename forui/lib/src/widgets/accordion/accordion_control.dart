import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Defines how the accordion's expanded state is controlled.
sealed class FAccordionControl {
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
}

@internal
class Lifted with Diagnosticable implements FAccordionControl {
  final bool Function(int index) expanded;
  final void Function(int index, bool expanded) onChange;

  const Lifted({required this.expanded, required this.onChange});

  // All these can be generated.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('expanded', expanded))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lifted && runtimeType == other.runtimeType && expanded == other.expanded && onChange == other.onChange;

  @override
  int get hashCode => Object.hash(expanded, onChange);
}

@internal
class Managed with Diagnosticable implements FAccordionControl {
  final FAccordionController? controller;
  final int? min;
  final int? max;
  final void Function(Set<int> expanded)? onChange;

  const Managed({this.controller, this.min, this.max, this.onChange})
    : assert(
        controller == null || (min == null && max == null),
        'Cannot provide both controller and min/max constraints',
      ),
      assert(min == null || min >= 0, 'min must be non-negative'),
      assert(max == null || min == null || max >= min, 'max must be greater than or equal to min');

  // All these can be generated.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(IntProperty('min', min, defaultValue: 0))
      ..add(IntProperty('max', max))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          min == other.min &&
          max == other.max &&
          onChange == other.onChange;

  @override
  int get hashCode => Object.hash(controller, min, max, onChange);
}
