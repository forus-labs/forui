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
  /// * [FSelectStyle.selectFieldStyle] - The select field's style.
  /// * [FSelectStyle.iconStyle] - The select field's icon style.
  /// * [FSelectStyle.popoverStyle] - The popover's style.
  /// * [FSelectStyle.searchStyle] - The search's style.
  /// * [FSelectStyle.contentStyle] - The content's style.
  /// * [FSelectStyle.emptyTextStyle] - The default text style when there are no results.
  @useResult
  FSelectStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? selectFieldStyle,
    IconThemeData? iconStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FSelectSearchStyle Function(FSelectSearchStyle style)? searchStyle,
    FSelectContentStyle Function(FSelectContentStyle style)? contentStyle,
    TextStyle? emptyTextStyle,
  }) => FSelectStyle(
    selectFieldStyle: selectFieldStyle != null ? selectFieldStyle(this.selectFieldStyle) : this.selectFieldStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    searchStyle: searchStyle != null ? searchStyle(this.searchStyle) : this.searchStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectStyle] using the given factor [t].
  @useResult
  FSelectStyle lerp(FSelectStyle other, double t) => FSelectStyle(
    selectFieldStyle: selectFieldStyle.lerp(other.selectFieldStyle, t),
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    searchStyle: searchStyle.lerp(other.searchStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    emptyTextStyle: TextStyle.lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
  );
}

mixin _$FSelectStyleFunctions on Diagnosticable {
  FTextFieldStyle get selectFieldStyle;
  IconThemeData get iconStyle;
  FPopoverStyle get popoverStyle;
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
      ..add(DiagnosticsProperty('selectFieldStyle', selectFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('searchStyle', searchStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectStyle &&
          selectFieldStyle == other.selectFieldStyle &&
          iconStyle == other.iconStyle &&
          popoverStyle == other.popoverStyle &&
          searchStyle == other.searchStyle &&
          contentStyle == other.contentStyle &&
          emptyTextStyle == other.emptyTextStyle);

  @override
  int get hashCode =>
      selectFieldStyle.hashCode ^
      iconStyle.hashCode ^
      popoverStyle.hashCode ^
      searchStyle.hashCode ^
      contentStyle.hashCode ^
      emptyTextStyle.hashCode;
}
