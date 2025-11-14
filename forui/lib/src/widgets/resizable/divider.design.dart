// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FResizableDividerStyleTransformations on FResizableDividerStyle {
  /// Returns a copy of this [FResizableDividerStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableDividerStyle.color] - The divider's color.
  /// * [FResizableDividerStyle.width] - The divider's width (thickness).
  /// * [FResizableDividerStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FResizableDividerStyle.thumbStyle] - The divider thumb's style.
  @useResult
  FResizableDividerStyle copyWith({
    Color? color,
    double? width,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FResizableDividerThumbStyle Function(FResizableDividerThumbStyle style)? thumbStyle,
  }) => FResizableDividerStyle(
    color: color ?? this.color,
    width: width ?? this.width,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    thumbStyle: thumbStyle != null ? thumbStyle(this.thumbStyle) : this.thumbStyle,
  );

  /// Linearly interpolate between this and another [FResizableDividerStyle] using the given factor [t].
  @useResult
  FResizableDividerStyle lerp(FResizableDividerStyle other, double t) => FResizableDividerStyle(
    color: Color.lerp(color, other.color, t) ?? color,
    width: lerpDouble(width, other.width, t) ?? width,
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    thumbStyle: thumbStyle.lerp(other.thumbStyle, t),
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
      ..add(ColorProperty('color', color, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('width', width, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle, level: DiagnosticLevel.debug));
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

/// Provides [copyWith] and [lerp] methods.
extension $FResizableDividerThumbStyleTransformations on FResizableDividerThumbStyle {
  /// Returns a copy of this [FResizableDividerThumbStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FResizableDividerThumbStyle.decoration] - The background color.
  /// * [FResizableDividerThumbStyle.foregroundColor] - The foreground color.
  /// * [FResizableDividerThumbStyle.height] - The height.
  /// * [FResizableDividerThumbStyle.width] - The width.
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

  /// Linearly interpolate between this and another [FResizableDividerThumbStyle] using the given factor [t].
  @useResult
  FResizableDividerThumbStyle lerp(FResizableDividerThumbStyle other, double t) => FResizableDividerThumbStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
    height: lerpDouble(height, other.height, t) ?? height,
    width: lerpDouble(width, other.width, t) ?? width,
  );
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
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(ColorProperty('foregroundColor', foregroundColor, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('height', height, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('width', width, level: DiagnosticLevel.debug));
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
