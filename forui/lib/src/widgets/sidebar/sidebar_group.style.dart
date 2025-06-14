// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_group.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSidebarGroupStyleFunctions on Diagnosticable implements FTransformable {
  EdgeInsets get padding;
  double get headerSpacing;
  EdgeInsetsGeometry get headerPadding;
  TextStyle get labelStyle;
  FWidgetStateMap<IconThemeData> get actionStyle;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FSidebarItemStyle get itemStyle;

  /// Returns a copy of this [FSidebarGroupStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSidebarGroupStyle copyWith({
    EdgeInsets? padding,
    double? headerSpacing,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? labelStyle,
    FWidgetStateMap<IconThemeData>? actionStyle,
    double? childrenSpacing,
    EdgeInsetsGeometry? childrenPadding,
    FTappableStyle? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
    FSidebarItemStyle? itemStyle,
  }) => FSidebarGroupStyle(
    padding: padding ?? this.padding,
    headerSpacing: headerSpacing ?? this.headerSpacing,
    headerPadding: headerPadding ?? this.headerPadding,
    labelStyle: labelStyle ?? this.labelStyle,
    actionStyle: actionStyle ?? this.actionStyle,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding ?? this.childrenPadding,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
    itemStyle: itemStyle ?? this.itemStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('headerSpacing', headerSpacing))
      ..add(DiagnosticsProperty('headerPadding', headerPadding))
      ..add(DiagnosticsProperty('labelStyle', labelStyle))
      ..add(DiagnosticsProperty('actionStyle', actionStyle))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarGroupStyle &&
          padding == other.padding &&
          headerSpacing == other.headerSpacing &&
          headerPadding == other.headerPadding &&
          labelStyle == other.labelStyle &&
          actionStyle == other.actionStyle &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          itemStyle == other.itemStyle);
  @override
  int get hashCode =>
      padding.hashCode ^
      headerSpacing.hashCode ^
      headerPadding.hashCode ^
      labelStyle.hashCode ^
      actionStyle.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      itemStyle.hashCode;
}
