// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTileContentStyleCopyWith on FTileContentStyle {
  /// Returns a copy of this [FTileContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [padding]
  /// The content's padding. Defaults to `EdgeInsetsDirectional.only(15, 13, 10, 13)`.
  ///
  /// # [prefixIconStyle]
  /// The prefix icon style.
  ///
  /// # [prefixIconSpacing]
  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  ///
  /// # [titleTextStyle]
  /// The title's text style.
  ///
  /// # [titleSpacing]
  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [titleSpacing] is negative.
  ///
  /// # [subtitleTextStyle]
  /// The subtitle's text style.
  ///
  /// # [middleSpacing]
  /// The minimum horizontal spacing between the title, subtitle, combined, and the details. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [middleSpacing] is negative.
  ///
  /// # [detailsTextStyle]
  /// The details text style.
  ///
  /// # [suffixIconStyle]
  /// The suffix icon style.
  ///
  /// # [suffixIconSpacing]
  /// The horizontal spacing between the details and suffix icon. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [suffixIconSpacing] is negative.
  ///
  @useResult
  FTileContentStyle copyWith({
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
  }) => FTileContentStyle(
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
}

mixin _$FTileContentStyleFunctions on Diagnosticable {
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
  /// Allows [FTileContentStyle] to replace functions that accept and return a [FTileContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTileContentStyle Function(FTileContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTileContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTileContentStyle(...));
  /// ```
  @useResult
  FTileContentStyle call(Object? _) => this as FTileContentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DoubleProperty('titleSpacing', titleSpacing))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle))
      ..add(DoubleProperty('middleSpacing', middleSpacing))
      ..add(DiagnosticsProperty('detailsTextStyle', detailsTextStyle))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle))
      ..add(DoubleProperty('suffixIconSpacing', suffixIconSpacing));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTileContentStyle &&
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
