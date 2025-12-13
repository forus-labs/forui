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
  /// * [FAutocompleteContentStyle.decoration] - The popover's decoration.
  /// * [FAutocompleteContentStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FAutocompleteContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FAutocompleteContentStyle.viewInsets] - The additional insets of the view.
  @useResult
  FAutocompleteContentStyle copyWith({
    TextStyle? emptyTextStyle,
    EdgeInsetsGeometry? padding,
    FCircularProgressStyle Function(FCircularProgressStyle style)? progressStyle,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? sectionStyle,
    BoxDecoration? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometry? viewInsets,
  }) => .new(
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
    padding: padding ?? this.padding,
    progressStyle: progressStyle != null ? progressStyle(this.progressStyle) : this.progressStyle,
    sectionStyle: sectionStyle != null ? sectionStyle(this.sectionStyle) : this.sectionStyle,
    decoration: decoration ?? this.decoration,
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    viewInsets: viewInsets ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FAutocompleteContentStyle] using the given factor [t].
  @useResult
  FAutocompleteContentStyle lerp(FAutocompleteContentStyle other, double t) => .new(
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
    padding: .lerp(padding, other.padding, t) ?? padding,
    progressStyle: progressStyle.lerp(other.progressStyle, t),
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: .lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FAutocompleteContentStyleFunctions on Diagnosticable {
  TextStyle get emptyTextStyle;
  EdgeInsetsGeometry get padding;
  FCircularProgressStyle get progressStyle;
  FAutocompleteSectionStyle get sectionStyle;
  BoxDecoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;

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
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: .debug))
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteContentStyle &&
          runtimeType == other.runtimeType &&
          emptyTextStyle == other.emptyTextStyle &&
          padding == other.padding &&
          progressStyle == other.progressStyle &&
          sectionStyle == other.sectionStyle &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode =>
      emptyTextStyle.hashCode ^
      padding.hashCode ^
      progressStyle.hashCode ^
      sectionStyle.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      viewInsets.hashCode;
}
