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
  /// * [FAutocompleteStyle.popoverStyle] - The popover's style.
  /// * [FAutocompleteStyle.contentStyle] - The content's style.
  @useResult
  FAutocompleteStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? fieldStyle,
    FWidgetStateMap<TextStyle>? composingTextStyle,
    FWidgetStateMap<TextStyle>? typeaheadTextStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FAutocompleteContentStyle Function(FAutocompleteContentStyle style)? contentStyle,
  }) => FAutocompleteStyle(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    composingTextStyle: composingTextStyle ?? this.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle ?? this.typeaheadTextStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteStyle] using the given factor [t].
  @useResult
  FAutocompleteStyle lerp(FAutocompleteStyle other, double t) => FAutocompleteStyle(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    composingTextStyle: FWidgetStateMap.lerpTextStyle(composingTextStyle, other.composingTextStyle, t),
    typeaheadTextStyle: FWidgetStateMap.lerpTextStyle(typeaheadTextStyle, other.typeaheadTextStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FAutocompleteStyleFunctions on Diagnosticable {
  FTextFieldStyle get fieldStyle;
  FWidgetStateMap<TextStyle> get composingTextStyle;
  FWidgetStateMap<TextStyle> get typeaheadTextStyle;
  FPopoverStyle get popoverStyle;
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
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('composingTextStyle', composingTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('typeaheadTextStyle', typeaheadTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteStyle &&
          fieldStyle == other.fieldStyle &&
          composingTextStyle == other.composingTextStyle &&
          typeaheadTextStyle == other.typeaheadTextStyle &&
          popoverStyle == other.popoverStyle &&
          contentStyle == other.contentStyle);

  @override
  int get hashCode =>
      fieldStyle.hashCode ^
      composingTextStyle.hashCode ^
      typeaheadTextStyle.hashCode ^
      popoverStyle.hashCode ^
      contentStyle.hashCode;
}
