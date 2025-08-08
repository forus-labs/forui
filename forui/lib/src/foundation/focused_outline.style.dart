// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'focused_outline.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FFocusedOutlineStyleCopyWith on FFocusedOutlineStyle {
  /// Returns a copy of this [FFocusedOutlineStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [color]
  /// The outline's color.
  ///
  /// # [borderRadius]
  /// The border radius.
  ///
  /// # [width]
  /// The outline's width. Defaults to 1.
  ///
  /// ## Contract
  /// Must be > 0.
  ///
  /// # [spacing]
  /// The spacing between the outline and the outlined widget. Defaults to 3.
  ///
  @useResult
  FFocusedOutlineStyle copyWith({Color? color, BorderRadiusGeometry? borderRadius, double? width, double? spacing}) =>
      FFocusedOutlineStyle(
        color: color ?? this.color,
        borderRadius: borderRadius ?? this.borderRadius,
        width: width ?? this.width,
        spacing: spacing ?? this.spacing,
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
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('spacing', spacing));
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
