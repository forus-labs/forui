// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'search_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectSearchStyleTransformations on FSelectSearchStyle {
  /// Returns a copy of this [FSelectSearchStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectSearchStyle.fieldStyle] - The search field's style.
  /// * [FSelectSearchStyle.dividerStyle] - The style of the divider between the search field and results.
  /// * [FSelectSearchStyle.progressStyle] - The loading progress's style.
  @useResult
  FSelectSearchStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? fieldStyle,
    FDividerStyle Function(FDividerStyle style)? dividerStyle,
    FCircularProgressStyle Function(FCircularProgressStyle style)? progressStyle,
  }) => .new(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    dividerStyle: dividerStyle != null ? dividerStyle(this.dividerStyle) : this.dividerStyle,
    progressStyle: progressStyle != null ? progressStyle(this.progressStyle) : this.progressStyle,
  );

  /// Linearly interpolate between this and another [FSelectSearchStyle] using the given factor [t].
  @useResult
  FSelectSearchStyle lerp(FSelectSearchStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
    progressStyle: progressStyle.lerp(other.progressStyle, t),
  );
}

mixin _$FSelectSearchStyleFunctions on Diagnosticable {
  FTextFieldStyle get fieldStyle;
  FDividerStyle get dividerStyle;
  FCircularProgressStyle get progressStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectSearchStyle] to replace functions that accept and return a [FSelectSearchStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectSearchStyle Function(FSelectSearchStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectSearchStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectSearchStyle(...));
  /// ```
  @useResult
  FSelectSearchStyle call(Object? _) => this as FSelectSearchStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle, level: .debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSearchStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          dividerStyle == other.dividerStyle &&
          progressStyle == other.progressStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ dividerStyle.hashCode ^ progressStyle.hashCode;
}
