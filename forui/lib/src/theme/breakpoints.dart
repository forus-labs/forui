import 'package:flutter/foundation.dart';

/// The responsive breakpoints based on [Tailwind CSS](https://tailwindcss.com/docs/responsive-design).
///
/// All breakpoints are in logical pixels. Mobile devices are typically smaller than [sm] (640), while tablet and
/// desktop devices are typically larger than than [md] (768) and [lg] (1024) respectively.
///
/// Usage:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   final breakpoints = context.theme.breakpoints; // FBreakpoints
///   final width = MediaQuery.sizeOf(context).width; // double
///
///   return switch (width) {
///     _ when width < breakpoints.sm => MobileWidget(),
///     _ when width < breakpoints.lg => TabletWidget(),
///     _ => DesktopWidget(),
///   };
/// }
/// ```
///
/// Additional breakpoints can be added via an extension on [FBreakpoints]:
/// ```dart
/// extension CustomBreakpoints on FBreakpoints {
///   double get custom => 42;
/// }
/// ```
///
/// After which, the custom breakpoint can be accessed like so:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   final breakpoints = context.theme.breakpoints; // FBreakpoints
///   final width = MediaQuery.sizeOf(context).width; // double
///
///   return switch (width) {
///     _ when width < breakpoints.custom => SuperSmallWidget(),
///     _ when width < breakpoints.sm => MobileWidget(),
///     _ when width < breakpoints.lg => TabletWidget(),
///     _ => DesktopWidget(),
///   };
/// }
/// ```
final class FBreakpoints with Diagnosticable {
  /// The minimum width of the small breakpoint, inclusive. Defaults to 640.
  ///
  /// Mobile devices are typically smaller than [sm].
  final double sm;

  /// The minimum width of the medium breakpoint, inclusive. Defaults to 768.
  ///
  /// Tablet decides are typically larger than [md].
  final double md;

  /// The minimum width of the large breakpoint, inclusive. Defaults to 1024.
  final double lg;

  /// The minimum width of the extra large breakpoint, inclusive. Defaults to 1280.
  final double xl;

  /// The minimum width of the extra extra large breakpoint, inclusive. Defaults to 1536.
  final double xl2;

  /// Creates a [FBreakpoints].
  const FBreakpoints({this.sm = 640, this.md = 768, this.lg = 1024, this.xl = 1280, this.xl2 = 1536});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBreakpoints &&
          runtimeType == other.runtimeType &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xl2 == other.xl2;

  @override
  int get hashCode => sm.hashCode ^ md.hashCode ^ lg.hashCode ^ xl.hashCode ^ xl2.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('sm', sm, defaultValue: 640))
      ..add(DoubleProperty('md', md, defaultValue: 768))
      ..add(DoubleProperty('lg', lg, defaultValue: 1024))
      ..add(DoubleProperty('xl', xl, defaultValue: 1280))
      ..add(DoubleProperty('xl2', xl2, defaultValue: 1536));
  }
}
