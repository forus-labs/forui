// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'focused_outline.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FFocusedOutlineStyleTransformations on FFocusedOutlineStyle {
  /// Returns a copy of this [FFocusedOutlineStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FFocusedOutlineStyle.color] - The outline's color.
  /// * [FFocusedOutlineStyle.borderRadius] - The border radius.
  /// * [FFocusedOutlineStyle.width] - The outline's width.
  /// * [FFocusedOutlineStyle.spacing] - The spacing between the outline and the outlined widget.
  @useResult
  FFocusedOutlineStyle copyWith({Color? color, BorderRadiusGeometry? borderRadius, double? width, double? spacing}) =>
      FFocusedOutlineStyle(
        color: color ?? this.color,
        borderRadius: borderRadius ?? this.borderRadius,
        width: width ?? this.width,
        spacing: spacing ?? this.spacing,
      );

  /// Linearly interpolate between this and another [FFocusedOutlineStyle] using the given factor [t].
  @useResult
  FFocusedOutlineStyle lerp(FFocusedOutlineStyle other, double t) => FFocusedOutlineStyle(
    color: Color.lerp(color, other.color, t) ?? color,
    borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    width: lerpDouble(width, other.width, t) ?? width,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FFocusedOutlineStyleFunctions on Diagnosticable {
  Color get color;
  BorderRadiusGeometry get borderRadius;
  double get width;
  double get spacing;

  /// Returns itself.
  ///
  /// Allows [FFocusedOutlineStyle] to replace functions that accept and return a [FFocusedOutlineStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FFocusedOutlineStyle Function(FFocusedOutlineStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FFocusedOutlineStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FFocusedOutlineStyle(...));
  /// ```
  @useResult
  FFocusedOutlineStyle call(Object? _) => this as FFocusedOutlineStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('width', width, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('spacing', spacing, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FFocusedOutlineStyle &&
          color == other.color &&
          borderRadius == other.borderRadius &&
          width == other.width &&
          spacing == other.spacing);

  @override
  int get hashCode => color.hashCode ^ borderRadius.hashCode ^ width.hashCode ^ spacing.hashCode;
}
