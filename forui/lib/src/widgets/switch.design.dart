// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'switch.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSwitchStyleTransformations on FSwitchStyle {
  /// Returns a copy of this [FSwitchStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSwitchStyle.focusColor] - This [FSwitch]'s color when focused.
  /// * [FSwitchStyle.trackColor] - The track's color.
  /// * [FSwitchStyle.thumbColor] - The thumb's color.
  /// * [FSwitchStyle.labelPadding] - The label's padding.
  /// * [FSwitchStyle.descriptionPadding] - The description's padding.
  /// * [FSwitchStyle.errorPadding] - The error's padding.
  /// * [FSwitchStyle.childPadding] - The child's padding.
  /// * [FSwitchStyle.labelTextStyle] - The label's text style.
  /// * [FSwitchStyle.descriptionTextStyle] - The description's text style.
  /// * [FSwitchStyle.errorTextStyle] - The error's text style.
  @useResult
  FSwitchStyle copyWith({
    Color? focusColor,
    FWidgetStateMap<Color>? trackColor,
    FWidgetStateMap<Color>? thumbColor,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FSwitchStyle(
    focusColor: focusColor ?? this.focusColor,
    trackColor: trackColor ?? this.trackColor,
    thumbColor: thumbColor ?? this.thumbColor,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSwitchStyle] using the given factor [t].
  @useResult
  FSwitchStyle lerp(FSwitchStyle other, double t) => FSwitchStyle(
    focusColor: Color.lerp(focusColor, other.focusColor, t) ?? focusColor,
    trackColor: FWidgetStateMap.lerpColor(trackColor, other.trackColor, t),
    thumbColor: FWidgetStateMap.lerpColor(thumbColor, other.thumbColor, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FSwitchStyleFunctions on Diagnosticable {
  Color get focusColor;
  FWidgetStateMap<Color> get trackColor;
  FWidgetStateMap<Color> get thumbColor;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FSwitchStyle] to replace functions that accept and return a [FSwitchStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSwitchStyle Function(FSwitchStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSwitchStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSwitchStyle(...));
  /// ```
  @useResult
  FSwitchStyle call(Object? _) => this as FSwitchStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('focusColor', focusColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('trackColor', trackColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('thumbColor', thumbColor, level: DiagnosticLevel.debug))
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
      (other is FSwitchStyle &&
          focusColor == other.focusColor &&
          trackColor == other.trackColor &&
          thumbColor == other.thumbColor &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      focusColor.hashCode ^
      trackColor.hashCode ^
      thumbColor.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}
