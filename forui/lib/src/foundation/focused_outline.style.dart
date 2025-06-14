// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'focused_outline.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FFocusedOutlineStyleFunctions on Diagnosticable implements FTransformable {
  Color get color;
  BorderRadiusGeometry get borderRadius;
  double get width;
  double get spacing;

  /// Returns a copy of this [FFocusedOutlineStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FFocusedOutlineStyle copyWith({Color? color, BorderRadiusGeometry? borderRadius, double? width, double? spacing}) =>
      FFocusedOutlineStyle(
        color: color ?? this.color,
        borderRadius: borderRadius ?? this.borderRadius,
        width: width ?? this.width,
        spacing: spacing ?? this.spacing,
      );
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
