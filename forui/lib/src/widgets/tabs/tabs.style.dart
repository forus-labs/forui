// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tabs.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTabsStyleFunctions on Diagnosticable implements FTransformable {
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  TextStyle get selectedLabelTextStyle;
  TextStyle get unselectedLabelTextStyle;
  BoxDecoration get indicatorDecoration;
  FTabBarIndicatorSize get indicatorSize;
  double get height;
  double get spacing;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FTabsStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FTabsStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    TextStyle? selectedLabelTextStyle,
    TextStyle? unselectedLabelTextStyle,
    BoxDecoration? indicatorDecoration,
    FTabBarIndicatorSize? indicatorSize,
    double? height,
    double? spacing,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FTabsStyle(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    selectedLabelTextStyle: selectedLabelTextStyle ?? this.selectedLabelTextStyle,
    unselectedLabelTextStyle: unselectedLabelTextStyle ?? this.unselectedLabelTextStyle,
    indicatorDecoration: indicatorDecoration ?? this.indicatorDecoration,
    indicatorSize: indicatorSize ?? this.indicatorSize,
    height: height ?? this.height,
    spacing: spacing ?? this.spacing,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('selectedLabelTextStyle', selectedLabelTextStyle))
      ..add(DiagnosticsProperty('unselectedLabelTextStyle', unselectedLabelTextStyle))
      ..add(DiagnosticsProperty('indicatorDecoration', indicatorDecoration))
      ..add(EnumProperty('indicatorSize', indicatorSize))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTabsStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          selectedLabelTextStyle == other.selectedLabelTextStyle &&
          unselectedLabelTextStyle == other.unselectedLabelTextStyle &&
          indicatorDecoration == other.indicatorDecoration &&
          indicatorSize == other.indicatorSize &&
          height == other.height &&
          spacing == other.spacing &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      selectedLabelTextStyle.hashCode ^
      unselectedLabelTextStyle.hashCode ^
      indicatorDecoration.hashCode ^
      indicatorSize.hashCode ^
      height.hashCode ^
      spacing.hashCode ^
      focusedOutlineStyle.hashCode;
}
