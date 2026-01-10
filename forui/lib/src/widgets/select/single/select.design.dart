// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectStyleTransformations on FSelectStyle {
  /// Returns a copy of this [FSelectStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectStyle.fieldStyle] - The select field's style.
  /// * [FSelectStyle.searchStyle] - The search's style.
  /// * [FSelectStyle.contentStyle] - The content's style.
  /// * [FSelectStyle.emptyTextStyle] - The default text style when there are no results.
  @useResult
  FSelectStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? fieldStyle,
    FSelectSearchStyle Function(FSelectSearchStyle style)? searchStyle,
    FSelectContentStyle Function(FSelectContentStyle style)? contentStyle,
    TextStyle? emptyTextStyle,
  }) => .new(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    searchStyle: searchStyle != null ? searchStyle(this.searchStyle) : this.searchStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectStyle] using the given factor [t].
  @useResult
  FSelectStyle lerp(FSelectStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    searchStyle: searchStyle.lerp(other.searchStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
  );
}

mixin _$FSelectStyleFunctions on Diagnosticable {
  FTextFieldStyle get fieldStyle;
  FSelectSearchStyle get searchStyle;
  FSelectContentStyle get contentStyle;
  TextStyle get emptyTextStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectStyle] to replace functions that accept and return a [FSelectStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectStyle Function(FSelectStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectStyle(...));
  /// ```
  @useResult
  FSelectStyle call(Object? _) => this as FSelectStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('searchStyle', searchStyle, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          searchStyle == other.searchStyle &&
          contentStyle == other.contentStyle &&
          emptyTextStyle == other.emptyTextStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ searchStyle.hashCode ^ contentStyle.hashCode ^ emptyTextStyle.hashCode;
}
