// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSelectStyleCopyWith on FSelectStyle {
  /// Returns a copy of this [FSelectStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [selectFieldStyle]
  /// The select field's style.
  ///
  /// # [iconStyle]
  /// The select field's icon style.
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
  FSelectStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle)? selectFieldStyle,
    IconThemeData? iconStyle,
    FPopoverStyle Function(FPopoverStyle)? popoverStyle,
    FSelectSearchStyle Function(FSelectSearchStyle)? searchStyle,
    FSelectContentStyle Function(FSelectContentStyle)? contentStyle,
    TextStyle? emptyTextStyle,
  }) => FSelectStyle(
    selectFieldStyle: selectFieldStyle != null ? selectFieldStyle(this.selectFieldStyle) : this.selectFieldStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    searchStyle: searchStyle != null ? searchStyle(this.searchStyle) : this.searchStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
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
      ..add(DiagnosticsProperty('selectFieldStyle', selectFieldStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle))
      ..add(DiagnosticsProperty('searchStyle', searchStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle));
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
