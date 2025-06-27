// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'divider.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FDividerStylesCopyWith on FDividerStyles {
  /// Returns a copy of this [FDividerStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [horizontalStyle]
  /// The horizontal divider's style.
  ///
  /// # [verticalStyle]
  /// The vertical divider's style.
  ///
  @useResult
  FDividerStyles copyWith({
    FDividerStyle Function(FDividerStyle)? horizontalStyle,
    FDividerStyle Function(FDividerStyle)? verticalStyle,
  }) => FDividerStyles(
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );
}

/// Provides a `copyWith` method.
extension $FDividerStyleCopyWith on FDividerStyle {
  /// Returns a copy of this [FDividerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [color]
  /// The color of the separating line.
  ///
  /// # [padding]
  /// The padding surrounding the separating line. Defaults to the appropriate padding in [defaultPadding].
  ///
  /// This property can be used to indent the start and end of the separating line.
  ///
  /// # [width]
  /// The width (thickness) of the separating line. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `width` <= 0.0
  /// * `width` is Nan
  ///
  @useResult
  FDividerStyle copyWith({Color? color, EdgeInsetsGeometry? padding, double? width}) =>
      FDividerStyle(color: color ?? this.color, padding: padding ?? this.padding, width: width ?? this.width);
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
