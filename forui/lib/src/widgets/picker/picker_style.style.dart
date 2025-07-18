// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'picker_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FPickerStyleCopyWith on FPickerStyle {
  /// Returns a copy of this [FPickerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [diameterRatio]
  /// A ratio between the diameter of the cylinder and the viewport's size.
  ///
  /// # [squeeze]
  /// The angular compactness of the children on the wheel.
  ///
  /// # [magnification]
  /// The zoomed-in rate of the magnifier.
  ///
  /// # [overAndUnderCenterOpacity]
  /// The opacity value applied to the wheel above and below the magnifier.
  ///
  /// # [spacing]
  /// The spacing between the picker's wheels. Defaults to 5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the spacing is less than 0.
  ///
  /// # [textStyle]
  /// The picker's default text style.
  ///
  /// # [textHeightBehavior]
  /// The picker's default text height behavior.
  ///
  /// # [selectionHeightAdjustment]
  /// An amount to add to the height of the selection.
  ///
  /// # [selectionBorderRadius]
  /// The selection's border radius.
  ///
  /// # [selectionColor]
  /// The selection's color.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
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
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
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
