// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCardContentStyleTransformations on FCardContentStyle {
  /// Returns a copy of this [FCardContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCardContentStyle.imageSpacing] - The spacing between the image and the title, subtitle, and child if any of them is provided.
  /// * [FCardContentStyle.subtitleSpacing] - The spacing between the title/subtitle and the child if an image is provided.
  /// * [FCardContentStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FCardContentStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  /// * [FCardContentStyle.padding] - The padding.
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

  /// Linearly interpolate between this and another [FCardContentStyle] using the given factor [t].
  @useResult
  FCardContentStyle lerp(FCardContentStyle other, double t) => FCardContentStyle(
    imageSpacing: lerpDouble(imageSpacing, other.imageSpacing, t) ?? imageSpacing,
    subtitleSpacing: lerpDouble(subtitleSpacing, other.subtitleSpacing, t) ?? subtitleSpacing,
    titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t) ?? subtitleTextStyle,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FCardContentStyleFunctions on Diagnosticable {
  double get imageSpacing;
  double get subtitleSpacing;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;
  EdgeInsetsGeometry get padding;

  /// Returns itself.
  ///
  /// Allows [FCardContentStyle] to replace functions that accept and return a [FCardContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCardContentStyle Function(FCardContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCardContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCardContentStyle(...));
  /// ```
  @useResult
  FCardContentStyle call(Object? _) => this as FCardContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('imageSpacing', imageSpacing, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('subtitleSpacing', subtitleSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug));
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
