// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTileContentStyleFunctions on Diagnosticable implements FTransformable {
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

  /// Returns a copy of this [FTileContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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
