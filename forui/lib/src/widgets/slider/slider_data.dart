import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FSlider] filled region's data.
final class FSliderData with Diagnosticable {
  /// This filled region's minimum and maximum extent along the main axis, in logical pixels.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  final ({double min, double current, double max, double total}) extent;

  /// This filled region's current minimum and maximum offset along the main axis, in logical pixels.
  ///
  /// Both offsets are relative to the origin of the slider, determined by [FSlider.layout]. For example, the offsets in
  /// a slider with [Layout.rtl] will start from the right edge of the slider.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min < 0
  /// * max <= min
  /// * `extent.total` <= max
  final ({double min, double max}) offset;

  /// Creates a [FSliderData].
  FSliderData({
    required ({double min, double max, double total}) extent,
    required this.offset,
  })  : assert(0 < extent.min, 'Min extent should be positive, but is ${extent.min}'),
        assert(
        extent.min < extent.max,
        'Min extent should be less than the max extent, but min is ${extent.min} and max is ${extent.max}',
        ),
        assert(
        extent.max <= extent.total,
        'Max extent should be less than or equal to the total extent, but max is ${extent.max} and total is ${extent.total}',
        ),
        assert(0 <= offset.min, 'Min offset should be non-negative, but is ${offset.min}'),
        assert(
        offset.min < offset.max,
        'Min offset should be less than the max offset, but min is ${offset.min} and max is ${offset.max}',
        ),
        assert(
        0 <= offset.max - offset.min && offset.max - offset.min <= extent.max,
        'Current extent should be non-negative and less than or equal to the max extent, but current is '
            '${offset.max - offset.min} and max is ${extent.max}.',
        ),
        extent = (min: extent.min, current: offset.max - offset.min, max: extent.max, total: extent.total);

  /// Returns a copy of this [FSliderData] with the given fields replaced by the new values.
  @useResult
  FSliderData copyWith({
    double? minExtent,
    double? maxExtent,
    double? minOffset,
    double? maxOffset,
  }) =>
      FSliderData(
        extent: (min: minExtent ?? extent.min, max: maxExtent ?? extent.max, total: extent.total),
        offset: (min: minOffset ?? offset.min, max: maxOffset ?? offset.max),
      );

  /// The offsets as a percentage of the [FSlider]'s size.
  ///
  /// For example, if the offsets are `(200, 400)`, and the [FSlider]'s size is 500, [offsetPercentage] will be
  /// `(0.4, 0.8)`.
  ({double min, double max}) get offsetPercentage => (min: offset.min / extent.total, max: offset.max / extent.total);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FSliderData && runtimeType == other.runtimeType && extent == other.extent && offset == other.offset;

  @override
  int get hashCode => extent.hashCode ^ offset.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('extent.min', extent.min))
      ..add(DoubleProperty('extent.current', extent.current))
      ..add(DoubleProperty('extent.max', extent.max))
      ..add(DoubleProperty('extent.total', extent.total))
      ..add(DoubleProperty('offset.min', offset.min))
      ..add(DoubleProperty('offset.max', offset.max))
      ..add(DoubleProperty('offsetPercentage.min', offsetPercentage.min))
      ..add(DoubleProperty('offsetPercentage.max', offsetPercentage.max));
  }
}
