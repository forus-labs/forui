// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FBottomNavigationBarItemStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  FWidgetStateMap<TextStyle> get textStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<TextStyle>? textStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
    FTappableStyle? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FBottomNavigationBarItemStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    textStyle: textStyle ?? this.textStyle,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarItemStyle &&
          iconStyle == other.iconStyle &&
          textStyle == other.textStyle &&
          padding == other.padding &&
          spacing == other.spacing &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      iconStyle.hashCode ^
      textStyle.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
