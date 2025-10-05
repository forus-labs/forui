// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'form_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FFormFieldStyleTransformations on FFormFieldStyle {
  /// Returns a copy of this [FFormFieldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FFormFieldStyle.labelTextStyle] - The label's text style.
  /// * [FFormFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FFormFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FFormFieldStyle copyWith({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FFormFieldStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FFormFieldStyle] using the given factor [t].
  @useResult
  FFormFieldStyle lerp(FFormFieldStyle other, double t) => FFormFieldStyle(
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FFormFieldStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FFormFieldStyle] to replace functions that accept and return a [FFormFieldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FFormFieldStyle Function(FFormFieldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FFormFieldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FFormFieldStyle(...));
  /// ```
  @useResult
  FFormFieldStyle call(Object? _) => this as FFormFieldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FFormFieldStyle &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}
