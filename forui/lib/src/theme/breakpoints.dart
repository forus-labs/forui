import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The responsive breakpoints based on [Tailwind CSS](https://tailwindcss.com/docs/responsive-design).
///
/// All breakpoints are in logical pixels. It is not recommended to change the default breakpoints unless
/// you absolutely know what you are doing.
///
/// Usage:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   final theme = context.theme; // FThemeData
///   final size = MediaQuery.sizeOf(context); // Size
///   if (theme.breakpoints.sm.contains(size)) {
///     // Do something when the sm breakpoint is active.
///     return SizedBox.square(dimension: 100);
///
///   } else {
///     return SizedBox.square(dimension: 500);
///   }
/// }
/// ```
///
/// Additional breakpoints can be added via an extension on this class:
/// ```dart
/// extension CustomBreakpoints on FBreakpoints {
///   FBreakpoint get custom => const FBreakpoint(min: 100, max: 200);
/// }
/// ```
///
/// After which, the custom breakpoint can be accessed like so:
/// ```dart {5}
/// @override
/// Widget build(BuildContext context) {
///   final theme = context.theme; // FThemeData
///   final size = MediaQuery.sizeOf(context); // Size
///   if (theme.breakpoints.custom.contains(size)) {
///     // Do something when the custom breakpoint is active.
///     return SizedBox.square(dimension: 100);
///
///   } else {
///     return SizedBox.square(dimension: 500);
///   }
/// }
/// ```
final class FBreakpoints with Diagnosticable {
  /// The extra small breakpoint. Defaults to `0 <= width < 640`.
  final FBreakpoint xs;

  /// The small breakpoint. Defaults to `640 < width < 768`.
  final FBreakpoint sm;

  /// The medium breakpoint. Defaults to `768 < width < 1024`.
  final FBreakpoint md;

  /// The large breakpoint. Defaults to `1024 < width < 1280`.
  final FBreakpoint lg;

  /// The extra large breakpoint. Defaults to `1280 < width < 1536`.
  final FBreakpoint xl;

  /// The extra extra large breakpoint. Defaults to `1536 < width`.
  final FBreakpoint xl2;

  /// Creates a [FBreakpoints].
  const FBreakpoints({
    this.xs = const FBreakpoint(max: 640),
    this.sm = const FBreakpoint(min: 640, max: 768),
    this.md = const FBreakpoint(min: 768, max: 1024),
    this.lg = const FBreakpoint(min: 1024, max: 1280),
    this.xl = const FBreakpoint(min: 1280, max: 1536),
    this.xl2 = const FBreakpoint(min: 1536),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBreakpoints &&
          runtimeType == other.runtimeType &&
          xs == other.xs &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xl2 == other.xl2;

  @override
  int get hashCode => xs.hashCode ^ sm.hashCode ^ md.hashCode ^ lg.hashCode ^ xl.hashCode ^ xl2.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('xs', xs))
      ..add(DiagnosticsProperty('sm', sm))
      ..add(DiagnosticsProperty('md', md))
      ..add(DiagnosticsProperty('lg', lg))
      ..add(DiagnosticsProperty('xl', xl))
      ..add(DiagnosticsProperty('xl2', xl2));
  }
}

/// An adaptive breakpoint.
final class FBreakpoint with Diagnosticable {
  /// The minimum width, inclusive. Defaults to negative infinity.
  final double min;

  /// The maximum width, inclusive. Defaults to infinity.
  final double max;

  /// Creates a [FBreakpoint].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [min] is negative.
  /// * [max] is negative.
  /// * [min] < [max].
  const FBreakpoint({
    double? min,
    double? max,
  })  : assert(min == null || 0 < min, 'min must be non-negative'),
        assert(max == null || 0 < max, 'max must non-negative'),
        assert(min == null || max == null || min <= max, 'min must be less than or equal to max'),
        min = min ?? double.negativeInfinity,
        max = max ?? double.infinity;

  /// Returns true if the [size] is within this breakpoint.
  bool contains(Size size) => min <= size.width && size.width <= max;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBreakpoint && runtimeType == other.runtimeType && min == other.min && max == other.max;

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('min', min))
      ..add(DoubleProperty('max', max));
  }
}
