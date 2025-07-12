// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'thumb.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSliderThumbStyleCopyWith on FSliderThumbStyle {
  /// Returns a copy of this [FSliderThumbStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [color]
  /// The thumb's color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [borderColor]
  /// The border's color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [borderWidth]
  /// The border's width. Defaults to `2`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [borderWidth] is not positive.
  ///
  /// # [focusedOutlineStyle]
  /// The thumb's focused outline style.
  ///
  @useResult
  FSliderThumbStyle copyWith({
    FWidgetStateMap<Color>? color,
    FWidgetStateMap<Color>? borderColor,
    double? borderWidth,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FSliderThumbStyle(
    color: color ?? this.color,
    borderColor: borderColor ?? this.borderColor,
    borderWidth: borderWidth ?? this.borderWidth,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
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
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('borderColor', borderColor))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderThumbStyle &&
          color == other.color &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode => color.hashCode ^ borderColor.hashCode ^ borderWidth.hashCode ^ focusedOutlineStyle.hashCode;
}
