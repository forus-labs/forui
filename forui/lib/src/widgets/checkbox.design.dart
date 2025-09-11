// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'checkbox.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCheckboxStyleTransformations on FCheckboxStyle {
  /// Returns a copy of this [FCheckboxStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCheckboxStyle.animationDuration] - The duration of the animation when the checkbox switches between checked and unchecked.
  /// * [FCheckboxStyle.curve] - The curve of the animation when the checkbox switches between checked and unchecked.
  /// * [FCheckboxStyle.tappableStyle] - The tappable style.
  /// * [FCheckboxStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FCheckboxStyle.size] - The checkboxes size.
  /// * [FCheckboxStyle.iconStyle] - The icon style.
  /// * [FCheckboxStyle.decoration] - The box decoration.
  /// * [FCheckboxStyle.labelPadding] - The label's padding.
  /// * [FCheckboxStyle.descriptionPadding] - The description's padding.
  /// * [FCheckboxStyle.errorPadding] - The error's padding.
  /// * [FCheckboxStyle.childPadding] - The child's padding.
  /// * [FCheckboxStyle.labelTextStyle] - The label's text style.
  /// * [FCheckboxStyle.descriptionTextStyle] - The description's text style.
  /// * [FCheckboxStyle.errorTextStyle] - The error's text style.
  @useResult
  FCheckboxStyle copyWith({
    Duration? animationDuration,
    Curve? curve,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    double? size,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<BoxDecoration>? decoration,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FCheckboxStyle(
    animationDuration: animationDuration ?? this.animationDuration,
    curve: curve ?? this.curve,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    size: size ?? this.size,
    iconStyle: iconStyle ?? this.iconStyle,
    decoration: decoration ?? this.decoration,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FCheckboxStyle] using the given factor [t].
  @useResult
  FCheckboxStyle lerp(FCheckboxStyle other, double t) => FCheckboxStyle(
    animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
    curve: t < 0.5 ? curve : other.curve,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    size: lerpDouble(size, other.size, t) ?? size,
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    decoration: FWidgetStateMap.lerpBoxDecoration(decoration, other.decoration, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FCheckboxStyleFunctions on Diagnosticable {
  Duration get animationDuration;
  Curve get curve;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  double get size;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FWidgetStateMap<BoxDecoration> get decoration;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FCheckboxStyle] to replace functions that accept and return a [FCheckboxStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCheckboxStyle Function(FCheckboxStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCheckboxStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCheckboxStyle(...));
  /// ```
  @useResult
  FCheckboxStyle call(Object? _) => this as FCheckboxStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('animationDuration', animationDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('size', size, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
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
      (other is FCheckboxStyle &&
          animationDuration == other.animationDuration &&
          curve == other.curve &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          size == other.size &&
          iconStyle == other.iconStyle &&
          decoration == other.decoration &&
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
      size.hashCode ^
      iconStyle.hashCode ^
      decoration.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}
