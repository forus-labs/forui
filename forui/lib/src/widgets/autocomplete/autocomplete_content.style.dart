// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FAutocompleteContentStyleCopyWith on FAutocompleteContentStyle {
  /// Returns a copy of this [FAutocompleteContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [loadingIndicatorStyle]
  /// The loading indicators style.
  ///
  /// # [emptyTextStyle]
  /// The default text style when there are no results.
  ///
  /// # [padding]
  /// The padding surrounding the content. Defaults to `const EdgeInsets.symmetric(vertical: 5)`.
  ///
  /// # [sectionStyle]
  /// The section's style.
  ///
  @useResult
  FAutocompleteContentStyle copyWith({
    IconThemeData? loadingIndicatorStyle,
    TextStyle? emptyTextStyle,
    EdgeInsetsGeometry? padding,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle)? sectionStyle,
  }) => FAutocompleteContentStyle(
    loadingIndicatorStyle: loadingIndicatorStyle ?? this.loadingIndicatorStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
    padding: padding ?? this.padding,
    sectionStyle: sectionStyle != null ? sectionStyle(this.sectionStyle) : this.sectionStyle,
  );
}

mixin _$FAutocompleteContentStyleFunctions on Diagnosticable {
  IconThemeData get loadingIndicatorStyle;
  TextStyle get emptyTextStyle;
  EdgeInsetsGeometry get padding;
  FAutocompleteSectionStyle get sectionStyle;

  /// Returns itself.
  ///
  /// Allows [FAutocompleteContentStyle] to replace functions that accept and return a [FAutocompleteContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAutocompleteContentStyle Function(FAutocompleteContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAutocompleteContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAutocompleteContentStyle(...));
  /// ```
  @useResult
  FAutocompleteContentStyle call(Object? _) => this as FAutocompleteContentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('loadingIndicatorStyle', loadingIndicatorStyle))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteContentStyle &&
          loadingIndicatorStyle == other.loadingIndicatorStyle &&
          emptyTextStyle == other.emptyTextStyle &&
          padding == other.padding &&
          sectionStyle == other.sectionStyle);
  @override
  int get hashCode =>
      loadingIndicatorStyle.hashCode ^ emptyTextStyle.hashCode ^ padding.hashCode ^ sectionStyle.hashCode;
}
