import 'package:meta/meta.dart';

/// A resizable's information.
final class Resized {
  /// The resized region's index.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if [index] < 0.
  final int index;

  /// True if the resized region is selected. Always false if [FResizableBox.interaction] is [F
  final bool selected;

  /// The containing resizable box's minimum and maximum height/width along the resizable axis.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if:
  /// * min <= 0
  /// * max <= 0
  /// * max <= min
  final ({double min, double max}) constraints;

  /// The resized region's current minimum and maximum offsets along the resizable axis. They are always between the
  /// [constraints].
  ///
  /// ## Contract
  /// Throws an [AssertionError] if:
  /// * min < 0
  /// * max < 0
  /// * max <= min
  final ({double min, double max}) offsets;

  /// Creates a [Resized].
  Resized({required this.index, required this.selected, required this.constraints, required this.offsets})
      : assert(0 <= index, 'Index should be non-negative, but is $index.'),
        assert(0 < constraints.min, 'Minimum constraint should be positive, but is ${constraints.min}'),
        assert(0 < constraints.max, 'Maximum constraint should be positive, but is ${constraints.max}'),
        assert(
          constraints.min < constraints.max,
          'Minimum constraint should be less than the maximum constraint, but minimum is ${constraints.min} and maximum is ${constraints.max}',
        ),
        assert(0 <= offsets.min, 'Min offset should be non-negative, but is ${offsets.min}'),
        assert(0 < offsets.max, 'Max offset should be non-negative, but is ${offsets.max}'),
        assert(
          offsets.min < offsets.max,
          'Min offset should be less than the max offset, but min is ${offsets.min} and max is ${offsets.max}',
        ),
        assert(
          constraints.min <= offsets.min && offsets.max <= constraints.max,
          'Offsets must be within $constraints. However, they are $offsets.',
        );

  /// Returns a copy of this [Resized] with the given fields replaced by the new values.
  @useResult
  Resized copyWith({
    int? index,
    bool? selected,
    double? minConstraint,
    double? maxConstraint,
    double? minOffset,
    double? maxOffset,
  }) =>
      Resized(
        index: index ?? this.index,
        selected: selected ?? this.selected,
        constraints: (
          min: minConstraint ?? constraints.min,
          max: maxConstraint ?? constraints.max,
        ),
        offsets: (
          min: minOffset ?? offsets.min,
          max: maxOffset ?? offsets.max,
        ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Resized &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          selected == other.selected &&
          constraints == other.constraints &&
          offsets == other.offsets;

  @override
  int get hashCode => index.hashCode ^ selected.hashCode ^ constraints.hashCode ^ offsets.hashCode;

  @override
  String toString() => 'Resized{index: $index, selected: $selected, constraints: $constraints, offsets: $offsets}';
}
