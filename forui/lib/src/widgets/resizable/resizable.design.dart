// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'resizable.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FResizableStyleTransformations on FResizableStyle {
  /// Returns a copy of this [FResizableStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableStyle.horizontalDividerStyle] - The horizontal divider style.
  /// * [FResizableStyle.verticalDividerStyle] - The vertical divider style.
  @useResult
  FResizableStyle copyWith({
    FResizableDividerStyle Function(FResizableDividerStyle style)? horizontalDividerStyle,
    FResizableDividerStyle Function(FResizableDividerStyle style)? verticalDividerStyle,
  }) => FResizableStyle(
    horizontalDividerStyle: horizontalDividerStyle != null
        ? horizontalDividerStyle(this.horizontalDividerStyle)
        : this.horizontalDividerStyle,
    verticalDividerStyle: verticalDividerStyle != null
        ? verticalDividerStyle(this.verticalDividerStyle)
        : this.verticalDividerStyle,
  );

  /// Linearly interpolate between this and another [FResizableStyle] using the given factor [t].
  @useResult
  FResizableStyle lerp(FResizableStyle other, double t) => FResizableStyle(
    horizontalDividerStyle: horizontalDividerStyle.lerp(other.horizontalDividerStyle, t),
    verticalDividerStyle: verticalDividerStyle.lerp(other.verticalDividerStyle, t),
  );
}

mixin _$FResizableStyleFunctions on Diagnosticable {
  FResizableDividerStyle get horizontalDividerStyle;
  FResizableDividerStyle get verticalDividerStyle;

  /// Returns itself.
  ///
  /// Allows [FResizableStyle] to replace functions that accept and return a [FResizableStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableStyle Function(FResizableStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableStyle(...));
  /// ```
  @useResult
  FResizableStyle call(Object? _) => this as FResizableStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalDividerStyle', horizontalDividerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('verticalDividerStyle', verticalDividerStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableStyle &&
          horizontalDividerStyle == other.horizontalDividerStyle &&
          verticalDividerStyle == other.verticalDividerStyle);

  @override
  int get hashCode => horizontalDividerStyle.hashCode ^ verticalDividerStyle.hashCode;
}
