// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteContentStyleTransformations on FAutocompleteContentStyle {
  /// Returns a copy of this [FAutocompleteContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteContentStyle.emptyTextStyle] - The default text style when there are no results.
  /// * [FAutocompleteContentStyle.padding] - The padding surrounding the content.
  /// * [FAutocompleteContentStyle.progressStyle] - The loading progress's style.
  /// * [FAutocompleteContentStyle.sectionStyle] - The section's style.
  @useResult
  FAutocompleteContentStyle copyWith({
    TextStyle? emptyTextStyle,
    EdgeInsetsGeometry? padding,
    FCircularProgressStyle Function(FCircularProgressStyle style)? progressStyle,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? sectionStyle,
  }) => FAutocompleteContentStyle(
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
    padding: padding ?? this.padding,
    progressStyle: progressStyle != null ? progressStyle(this.progressStyle) : this.progressStyle,
    sectionStyle: sectionStyle != null ? sectionStyle(this.sectionStyle) : this.sectionStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteContentStyle] using the given factor [t].
  @useResult
  FAutocompleteContentStyle lerp(FAutocompleteContentStyle other, double t) => FAutocompleteContentStyle(
    emptyTextStyle: TextStyle.lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    progressStyle: progressStyle.lerp(other.progressStyle, t),
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
  );
}

mixin _$FAutocompleteContentStyleFunctions on Diagnosticable {
  TextStyle get emptyTextStyle;
  EdgeInsetsGeometry get padding;
  FCircularProgressStyle get progressStyle;
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
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteContentStyle &&
          emptyTextStyle == other.emptyTextStyle &&
          padding == other.padding &&
          progressStyle == other.progressStyle &&
          sectionStyle == other.sectionStyle);

  @override
  int get hashCode => emptyTextStyle.hashCode ^ padding.hashCode ^ progressStyle.hashCode ^ sectionStyle.hashCode;
}
