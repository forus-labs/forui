import 'package:flutter/widgets.dart';

/// A responsive breakpoint.
final class FBreakpoint {
  /// The minimum height and width. Defaults to negative infinity.
  final ({double width, double height}) min;

  /// The maximum height and width. Defaults to infinity.
  final ({double width, double height}) max;

  /// Creates a [FBreakpoint].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [minWidth] is not finite
  /// * [minHeight] is not finite
  /// * [maxWidth] is not finite
  /// * [maxHeight] is not finite
  /// * [maxWidth] < [minWidth]
  /// * [maxHeight] < [minHeight]
  FBreakpoint({
    double? minWidth,
    double? minHeight,
    double? maxWidth,
    double? maxHeight,
  })  : assert(minWidth == null || minWidth.isFinite, 'minWidth must be finite'),
        assert(minHeight == null || minHeight.isFinite, 'minHeight must be finite'),
        assert(maxHeight == null || maxHeight.isFinite, 'maxHeight must be finite'),
        assert(maxWidth == null || maxWidth.isFinite, 'maxWidth must be finite'),
        assert(minWidth == null || maxWidth == null || minWidth <= maxWidth, 'minWidth must be <= maxWidth'),
        assert(minHeight == null || maxHeight == null || minHeight <= maxHeight, 'minHeight must <= maxHeight'),
        min = (width: minWidth ?? double.negativeInfinity, height: minHeight ?? double.negativeInfinity),
        max = (width: maxWidth ?? double.infinity, height: maxHeight ?? double.infinity);

  /// Returns true if the [size] is within this breakpoint.
  bool contains(Size size) =>
      min.width <= size.width && max.width >= size.width && min.height <= size.height && max.height >= size.height;

  /// Returns true if this breakpoint is larger than the other breakpoint.
  bool operator >(FBreakpoint other) =>
      min.width > other.min.width &&
      max.width > other.max.width &&
      min.height > other.min.height &&
      max.height > other.max.height;

  /// Returns true if this breakpoint is less than the other breakpoint.
  bool operator <(FBreakpoint other) =>
      max.width < other.max.width &&
      min.width < other.min.width &&
      max.height < other.max.height &&
      min.height < other.min.height;

  /// Returns true if this breakpoint is greater than or equal to the other breakpoint.
  bool operator >=(FBreakpoint other) =>
      min.width >= other.min.width &&
      max.width >= other.max.width &&
      min.height >= other.min.height &&
      max.height >= other.max.height;

  /// Returns true if this breakpoint is less than or equal to the other breakpoint.
  bool operator <=(FBreakpoint breakpoint) =>
      max.width <= breakpoint.max.width &&
      min.width <= breakpoint.min.width &&
      max.height <= breakpoint.max.height &&
      min.height <= breakpoint.min.height;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBreakpoint && runtimeType == other.runtimeType && min == other.min && max == other.max;

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  String toString() => 'FBreakpoint(min: $min, max: $max)';
}
