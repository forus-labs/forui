// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'picker_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPickerStyleTransformations on FPickerStyle {
  /// Returns a copy of this [FPickerStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FPickerStyle.diameterRatio] - A ratio between the diameter of the cylinder and the viewport's size.
  /// * [FPickerStyle.squeeze] - The angular compactness of the children on the wheel.
  /// * [FPickerStyle.magnification] - The zoomed-in rate of the magnifier.
  /// * [FPickerStyle.overAndUnderCenterOpacity] - The opacity value applied to the wheel above and below the magnifier.
  /// * [FPickerStyle.spacing] - The spacing between the picker's wheels.
  /// * [FPickerStyle.textStyle] - The picker's default text style.
  /// * [FPickerStyle.textHeightBehavior] - The picker's default text height behavior.
  /// * [FPickerStyle.selectionHeightAdjustment] - An amount to add to the height of the selection.
  /// * [FPickerStyle.selectionBorderRadius] - The selection's border radius.
  /// * [FPickerStyle.selectionColor] - The selection's color.
  /// * [FPickerStyle.focusedOutlineStyle] - The focused outline style.
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
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
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
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FPickerStyle] using the given factor [t].
  @useResult
  FPickerStyle lerp(FPickerStyle other, double t) => FPickerStyle(
    diameterRatio: lerpDouble(diameterRatio, other.diameterRatio, t) ?? diameterRatio,
    squeeze: lerpDouble(squeeze, other.squeeze, t) ?? squeeze,
    magnification: lerpDouble(magnification, other.magnification, t) ?? magnification,
    overAndUnderCenterOpacity:
        lerpDouble(overAndUnderCenterOpacity, other.overAndUnderCenterOpacity, t) ?? overAndUnderCenterOpacity,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
    textHeightBehavior: t < 0.5 ? textHeightBehavior : other.textHeightBehavior,
    selectionHeightAdjustment:
        lerpDouble(selectionHeightAdjustment, other.selectionHeightAdjustment, t) ?? selectionHeightAdjustment,
    selectionBorderRadius:
        BorderRadiusGeometry.lerp(selectionBorderRadius, other.selectionBorderRadius, t) ?? selectionBorderRadius,
    selectionColor: Color.lerp(selectionColor, other.selectionColor, t) ?? selectionColor,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FPickerStyleFunctions on Diagnosticable {
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

  /// Returns itself.
  ///
  /// Allows [FPickerStyle] to replace functions that accept and return a [FPickerStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FPickerStyle Function(FPickerStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FPickerStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FPickerStyle(...));
  /// ```
  @useResult
  FPickerStyle call(Object? _) => this as FPickerStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('diameterRatio', diameterRatio, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('squeeze', squeeze, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('magnification', magnification, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('overAndUnderCenterOpacity', overAndUnderCenterOpacity, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('spacing', spacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textHeightBehavior', textHeightBehavior, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('selectionHeightAdjustment', selectionHeightAdjustment, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectionBorderRadius', selectionBorderRadius, level: DiagnosticLevel.debug))
      ..add(ColorProperty('selectionColor', selectionColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug));
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
