// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FCardContentStyleCopyWith on FCardContentStyle {
  /// Returns a copy of this [FCardContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [imageSpacing]
  /// The spacing between the image and the title, subtitle, and child if any of them is provided. Defaults to 10.
  ///
  /// # [subtitleSpacing]
  /// The spacing between the title/subtitle and the child if an image is provided. Defaults to 8.
  ///
  /// # [titleTextStyle]
  /// The title's [TextStyle].
  ///
  /// # [subtitleTextStyle]
  /// The subtitle's [TextStyle].
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.all(16)`.
  ///
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
