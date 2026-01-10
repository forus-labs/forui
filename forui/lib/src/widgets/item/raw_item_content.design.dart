// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'raw_item_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FRawItemContentStyleTransformations on FRawItemContentStyle {
  /// Returns a copy of this [FRawItemContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FRawItemContentStyle.padding] - The content's padding.
  /// * [FRawItemContentStyle.prefixIconStyle] - The prefix icon style.
  /// * [FRawItemContentStyle.prefixIconSpacing] - The horizontal spacing between the prefix icon and child.
  /// * [FRawItemContentStyle.childTextStyle] - The child's text style.
  @useResult
  FRawItemContentStyle copyWith({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<IconThemeData>? prefixIconStyle,
    double? prefixIconSpacing,
    FWidgetStateMap<TextStyle>? childTextStyle,
  }) => .new(
    padding: padding ?? this.padding,
    prefixIconStyle: prefixIconStyle ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    childTextStyle: childTextStyle ?? this.childTextStyle,
  );

  /// Linearly interpolate between this and another [FRawItemContentStyle] using the given factor [t].
  @useResult
  FRawItemContentStyle lerp(FRawItemContentStyle other, double t) => .new(
    padding: .lerp(padding, other.padding, t) ?? padding,
    prefixIconStyle: .lerpIconThemeData(prefixIconStyle, other.prefixIconStyle, t),
    prefixIconSpacing: lerpDouble(prefixIconSpacing, other.prefixIconSpacing, t) ?? prefixIconSpacing,
    childTextStyle: .lerpTextStyle(childTextStyle, other.childTextStyle, t),
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
      ..add(DiagnosticsProperty('padding', padding, level: .debug))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle, level: .debug))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing, level: .debug))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FRawItemContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          childTextStyle == other.childTextStyle);

  @override
  int get hashCode =>
      padding.hashCode ^ prefixIconStyle.hashCode ^ prefixIconSpacing.hashCode ^ childTextStyle.hashCode;
}
