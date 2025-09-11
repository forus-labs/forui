// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'radio.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FRadioStyleTransformations on FRadioStyle {
  /// Returns a copy of this [FRadioStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FRadioStyle.animationDuration] - The duration of the animation when the radio switches between selected and unselected.
  /// * [FRadioStyle.curve] - The curve of the animation when the radio switches between selected and unselected.
  /// * [FRadioStyle.tappableStyle] - The tappable style.
  /// * [FRadioStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FRadioStyle.borderColor] - The [FRadio]'s border color.
  /// * [FRadioStyle.backgroundColor] - The [FRadio]'s background color.
  /// * [FRadioStyle.indicatorColor] - The [FRadio]'s indicator color.
  /// * [FRadioStyle.labelPadding] - The label's padding.
  /// * [FRadioStyle.descriptionPadding] - The description's padding.
  /// * [FRadioStyle.errorPadding] - The error's padding.
  /// * [FRadioStyle.childPadding] - The child's padding.
  /// * [FRadioStyle.labelTextStyle] - The label's text style.
  /// * [FRadioStyle.descriptionTextStyle] - The description's text style.
  /// * [FRadioStyle.errorTextStyle] - The error's text style.
  @useResult
  FRadioStyle copyWith({
    Duration? animationDuration,
    Curve? curve,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FWidgetStateMap<Color>? borderColor,
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color>? indicatorColor,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FRadioStyle(
    animationDuration: animationDuration ?? this.animationDuration,
    curve: curve ?? this.curve,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    borderColor: borderColor ?? this.borderColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    indicatorColor: indicatorColor ?? this.indicatorColor,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FRadioStyle] using the given factor [t].
  @useResult
  FRadioStyle lerp(FRadioStyle other, double t) => FRadioStyle(
    animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
    curve: t < 0.5 ? curve : other.curve,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    borderColor: FWidgetStateMap.lerpColor(borderColor, other.borderColor, t),
    backgroundColor: FWidgetStateMap.lerpColor(backgroundColor, other.backgroundColor, t),
    indicatorColor: FWidgetStateMap.lerpColor(indicatorColor, other.indicatorColor, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FRadioStyleFunctions on Diagnosticable {
  Duration get animationDuration;
  Curve get curve;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FWidgetStateMap<Color> get borderColor;
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color> get indicatorColor;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FRadioStyle] to replace functions that accept and return a [FRadioStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FRadioStyle Function(FRadioStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FRadioStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FRadioStyle(...));
  /// ```
  @useResult
  FRadioStyle call(Object? _) => this as FRadioStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('animationDuration', animationDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('indicatorColor', indicatorColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorPadding', errorPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioStyle &&
          animationDuration == other.animationDuration &&
          curve == other.curve &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          borderColor == other.borderColor &&
          backgroundColor == other.backgroundColor &&
          indicatorColor == other.indicatorColor &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      animationDuration.hashCode ^
      curve.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      borderColor.hashCode ^
      backgroundColor.hashCode ^
      indicatorColor.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}
