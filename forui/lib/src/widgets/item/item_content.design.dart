// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FItemContentStyleTransformations on FItemContentStyle {
  /// Returns a copy of this [FItemContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemContentStyle.padding] - The content's padding.
  /// * [FItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and title and the subtitle.
  /// * [FItemContentStyle.titleTextStyle] - The title's text style.
  /// * [FItemContentStyle.titleSpacing] - The vertical spacing between the title and the subtitle.
  /// * [FItemContentStyle.subtitleTextStyle] - The subtitle's text style.
  /// * [FItemContentStyle.middleSpacing] - The minimum horizontal spacing between the title, subtitle, combined, and the details.
  /// * [FItemContentStyle.detailsTextStyle] - The details text style.
  /// * [FItemContentStyle.suffixIconStyle] - The suffix icon style.
  /// * [FItemContentStyle.suffixIconSpacing] - The horizontal spacing between the details and suffix icon.
  @useResult
  FItemContentStyle copyWith({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<IconThemeData>? prefixIconStyle,
    double? prefixIconSpacing,
    FWidgetStateMap<TextStyle>? titleTextStyle,
    double? titleSpacing,
    FWidgetStateMap<TextStyle>? subtitleTextStyle,
    double? middleSpacing,
    FWidgetStateMap<TextStyle>? detailsTextStyle,
    FWidgetStateMap<IconThemeData>? suffixIconStyle,
    double? suffixIconSpacing,
  }) => FItemContentStyle(
    padding: padding ?? this.padding,
    prefixIconStyle: prefixIconStyle ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    middleSpacing: middleSpacing ?? this.middleSpacing,
    detailsTextStyle: detailsTextStyle ?? this.detailsTextStyle,
    suffixIconStyle: suffixIconStyle ?? this.suffixIconStyle,
    suffixIconSpacing: suffixIconSpacing ?? this.suffixIconSpacing,
  );

  /// Linearly interpolate between this and another [FItemContentStyle] using the given factor [t].
  @useResult
  FItemContentStyle lerp(FItemContentStyle other, double t) => FItemContentStyle(
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    prefixIconStyle: FWidgetStateMap.lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    titleTextStyle: FWidgetStateMap.lerpTextStyle(titleTextStyle, other.titleTextStyle, t),
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    subtitleTextStyle: FWidgetStateMap.lerpTextStyle(subtitleTextStyle, other.subtitleTextStyle, t),
    middleSpacing: lerpDouble(middleSpacing, other.middleSpacing, t) ?? middleSpacing,
    detailsTextStyle: FWidgetStateMap.lerpTextStyle(detailsTextStyle, other.detailsTextStyle, t),
    suffixIconStyle: FWidgetStateMap.lerpIconThemeData(suffixIconStyle, other.suffixIconStyle, t),
    suffixIconSpacing: lerpDouble(suffixIconSpacing, other.suffixIconSpacing, t) ?? suffixIconSpacing,
  );
}

mixin _$FItemContentStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get padding;
  FWidgetStateMap<IconThemeData> get prefixIconStyle;
  double get prefixIconSpacing;
  FWidgetStateMap<TextStyle> get titleTextStyle;
  double get titleSpacing;
  FWidgetStateMap<TextStyle> get subtitleTextStyle;
  double get middleSpacing;
  FWidgetStateMap<TextStyle> get detailsTextStyle;
  FWidgetStateMap<IconThemeData> get suffixIconStyle;
  double get suffixIconSpacing;

  /// Returns itself.
  ///
  /// Allows [FItemContentStyle] to replace functions that accept and return a [FItemContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FItemContentStyle Function(FItemContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FItemContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FItemContentStyle(...));
  /// ```
  @useResult
  FItemContentStyle call(Object? _) => this as FItemContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('middleSpacing', middleSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('detailsTextStyle', detailsTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('suffixIconSpacing', suffixIconSpacing, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemContentStyle &&
          padding == other.padding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          titleTextStyle == other.titleTextStyle &&
          titleSpacing == other.titleSpacing &&
          subtitleTextStyle == other.subtitleTextStyle &&
          middleSpacing == other.middleSpacing &&
          detailsTextStyle == other.detailsTextStyle &&
          suffixIconStyle == other.suffixIconStyle &&
          suffixIconSpacing == other.suffixIconSpacing);

  @override
  int get hashCode =>
      padding.hashCode ^
      prefixIconStyle.hashCode ^
      prefixIconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      subtitleTextStyle.hashCode ^
      middleSpacing.hashCode ^
      detailsTextStyle.hashCode ^
      suffixIconStyle.hashCode ^
      suffixIconSpacing.hashCode;
}
