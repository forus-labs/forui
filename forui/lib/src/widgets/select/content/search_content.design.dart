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
  /// * [FSelectSearchStyle.textFieldStyle] - The search field's style.
  /// * [FSelectSearchStyle.iconStyle] - The search icon's style.
  /// * [FSelectSearchStyle.dividerStyle] - The style of the divider between the search field and results.
  /// * [FSelectSearchStyle.progressStyle] - The loading progress's style.
  @useResult
  FSelectSearchStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? textFieldStyle,
    IconThemeData? iconStyle,
    FDividerStyle Function(FDividerStyle style)? dividerStyle,
    FCircularProgressStyle Function(FCircularProgressStyle style)? progressStyle,
  }) => FSelectSearchStyle(
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    dividerStyle: dividerStyle != null ? dividerStyle(this.dividerStyle) : this.dividerStyle,
    progressStyle: progressStyle != null ? progressStyle(this.progressStyle) : this.progressStyle,
  );

  /// Linearly interpolate between this and another [FSelectSearchStyle] using the given factor [t].
  @useResult
  FSelectSearchStyle lerp(FSelectSearchStyle other, double t) => FSelectSearchStyle(
    textFieldStyle: textFieldStyle.lerp(other.textFieldStyle, t),
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
    progressStyle: progressStyle.lerp(other.progressStyle, t),
  );
}

mixin _$FSelectSearchStyleFunctions on Diagnosticable {
  FTextFieldStyle get textFieldStyle;
  IconThemeData get iconStyle;
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
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSearchStyle &&
          textFieldStyle == other.textFieldStyle &&
          iconStyle == other.iconStyle &&
          dividerStyle == other.dividerStyle &&
          progressStyle == other.progressStyle);

  @override
  int get hashCode => textFieldStyle.hashCode ^ iconStyle.hashCode ^ dividerStyle.hashCode ^ progressStyle.hashCode;
}
