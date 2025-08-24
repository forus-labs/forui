// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FMultiSelectStyleCopyWith on FMultiSelectStyle {
  /// Returns a copy of this [FMultiSelectStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [fieldStyle]
  /// The field's style.
  ///
  /// # [tagStyle]
  /// The tag's style.
  ///
  /// # [popoverStyle]
  /// The popover's style.
  ///
  /// # [searchStyle]
  /// The search's style.
  ///
  /// # [contentStyle]
  /// The content's style.
  ///
  /// # [emptyTextStyle]
  /// The default text style when there are no results.
  ///
  @useResult
  FMultiSelectStyle copyWith({
    FMultiSelectFieldStyle Function(FMultiSelectFieldStyle)? fieldStyle,
    FMultiSelectTagStyle Function(FMultiSelectTagStyle)? tagStyle,
    FPopoverStyle Function(FPopoverStyle)? popoverStyle,
    FSelectSearchStyle Function(FSelectSearchStyle)? searchStyle,
    FSelectContentStyle Function(FSelectContentStyle)? contentStyle,
    TextStyle? emptyTextStyle,
  }) => FMultiSelectStyle(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    tagStyle: tagStyle != null ? tagStyle(this.tagStyle) : this.tagStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    searchStyle: searchStyle != null ? searchStyle(this.searchStyle) : this.searchStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
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
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle))
      ..add(DiagnosticsProperty('tagStyle', tagStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle))
      ..add(DiagnosticsProperty('searchStyle', searchStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle));
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
