// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'raw_item_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FRawItemContentStyleCopyWith on FRawItemContentStyle {
  /// Returns a copy of this [FRawItemContentStyle] with the given properties replaced.
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
  /// The horizontal spacing between the prefix icon and child. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  ///
  /// # [childTextStyle]
  /// The child's text style.
  ///
  @useResult
  FRawItemContentStyle copyWith({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<IconThemeData>? prefixIconStyle,
    double? prefixIconSpacing,
    FWidgetStateMap<TextStyle>? childTextStyle,
  }) => FRawItemContentStyle(
    padding: padding ?? this.padding,
    prefixIconStyle: prefixIconStyle ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    childTextStyle: childTextStyle ?? this.childTextStyle,
  );
}

mixin _$FRawItemContentStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get padding;
  FWidgetStateMap<IconThemeData> get prefixIconStyle;
  double get prefixIconSpacing;
  FWidgetStateMap<TextStyle> get childTextStyle;

  /// Returns itself.
  ///
  /// Allows [FRawItemContentStyle] to replace functions that accept and return a [FRawItemContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FRawItemContentStyle Function(FRawItemContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FRawItemContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FRawItemContentStyle(...));
  /// ```
  @useResult
  FRawItemContentStyle call(Object? _) => this as FRawItemContentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRawItemContentStyle &&
          padding == other.padding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          childTextStyle == other.childTextStyle);
  @override
  int get hashCode =>
      padding.hashCode ^ prefixIconStyle.hashCode ^ prefixIconSpacing.hashCode ^ childTextStyle.hashCode;
}
