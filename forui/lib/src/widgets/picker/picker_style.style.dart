// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'picker_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FPickerStyleFunctions on Diagnosticable implements FTransformable {
  double get diameterRatio;
  double get squeeze;
  double get magnification;
  double get overAndUnderCenterOpacity;
  double get spacing;
  TextStyle get textStyle;
  TextHeightBehavior get textHeightBehavior;
  double get selectionHeightAdjustment;
  BorderRadiusGeometry get selectionBorderRadius;
  Color get selectionColor;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FPickerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FPickerStyle copyWith({
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextStyle? textStyle,
    TextHeightBehavior? textHeightBehavior,
    double? selectionHeightAdjustment,
    BorderRadiusGeometry? selectionBorderRadius,
    Color? selectionColor,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FPickerStyle(
    diameterRatio: diameterRatio ?? this.diameterRatio,
    squeeze: squeeze ?? this.squeeze,
    magnification: magnification ?? this.magnification,
    overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? this.overAndUnderCenterOpacity,
    spacing: spacing ?? this.spacing,
    textStyle: textStyle ?? this.textStyle,
    textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    selectionHeightAdjustment: selectionHeightAdjustment ?? this.selectionHeightAdjustment,
    selectionBorderRadius: selectionBorderRadius ?? this.selectionBorderRadius,
    selectionColor: selectionColor ?? this.selectionColor,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('diameterRatio', diameterRatio))
      ..add(DoubleProperty('squeeze', squeeze))
      ..add(DoubleProperty('magnification', magnification))
      ..add(DoubleProperty('overAndUnderCenterOpacity', overAndUnderCenterOpacity))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('textHeightBehavior', textHeightBehavior))
      ..add(DoubleProperty('selectionHeightAdjustment', selectionHeightAdjustment))
      ..add(DiagnosticsProperty('selectionBorderRadius', selectionBorderRadius))
      ..add(ColorProperty('selectionColor', selectionColor))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPickerStyle &&
          diameterRatio == other.diameterRatio &&
          squeeze == other.squeeze &&
          magnification == other.magnification &&
          overAndUnderCenterOpacity == other.overAndUnderCenterOpacity &&
          spacing == other.spacing &&
          textStyle == other.textStyle &&
          textHeightBehavior == other.textHeightBehavior &&
          selectionHeightAdjustment == other.selectionHeightAdjustment &&
          selectionBorderRadius == other.selectionBorderRadius &&
          selectionColor == other.selectionColor &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      diameterRatio.hashCode ^
      squeeze.hashCode ^
      magnification.hashCode ^
      overAndUnderCenterOpacity.hashCode ^
      spacing.hashCode ^
      textStyle.hashCode ^
      textHeightBehavior.hashCode ^
      selectionHeightAdjustment.hashCode ^
      selectionBorderRadius.hashCode ^
      selectionColor.hashCode ^
      focusedOutlineStyle.hashCode;
}
