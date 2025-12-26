// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteStyleTransformations on FAutocompleteStyle {
  /// Returns a copy of this [FAutocompleteStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteStyle.fieldStyle] - The select field's style.
  /// * [FAutocompleteStyle.composingTextStyle] - The composing text's [TextStyle].
  /// * [FAutocompleteStyle.typeaheadTextStyle] - The typeahead's [TextStyle].
  /// * [FAutocompleteStyle.contentStyle] - The content's style.
  @useResult
  FAutocompleteStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? fieldStyle,
    FWidgetStateMap<TextStyle>? composingTextStyle,
    FWidgetStateMap<TextStyle>? typeaheadTextStyle,
    FAutocompleteContentStyle Function(FAutocompleteContentStyle style)? contentStyle,
  }) => .new(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    composingTextStyle: composingTextStyle ?? this.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle ?? this.typeaheadTextStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteStyle] using the given factor [t].
  @useResult
  FAutocompleteStyle lerp(FAutocompleteStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    composingTextStyle: .lerpTextStyle(composingTextStyle, other.composingTextStyle, t),
    typeaheadTextStyle: .lerpTextStyle(typeaheadTextStyle, other.typeaheadTextStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FAutocompleteStyleFunctions on Diagnosticable {
  FTextFieldStyle get fieldStyle;
  FWidgetStateMap<TextStyle> get composingTextStyle;
  FWidgetStateMap<TextStyle> get typeaheadTextStyle;
  FAutocompleteContentStyle get contentStyle;

  /// Returns itself.
  ///
  /// Allows [FAutocompleteStyle] to replace functions that accept and return a [FAutocompleteStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAutocompleteStyle Function(FAutocompleteStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAutocompleteStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAutocompleteStyle(...));
  /// ```
  @useResult
  FAutocompleteStyle call(Object? _) => this as FAutocompleteStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('composingTextStyle', composingTextStyle, level: .debug))
      ..add(DiagnosticsProperty('typeaheadTextStyle', typeaheadTextStyle, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          composingTextStyle == other.composingTextStyle &&
          typeaheadTextStyle == other.typeaheadTextStyle &&
          contentStyle == other.contentStyle);

  @override
  int get hashCode =>
      fieldStyle.hashCode ^ composingTextStyle.hashCode ^ typeaheadTextStyle.hashCode ^ contentStyle.hashCode;
}
