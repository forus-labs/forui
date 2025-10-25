// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDividerStylesTransformations on FDividerStyles {
  /// Returns a copy of this [FDividerStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDividerStyles.horizontalStyle] - The horizontal divider's style.
  /// * [FDividerStyles.verticalStyle] - The vertical divider's style.
  @useResult
  FDividerStyles copyWith({
    FDividerStyle Function(FDividerStyle style)? horizontalStyle,
    FDividerStyle Function(FDividerStyle style)? verticalStyle,
  }) => FDividerStyles(
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );

  /// Linearly interpolate between this and another [FDividerStyles] using the given factor [t].
  @useResult
  FDividerStyles lerp(FDividerStyles other, double t) => FDividerStyles(
    horizontalStyle: horizontalStyle.lerp(other.horizontalStyle, t),
    verticalStyle: verticalStyle.lerp(other.verticalStyle, t),
  );
}

mixin _$FDividerStylesFunctions on Diagnosticable {
  FDividerStyle get horizontalStyle;
  FDividerStyle get verticalStyle;

  /// Returns itself.
  ///
  /// Allows [FDividerStyles] to replace functions that accept and return a [FDividerStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDividerStyles Function(FDividerStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDividerStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDividerStyles(...));
  /// ```
  @useResult
  FDividerStyles call(Object? _) => this as FDividerStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDividerStyles && horizontalStyle == other.horizontalStyle && verticalStyle == other.verticalStyle);

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDividerStyleTransformations on FDividerStyle {
  /// Returns a copy of this [FDividerStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDividerStyle.color] - The color of the separating line.
  /// * [FDividerStyle.padding] - The padding surrounding the separating line.
  /// * [FDividerStyle.width] - The width (thickness) of the separating line.
  @useResult
  FDividerStyle copyWith({Color? color, EdgeInsetsGeometry? padding, double? width}) =>
      FDividerStyle(color: color ?? this.color, padding: padding ?? this.padding, width: width ?? this.width);

  /// Linearly interpolate between this and another [FDividerStyle] using the given factor [t].
  @useResult
  FDividerStyle lerp(FDividerStyle other, double t) => FDividerStyle(
    color: Color.lerp(color, other.color, t) ?? color,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    width: lerpDouble(width, other.width, t) ?? width,
  );
}

mixin _$FDividerStyleFunctions on Diagnosticable {
  Color get color;
  EdgeInsetsGeometry get padding;
  double get width;

  /// Returns itself.
  ///
  /// Allows [FDividerStyle] to replace functions that accept and return a [FDividerStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDividerStyle Function(FDividerStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDividerStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDividerStyle(...));
  /// ```
  @useResult
  FDividerStyle call(Object? _) => this as FDividerStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('width', width, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDividerStyle && color == other.color && padding == other.padding && width == other.width);

  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ width.hashCode;
}
