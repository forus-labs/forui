// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'thumb.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSliderThumbStyleTransformations on FSliderThumbStyle {
  /// Returns a copy of this [FSliderThumbStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderThumbStyle.color] - The thumb's color.
  /// * [FSliderThumbStyle.borderColor] - The border's color.
  /// * [FSliderThumbStyle.borderWidth] - The border's width.
  /// * [FSliderThumbStyle.focusedOutlineStyle] - The thumb's focused outline style.
  @useResult
  FSliderThumbStyle copyWith({
    FWidgetStateMap<Color>? color,
    FWidgetStateMap<Color>? borderColor,
    double? borderWidth,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => .new(
    color: color ?? this.color,
    borderColor: borderColor ?? this.borderColor,
    borderWidth: borderWidth ?? this.borderWidth,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FSliderThumbStyle] using the given factor [t].
  @useResult
  FSliderThumbStyle lerp(FSliderThumbStyle other, double t) => .new(
    color: .lerpColor(color, other.color, t),
    borderColor: .lerpColor(borderColor, other.borderColor, t),
    borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FSliderThumbStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color> get color;
  FWidgetStateMap<Color> get borderColor;
  double get borderWidth;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FSliderThumbStyle] to replace functions that accept and return a [FSliderThumbStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSliderThumbStyle Function(FSliderThumbStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSliderThumbStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSliderThumbStyle(...));
  /// ```
  @useResult
  FSliderThumbStyle call(Object? _) => this as FSliderThumbStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('color', color, level: .debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: .debug))
      ..add(DoubleProperty('borderWidth', borderWidth, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderThumbStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode => color.hashCode ^ borderColor.hashCode ^ borderWidth.hashCode ^ focusedOutlineStyle.hashCode;
}
