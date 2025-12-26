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
  /// * [FRadioStyle.tappableStyle] - The tappable style.
  /// * [FRadioStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FRadioStyle.borderColor] - The [FRadio]'s border color.
  /// * [FRadioStyle.backgroundColor] - The [FRadio]'s background color.
  /// * [FRadioStyle.indicatorColor] - The [FRadio]'s indicator color.
  /// * [FRadioStyle.motion] - The motion-related properties.
  /// * [FRadioStyle.labelPadding] - The label's padding.
  /// * [FRadioStyle.descriptionPadding] - The description's padding.
  /// * [FRadioStyle.errorPadding] - The error's padding.
  /// * [FRadioStyle.childPadding] - The child's padding.
  /// * [FRadioStyle.labelTextStyle] - The label's text style.
  /// * [FRadioStyle.descriptionTextStyle] - The description's text style.
  /// * [FRadioStyle.errorTextStyle] - The error's text style.
  @useResult
  FRadioStyle copyWith({
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FWidgetStateMap<Color>? borderColor,
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color>? indicatorColor,
    FRadioMotion Function(FRadioMotion motion)? motion,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => .new(
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    borderColor: borderColor ?? this.borderColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    indicatorColor: indicatorColor ?? this.indicatorColor,
    motion: motion != null ? motion(this.motion) : this.motion,
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
  FRadioStyle lerp(FRadioStyle other, double t) => .new(
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    borderColor: .lerpColor(borderColor, other.borderColor, t),
    backgroundColor: .lerpColor(backgroundColor, other.backgroundColor, t),
    indicatorColor: .lerpColor(indicatorColor, other.indicatorColor, t),
    motion: motion.lerp(other.motion, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FRadioStyleFunctions on Diagnosticable {
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FWidgetStateMap<Color> get borderColor;
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color> get indicatorColor;
  FRadioMotion get motion;
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
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: .debug))
      ..add(DiagnosticsProperty('indicatorColor', indicatorColor, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioStyle &&
          runtimeType == other.runtimeType &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          borderColor == other.borderColor &&
          backgroundColor == other.backgroundColor &&
          indicatorColor == other.indicatorColor &&
          motion == other.motion &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      borderColor.hashCode ^
      backgroundColor.hashCode ^
      indicatorColor.hashCode ^
      motion.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FRadioMotionTransformations on FRadioMotion {
  /// Returns a copy of this [FRadioMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FRadioMotion.duration] - The duration of the animation when selected.
  /// * [FRadioMotion.reverseDuration] - The duration of the reverse animation when unselected.
  /// * [FRadioMotion.curve] - The curve of the animation.
  @useResult
  FRadioMotion copyWith({Duration? duration, Duration? reverseDuration, Curve? curve}) => .new(
    duration: duration ?? this.duration,
    reverseDuration: reverseDuration ?? this.reverseDuration,
    curve: curve ?? this.curve,
  );

  /// Linearly interpolate between this and another [FRadioMotion] using the given factor [t].
  @useResult
  FRadioMotion lerp(FRadioMotion other, double t) => .new(
    duration: t < 0.5 ? duration : other.duration,
    reverseDuration: t < 0.5 ? reverseDuration : other.reverseDuration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FRadioMotionFunctions on Diagnosticable {
  Duration get duration;
  Duration get reverseDuration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FRadioMotion call(Object? _) => this as FRadioMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('reverseDuration', reverseDuration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRadioMotion &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          reverseDuration == other.reverseDuration &&
          curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ reverseDuration.hashCode ^ curve.hashCode;
}
