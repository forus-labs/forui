// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSelectSectionStyleFunctions on Diagnosticable implements FTransformable {
  TextStyle get enabledLabelTextStyle;
  TextStyle get disabledLabelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FSelectItemStyle get itemStyle;

  /// Returns a copy of this [FSelectSectionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSelectSectionStyle copyWith({
    TextStyle? enabledLabelTextStyle,
    TextStyle? disabledLabelTextStyle,
    EdgeInsetsGeometry? labelPadding,
    FSelectItemStyle? itemStyle,
  }) => FSelectSectionStyle(
    enabledLabelTextStyle: enabledLabelTextStyle ?? this.enabledLabelTextStyle,
    disabledLabelTextStyle: disabledLabelTextStyle ?? this.disabledLabelTextStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    itemStyle: itemStyle ?? this.itemStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledLabelTextStyle', enabledLabelTextStyle))
      ..add(DiagnosticsProperty('disabledLabelTextStyle', disabledLabelTextStyle))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSectionStyle &&
          enabledLabelTextStyle == other.enabledLabelTextStyle &&
          disabledLabelTextStyle == other.disabledLabelTextStyle &&
          labelPadding == other.labelPadding &&
          itemStyle == other.itemStyle);
  @override
  int get hashCode =>
      enabledLabelTextStyle.hashCode ^ disabledLabelTextStyle.hashCode ^ labelPadding.hashCode ^ itemStyle.hashCode;
}
mixin _$FSelectItemStyleFunctions on Diagnosticable implements FTransformable {
  EdgeInsetsGeometry get padding;
  FWidgetStateMap<BoxDecoration?> get decoration;
  FWidgetStateMap<TextStyle> get textStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FTappableStyle get tappableStyle;

  /// Returns a copy of this [FSelectItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSelectItemStyle copyWith({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FTappableStyle? tappableStyle,
  }) => FSelectItemStyle(
    padding: padding ?? this.padding,
    decoration: decoration ?? this.decoration,
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectItemStyle &&
          padding == other.padding &&
          decoration == other.decoration &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          tappableStyle == other.tappableStyle);
  @override
  int get hashCode =>
      padding.hashCode ^ decoration.hashCode ^ textStyle.hashCode ^ iconStyle.hashCode ^ tappableStyle.hashCode;
}
