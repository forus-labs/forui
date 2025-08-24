// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'switch.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSwitchStyleCopyWith on FSwitchStyle {
  /// Returns a copy of this [FSwitchStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [focusColor]
  /// This [FSwitch]'s color when focused.
  ///
  /// # [trackColor]
  /// The track's color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.selected]
  ///
  /// # [thumbColor]
  /// The thumb's color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.selected]
  ///
  /// # [labelPadding]
  /// The label's padding.
  ///
  /// # [descriptionPadding]
  /// The description's padding.
  ///
  /// # [errorPadding]
  /// The error's padding.
  ///
  /// # [childPadding]
  /// The child's padding.
  ///
  /// # [labelTextStyle]
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [descriptionTextStyle]
  /// The description's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [errorTextStyle]
  /// The error's text style.
  ///
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
      ..add(ColorProperty('focusColor', focusColor))
      ..add(DiagnosticsProperty('trackColor', trackColor))
      ..add(DiagnosticsProperty('thumbColor', thumbColor))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding))
      ..add(DiagnosticsProperty('errorPadding', errorPadding))
      ..add(DiagnosticsProperty('childPadding', childPadding))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
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
