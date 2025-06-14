// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FCardContentStyleFunctions on Diagnosticable implements FTransformable {
  double get imageSpacing;
  double get subtitleSpacing;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;
  EdgeInsetsGeometry get padding;

  /// Returns a copy of this [FCardContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FCardContentStyle copyWith({
    double? imageSpacing,
    double? subtitleSpacing,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    EdgeInsetsGeometry? padding,
  }) => FCardContentStyle(
    imageSpacing: imageSpacing ?? this.imageSpacing,
    subtitleSpacing: subtitleSpacing ?? this.subtitleSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    padding: padding ?? this.padding,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('imageSpacing', imageSpacing))
      ..add(DoubleProperty('subtitleSpacing', subtitleSpacing))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCardContentStyle &&
          imageSpacing == other.imageSpacing &&
          subtitleSpacing == other.subtitleSpacing &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle &&
          padding == other.padding);
  @override
  int get hashCode =>
      imageSpacing.hashCode ^
      subtitleSpacing.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode ^
      padding.hashCode;
}
