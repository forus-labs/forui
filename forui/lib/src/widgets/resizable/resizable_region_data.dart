import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FResizableRegion]'s data.
final class FResizableRegionData with Diagnosticable {
  /// The resizable region's index.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [index] < 0.
  final int index;

  /// This region's minimum and maximum height/width, in logical pixels, along the main resizable axis.
  ///
  /// The minimum height/width is determined by [FResizableRegion.minSize].
  /// The maximum height/width is determined by the [FResizable]'s size - the minimum size of all regions.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= 0
  /// * max <= min
  final ({double min, double current, double max, double allRegions}) size;

  /// This region's current minimum and maximum offset, in logical pixels, along the main resizable axis.
  ///
  /// Both offsets are relative to the top/left side of the parent [FResizable], or, in other words, relative to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min < 0
  /// * max <= min
  /// * allRegions <= max
  final ({double min, double max}) offset;

  /// Creates a [FResizableRegionData].
  FResizableRegionData({
    required this.index,
    required ({double min, double max, double allRegions}) size,
    required this.offset,
  })  : assert(0 <= index, 'Index should be non-negative, but is $index.'),
        assert(0 < size.min, 'Minimum size should be positive, but is ${size.min}'),
        assert(
          size.min < size.max,
          'Min size should be less than the min size, but min is ${size.min} and maximum is ${size.max}',
        ),
        assert(
          size.max <= size.allRegions,
          'Maximum size should be less than or equal to all regions size, but maximum is ${size.max} and all regions is ${size.allRegions}',
        ),
        assert(0 <= offset.min, 'Min offset should be non-negative, but is ${offset.min}'),
        assert(0 < offset.max, 'Max offset should be non-negative, but is ${offset.max}'),
        assert(
          offset.min < offset.max,
          'Min offset should be less than the max offset, but min is ${offset.min} and max is ${offset.max}',
        ),
        assert(
          0 <= offset.max - offset.min && offset.max - offset.min <= size.max,
          'Current size should be non-negative and less than or equal to the maximum size, but current size is ${offset.max - offset.min} and maximum size is ${size.max}.',
        ),
        size = (min: size.min, current: offset.max - offset.min, max: size.max, allRegions: size.allRegions);

  /// Returns a copy of this [FResizableRegionData] with the given fields replaced by the new values.
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
  FResizableRegionData copyWith({
    int? index,
    double? minSize,
    double? maxSize,
    double? allRegionsSize,
    double? minOffset,
    double? maxOffset,
  }) =>
      FResizableRegionData(
        index: index ?? this.index,
        size: (min: minSize ?? size.min, max: maxSize ?? size.max, allRegions: allRegionsSize ?? size.allRegions),
        offset: (min: minOffset ?? offset.min, max: maxOffset ?? offset.max),
      );

  /// The offsets as a percentage of the parent [FResizable]'s size.
  ///
  /// For example, if the offsets are `(200, 400)`, and the [FResizable]'s size is 500, [offsetPercentage] will be
  /// `(0.4, 0.8)`.
  ({double min, double max}) get offsetPercentage =>
      (min: offset.min / size.allRegions, max: offset.max / size.allRegions);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableRegionData &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          size == other.size &&
          offset == other.offset;

  @override
  int get hashCode => index.hashCode ^ size.hashCode ^ offset.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(DoubleProperty('minSize', size.min))
      ..add(DoubleProperty('currentSize', size.current))
      ..add(DoubleProperty('maxSize', size.max))
      ..add(DoubleProperty('allRegionsSize', size.allRegions))
      ..add(DoubleProperty('minOffset', offset.min))
      ..add(DoubleProperty('maxOffset', offset.max))
      ..add(DoubleProperty('minOffsetPercentage', offsetPercentage.min))
      ..add(DoubleProperty('maxOffsetPercentage', offsetPercentage.max));
  }
}

@internal
extension UpdatableResizableRegionData on FResizableRegionData {
  /// Updates the current height/width, returning an offset with any shrinkage beyond the minimum height/width removed.
  @useResult
  (FResizableRegionData, Offset) update(AxisDirection direction, Offset delta) {
    final (:min, :max) = offset;
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

  (FResizableRegionData, double) _resize(AxisDirection direction, double min, double max) {
    final newSize = max - min;
    assert(0 <= min, '$min should be non-negative.');
    assert(newSize <= size.max, '$newSize should be less than ${size.max}.');

    if (size.min <= newSize) {
      return (copyWith(minOffset: min, maxOffset: max), 0);
    }

    switch (direction) {
      case AxisDirection.left || AxisDirection.up when offset.min < (max - size.min):
        return (copyWith(minOffset: max - size.min), newSize - size.min);

      case AxisDirection.right || AxisDirection.down when (min + size.min) < offset.max:
        return (copyWith(maxOffset: min + size.min), newSize - size.min);

      case _:
        return (this, newSize - size.min);
    }
  }
}
