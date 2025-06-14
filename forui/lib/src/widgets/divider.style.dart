// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FDividerStylesFunctions on Diagnosticable implements FTransformable {
  FDividerStyle get horizontalStyle;
  FDividerStyle get verticalStyle;

  /// Returns a copy of this [FDividerStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FDividerStyles copyWith({FDividerStyle? horizontalStyle, FDividerStyle? verticalStyle}) => FDividerStyles(
    horizontalStyle: horizontalStyle ?? this.horizontalStyle,
    verticalStyle: verticalStyle ?? this.verticalStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDividerStyles && horizontalStyle == other.horizontalStyle && verticalStyle == other.verticalStyle);
  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}
mixin _$FDividerStyleFunctions on Diagnosticable implements FTransformable {
  Color get color;
  EdgeInsetsGeometry get padding;
  double get width;

  /// Returns a copy of this [FDividerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FDividerStyle copyWith({Color? color, EdgeInsetsGeometry? padding, double? width}) =>
      FDividerStyle(color: color ?? this.color, padding: padding ?? this.padding, width: width ?? this.width);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('width', width));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDividerStyle && color == other.color && padding == other.padding && width == other.width);
  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ width.hashCode;
}
