import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/doubles.dart';

/// A [FResizableRegion]'s data.
final class FResizableRegionData with Diagnosticable {
  /// The resizable region's index.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [index] < 0.
  final int index;

  /// This region's minimum and maximum extent along the main resizable axis, in logical pixels.
  ///
  /// The minimum extent is determined by [FResizableRegion.minExtent].
  /// The maximum extent is determined by the [FResizable]'s total extent - the minimum extent of all regions.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  final ({double min, double current, double max, double total}) extent;

  /// This region's current minimum and maximum offset along the main resizable axis, in logical pixels
  ///
  /// Both offsets are relative to the top/left side of the parent [FResizable].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min < 0
  /// * max <= min
  /// * `extent.total` <= `offset.max`
  final ({double min, double max}) offset;

  /// Creates a [FResizableRegionData].
  FResizableRegionData({
    required this.index,
    required ({double min, double max, double total}) extent,
    required this.offset,
  }) : assert(0 <= index, 'index ($index) must be >= 0'),
       assert(0 < extent.min, 'extent.min (${extent.min}) must be > 0'),
       assert(extent.min < extent.max, 'min ${extent.min} must be < max ${extent.max}'),
       assert(extent.max <= extent.total, 'extent.max (${extent.max}) must be <= extent.total (${extent.total})'),
       assert(0 <= offset.min, 'offset.min ${offset.min} must be >= 0'),
       assert(offset.min < offset.max, 'offset.min (${offset.min}) must be < offset.max (${offset.max})'),
       assert(
         0.0.lessOrAround(offset.max - offset.min) && (offset.max - offset.min).lessOrAround(extent.max),
         'Current extent (${offset.max - offset.min}) must be >= 0 and <= extent.max (${extent.max})',
       ),
       extent = (min: extent.min, current: offset.max - offset.min, max: extent.max, total: extent.total);

  /// Returns a copy of this [FResizableRegionData] with the given fields replaced by the new values.
  @useResult
  FResizableRegionData copyWith({
    int? index,
    double? minExtent,
    double? maxExtent,
    double? minOffset,
    double? maxOffset,
  }) => FResizableRegionData(
    index: index ?? this.index,
    extent: (min: minExtent ?? extent.min, max: maxExtent ?? extent.max, total: extent.total),
    offset: (min: minOffset ?? offset.min, max: maxOffset ?? offset.max),
  );

  /// The offsets as a percentage of the parent [FResizable]'s size.
  ///
  /// For example, if the offsets are `(200, 400)`, and the [FResizable]'s size is 500, [offsetPercentage] will be
  /// `(0.4, 0.8)`.
  ({double min, double max}) get offsetPercentage => (min: offset.min / extent.total, max: offset.max / extent.total);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizableRegionData &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          extent == other.extent &&
          offset == other.offset;

  @override
  int get hashCode => index.hashCode ^ extent.hashCode ^ offset.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('index', index))
      ..add(StringProperty('extent', extent.toString()))
      ..add(StringProperty('offset', offset.toString()))
      ..add(StringProperty('offsetPercentage', offsetPercentage.toString()));
  }
}

@internal
extension UpdatableResizableRegionData on FResizableRegionData {
  /// Returns a copy of this data with an updated extent, and an offset with any shrinkage beyond the minimum
  /// height/width removed.
  ///
  /// This method assumes that shrinking regions are computed before expanding regions.
  @useResult
  (FResizableRegionData, double translated) update(double delta, {required bool lhs}) {
    var (:min, :max) = offset;
    lhs ? min += delta : max += delta;
    final newExtent = max - min;

    assert(0 <= min, 'min ($min) must be >= 0');
    assert(newExtent.lessOrAround(extent.max), '$newExtent must be < ${extent.max}.');

    if (extent.min <= newExtent) {
      return (copyWith(minOffset: min, maxOffset: max), delta);
    }

    // In theory, the translation isn't accurate when performing cascading resizes. Given a sufficiently large delta,
    // the returned translation will be large enough to cancel out the delta and cause the cascading resize to end
    // prematurely.
    //
    // This isn't an issue in practice since a subsequent delta will be emitted out almost immediately after the first
    // delta.
    //
    // It isn't ideal but it works and I'm too dumb & lazy to address this issue properly.
    if (lhs) {
      return (
        extent.min == extent.current ? this : copyWith(minOffset: max - extent.min),
        delta + newExtent - extent.min,
      );
    } else {
      return (
        extent.min == extent.current ? this : copyWith(maxOffset: min + extent.min),
        delta - newExtent + extent.min,
      );
    }
  }
}
