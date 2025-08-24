// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'form_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FFormFieldStyleCopyWith on FFormFieldStyle {
  /// Returns a copy of this [FFormFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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
  FFormFieldStyle copyWith({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FFormFieldStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
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
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
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
