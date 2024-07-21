import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A [FResizable]'s data.
final class FResizableData with Diagnosticable {
  /// The resizable's index.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [index] < 0.
  final int index;

  /// True if the resized region is selected. Always false if [FResizableBox.interaction] is
  /// [FResizableInteraction.resize].
  final bool selected;

  /// The containing resizable box's minimum and maximum height/width along the resizable axis.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= 0
  /// * max <= min
  final ({double min, double max}) constraints;

  /// The resizable's current minimum and maximum height/width along the resizable axis. They are always between
  /// the [constraints].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min < 0
  /// * max < 0
  /// * max <= min
  final ({double min, double max}) offsets;

  /// Creates a [FResizableData].
  FResizableData({required this.index, required this.selected, required this.constraints, required this.offsets})
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
          0 <= offsets.min && offsets.max <= constraints.max,
          'Offsets must be within $constraints. However, they are $offsets.',
        );

  /// Returns a copy of this [FResizableData] with the given fields replaced by the new values.
  ///
  /// ```dart
  /// final data = FResizableData(
  ///   index: 1,
  ///   selected: false,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = data.copyWith(selected: true);
  /// print(copy.index); // 1
  /// print(copy.selected); // true
  /// ```
  @useResult
  FResizableData copyWith({
    int? index,
    bool? selected,
    double? minConstraint,
    double? maxConstraint,
    double? minOffset,
    double? maxOffset,
  }) =>
      FResizableData(
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

  /// The offsets as a percentage of the containing box's total size.
  ({double min, double max}) get percentage => (min: offsets.min / constraints.max, max: offsets.max / constraints.max);

  /// The size.
  double get size => offsets.max - offsets.min;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableData &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          selected == other.selected &&
          constraints == other.constraints &&
          offsets == other.offsets;

  @override
  int get hashCode => index.hashCode ^ selected.hashCode ^ constraints.hashCode ^ offsets.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', ifFalse: 'unselected'))
      ..add(DoubleProperty('minConstraint', constraints.min))
      ..add(DoubleProperty('maxConstraint', constraints.max))
      ..add(DoubleProperty('minOffset', offsets.min))
      ..add(DoubleProperty('maxOffset', offsets.max))
      ..add(DoubleProperty('minPercentage', percentage.min))
      ..add(DoubleProperty('maxPercentage', percentage.max))
      ..add(DoubleProperty('size', size));
  }
}

@internal
extension UpdatableResizableData on FResizableData {
  /// Updates the current height/width, returning an offset with any shrinkage beyond the minimum height/width removed.
  @useResult
  (FResizableData, Offset) update(AxisDirection direction, Offset delta) {
    final (:min, :max) = offsets;
    final Offset(:dx, :dy) = delta;

    switch (direction) {
      case AxisDirection.left:
        final (data, x) = _resize(direction, min + dx, max);
        return (data, delta.translate(x, 0));

      case AxisDirection.right:
        final (data, x) = _resize(direction, min, max + dx);
        return (data, delta.translate(-x, 0));

      case AxisDirection.up:
        final (data, y) = _resize(direction, min + dy, max);
        return (data, delta.translate(0, y));

      case AxisDirection.down:
        final (data, y) = _resize(direction, min, max + dy);
        return (data, delta.translate(0, -y));
    }
  }

  (FResizableData, double) _resize(AxisDirection direction, double min, double max) {
    final size = max - min;
    assert(size <= constraints.max, '$size should be less than ${constraints.max}.');

    if (constraints.min <= size) {
      return (copyWith(minOffset: min, maxOffset: max), 0);
    }



    switch (direction) {
      case AxisDirection.left || AxisDirection.up when offsets.min < (max - constraints.min):
        return (copyWith(minOffset: max - constraints.min), size - constraints.min);

      case AxisDirection.right || AxisDirection.down when (min + constraints.min) < offsets.max:
        return (copyWith(maxOffset: min + constraints.min), size - constraints.min);

      case _:
        return (this, 0);
    }
  }
}
