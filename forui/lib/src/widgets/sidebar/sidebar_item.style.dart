// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSidebarItemStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<TextStyle> get textStyle;
  double get iconSpacing;
  FWidgetStateMap<IconThemeData> get iconStyle;
  double get collapsibleIconSpacing;
  FWidgetStateMap<IconThemeData> get collapsibleIconStyle;
  Duration get expandDuration;
  Curve get expandCurve;
  Duration get collapseDuration;
  Curve get collapseCurve;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FWidgetStateMap<Color> get backgroundColor;
  EdgeInsetsGeometry get padding;
  BorderRadius get borderRadius;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FSidebarItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSidebarItemStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    double? iconSpacing,
    FWidgetStateMap<IconThemeData>? iconStyle,
    double? collapsibleIconSpacing,
    FWidgetStateMap<IconThemeData>? collapsibleIconStyle,
    Duration? expandDuration,
    Curve? expandCurve,
    Duration? collapseDuration,
    Curve? collapseCurve,
    double? childrenSpacing,
    EdgeInsetsGeometry? childrenPadding,
    FWidgetStateMap<Color>? backgroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    FTappableStyle? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FSidebarItemStyle(
    textStyle: textStyle ?? this.textStyle,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    iconStyle: iconStyle ?? this.iconStyle,
    collapsibleIconSpacing: collapsibleIconSpacing ?? this.collapsibleIconSpacing,
    collapsibleIconStyle: collapsibleIconStyle ?? this.collapsibleIconStyle,
    expandDuration: expandDuration ?? this.expandDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding ?? this.childrenPadding,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    padding: padding ?? this.padding,
    borderRadius: borderRadius ?? this.borderRadius,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DoubleProperty('iconSpacing', iconSpacing))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DoubleProperty('collapsibleIconSpacing', collapsibleIconSpacing))
      ..add(DiagnosticsProperty('collapsibleIconStyle', collapsibleIconStyle))
      ..add(DiagnosticsProperty('expandDuration', expandDuration))
      ..add(DiagnosticsProperty('expandCurve', expandCurve))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarItemStyle &&
          textStyle == other.textStyle &&
          iconSpacing == other.iconSpacing &&
          iconStyle == other.iconStyle &&
          collapsibleIconSpacing == other.collapsibleIconSpacing &&
          collapsibleIconStyle == other.collapsibleIconStyle &&
          expandDuration == other.expandDuration &&
          expandCurve == other.expandCurve &&
          collapseDuration == other.collapseDuration &&
          collapseCurve == other.collapseCurve &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          backgroundColor == other.backgroundColor &&
          padding == other.padding &&
          borderRadius == other.borderRadius &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconSpacing.hashCode ^
      iconStyle.hashCode ^
      collapsibleIconSpacing.hashCode ^
      collapsibleIconStyle.hashCode ^
      expandDuration.hashCode ^
      expandCurve.hashCode ^
      collapseDuration.hashCode ^
      collapseCurve.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      backgroundColor.hashCode ^
      padding.hashCode ^
      borderRadius.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
