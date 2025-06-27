// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tooltip.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTooltipStyleCopyWith on FTooltipStyle {
  /// Returns a copy of this [FTooltipStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The box decoration.
  ///
  /// # [backgroundFilter]
  /// An optional background filter applied to the tooltip.
  ///
  /// This is typically combined with a translucent background in [decoration] to create a glassmorphic effect.
  ///
  /// # [padding]
  /// The padding surrounding the tooltip's text.
  ///
  /// # [textStyle]
  /// The tooltip's default text style.
  ///
  @useResult
  FTooltipStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsets? padding,
    TextStyle? textStyle,
  }) => FTooltipStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    textStyle: textStyle ?? this.textStyle,
  );
}

mixin _$FTooltipStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsets get padding;
  TextStyle get textStyle;

  /// Returns itself.
  ///
  /// Allows [FTooltipStyle] to replace functions that accept and return a [FTooltipStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTooltipStyle Function(FTooltipStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTooltipStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTooltipStyle(...));
  /// ```
  @useResult
  FTooltipStyle call(Object? _) => this as FTooltipStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('textStyle', textStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTooltipStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          textStyle == other.textStyle);
  @override
  int get hashCode => decoration.hashCode ^ backgroundFilter.hashCode ^ padding.hashCode ^ textStyle.hashCode;
}
