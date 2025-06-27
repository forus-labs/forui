// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FResizableDividerStyleCopyWith on FResizableDividerStyle {
  /// Returns a copy of this [FResizableDividerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [color]
  /// The divider's color.
  ///
  /// # [width]
  /// The divider's width (thickness). Defaults to `0.5`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [width] <= 0.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  /// # [thumbStyle]
  /// The divider thumb's style.
  ///
  @useResult
  FResizableDividerStyle copyWith({
    Color? color,
    double? width,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
    FResizableDividerThumbStyle Function(FResizableDividerThumbStyle)? thumbStyle,
  }) => FResizableDividerStyle(
    color: color ?? this.color,
    width: width ?? this.width,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    thumbStyle: thumbStyle != null ? thumbStyle(this.thumbStyle) : this.thumbStyle,
  );
}

/// Provides a `copyWith` method.
extension $FResizableDividerThumbStyleCopyWith on FResizableDividerThumbStyle {
  /// Returns a copy of this [FResizableDividerThumbStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The background color.
  ///
  /// # [foregroundColor]
  /// The foreground color.
  ///
  /// # [height]
  /// The height.
  ///
  /// ## Contract
  /// Throws [AssertionError] if height] <= 0.
  ///
  /// # [width]
  /// The width.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [width] <= 0.
  ///
  @useResult
  FResizableDividerThumbStyle copyWith({
    BoxDecoration? decoration,
    Color? foregroundColor,
    double? height,
    double? width,
  }) => FResizableDividerThumbStyle(
    decoration: decoration ?? this.decoration,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    height: height ?? this.height,
    width: width ?? this.width,
  );
}

mixin _$FResizableDividerStyleFunctions on Diagnosticable {
  Color get color;
  double get width;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FResizableDividerThumbStyle get thumbStyle;

  /// Returns itself.
  ///
  /// Allows [FResizableDividerStyle] to replace functions that accept and return a [FResizableDividerStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableDividerStyle Function(FResizableDividerStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableDividerStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableDividerStyle(...));
  /// ```
  @useResult
  FResizableDividerStyle call(Object? _) => this as FResizableDividerStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableDividerStyle &&
          color == other.color &&
          width == other.width &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          thumbStyle == other.thumbStyle);
  @override
  int get hashCode => color.hashCode ^ width.hashCode ^ focusedOutlineStyle.hashCode ^ thumbStyle.hashCode;
}
mixin _$FResizableDividerThumbStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  Color get foregroundColor;
  double get height;
  double get width;

  /// Returns itself.
  ///
  /// Allows [FResizableDividerThumbStyle] to replace functions that accept and return a [FResizableDividerThumbStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableDividerThumbStyle Function(FResizableDividerThumbStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableDividerThumbStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableDividerThumbStyle(...));
  /// ```
  @useResult
  FResizableDividerThumbStyle call(Object? _) => this as FResizableDividerThumbStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableDividerThumbStyle &&
          decoration == other.decoration &&
          foregroundColor == other.foregroundColor &&
          height == other.height &&
          width == other.width);
  @override
  int get hashCode => decoration.hashCode ^ foregroundColor.hashCode ^ height.hashCode ^ width.hashCode;
}
