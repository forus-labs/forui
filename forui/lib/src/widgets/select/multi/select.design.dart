// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectStyleTransformations on FMultiSelectStyle {
  /// Returns a copy of this [FMultiSelectStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectStyle.fieldStyle] - The field's style.
  /// * [FMultiSelectStyle.tagStyle] - The tag's style.
  /// * [FMultiSelectStyle.popoverStyle] - The popover's style.
  /// * [FMultiSelectStyle.searchStyle] - The search's style.
  /// * [FMultiSelectStyle.contentStyle] - The content's style.
  /// * [FMultiSelectStyle.emptyTextStyle] - The default text style when there are no results.
  @useResult
  FMultiSelectStyle copyWith({
    FMultiSelectFieldStyle Function(FMultiSelectFieldStyle style)? fieldStyle,
    FMultiSelectTagStyle Function(FMultiSelectTagStyle style)? tagStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FSelectSearchStyle Function(FSelectSearchStyle style)? searchStyle,
    FSelectContentStyle Function(FSelectContentStyle style)? contentStyle,
    TextStyle? emptyTextStyle,
  }) => FMultiSelectStyle(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    tagStyle: tagStyle != null ? tagStyle(this.tagStyle) : this.tagStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    searchStyle: searchStyle != null ? searchStyle(this.searchStyle) : this.searchStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectStyle] using the given factor [t].
  @useResult
  FMultiSelectStyle lerp(FMultiSelectStyle other, double t) => FMultiSelectStyle(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    tagStyle: tagStyle.lerp(other.tagStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    searchStyle: searchStyle.lerp(other.searchStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    emptyTextStyle: TextStyle.lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
  );
}

mixin _$FMultiSelectStyleFunctions on Diagnosticable {
  FMultiSelectFieldStyle get fieldStyle;
  FMultiSelectTagStyle get tagStyle;
  FPopoverStyle get popoverStyle;
  FSelectSearchStyle get searchStyle;
  FSelectContentStyle get contentStyle;
  TextStyle get emptyTextStyle;

  /// Returns itself.
  ///
  /// Allows [FMultiSelectStyle] to replace functions that accept and return a [FMultiSelectStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FMultiSelectStyle Function(FMultiSelectStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FMultiSelectStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FMultiSelectStyle(...));
  /// ```
  @useResult
  FMultiSelectStyle call(Object? _) => this as FMultiSelectStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tagStyle', tagStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('searchStyle', searchStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectStyle &&
          fieldStyle == other.fieldStyle &&
          tagStyle == other.tagStyle &&
          popoverStyle == other.popoverStyle &&
          searchStyle == other.searchStyle &&
          contentStyle == other.contentStyle &&
          emptyTextStyle == other.emptyTextStyle);

  @override
  int get hashCode =>
      fieldStyle.hashCode ^
      tagStyle.hashCode ^
      popoverStyle.hashCode ^
      searchStyle.hashCode ^
      contentStyle.hashCode ^
      emptyTextStyle.hashCode;
}
