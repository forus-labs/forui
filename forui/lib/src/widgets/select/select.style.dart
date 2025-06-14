// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSelectStyleFunctions on Diagnosticable implements FTransformable {
  FTextFieldStyle get selectFieldStyle;
  IconThemeData get iconStyle;
  FPopoverStyle get popoverStyle;
  FSelectSearchStyle get searchStyle;
  FSelectContentStyle get contentStyle;
  TextStyle get emptyTextStyle;

  /// Returns a copy of this [FSelectStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSelectStyle copyWith({
    FTextFieldStyle? selectFieldStyle,
    IconThemeData? iconStyle,
    FPopoverStyle? popoverStyle,
    FSelectSearchStyle? searchStyle,
    FSelectContentStyle? contentStyle,
    TextStyle? emptyTextStyle,
  }) => FSelectStyle(
    selectFieldStyle: selectFieldStyle ?? this.selectFieldStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    popoverStyle: popoverStyle ?? this.popoverStyle,
    searchStyle: searchStyle ?? this.searchStyle,
    contentStyle: contentStyle ?? this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
  );
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
