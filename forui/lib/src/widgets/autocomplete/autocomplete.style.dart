// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FAutocompleteStyleCopyWith on FAutocompleteStyle {
  /// Returns a copy of this [FAutocompleteStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [fieldStyle]
  /// The select field's style.
  ///
  /// # [composingTextStyle]
  /// The composing text's [TextStyle].
  ///
  /// {@template forui.text_field.composingTextStyle}
  /// It is strongly recommended that FTextFieldStyle.contentTextStyle], [composingTextStyle] and [typeaheadTextStyle]
  /// are the same size to prevent visual discrepancies between the actual and typeahead text.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// {@endtemplate}
  ///
  /// # [typeaheadTextStyle]
  /// The typeahead's [TextStyle].
  ///
  /// {@macro forui.text_field.composingTextStyle}
  ///
  /// # [popoverStyle]
  /// The popover's style.
  ///
  /// # [contentStyle]
  /// The content's style.
  ///
  @useResult
  FAutocompleteStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle)? fieldStyle,
    FWidgetStateMap<TextStyle>? composingTextStyle,
    FWidgetStateMap<TextStyle>? typeaheadTextStyle,
    FPopoverStyle Function(FPopoverStyle)? popoverStyle,
    FAutocompleteContentStyle Function(FAutocompleteContentStyle)? contentStyle,
  }) => FAutocompleteStyle(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    composingTextStyle: composingTextStyle ?? this.composingTextStyle,
    typeaheadTextStyle: typeaheadTextStyle ?? this.typeaheadTextStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
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
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle))
      ..add(DiagnosticsProperty('composingTextStyle', composingTextStyle))
      ..add(DiagnosticsProperty('typeaheadTextStyle', typeaheadTextStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
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
