// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FItemGroupStyleTransformations on FItemGroupStyle {
  /// Returns a copy of this [FItemGroupStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FItemGroupStyle.decoration] - The group's decoration.
  /// * [FItemGroupStyle.spacing] - The vertical spacing at the top and bottom of each group.
  /// * [FItemGroupStyle.dividerColor] - The divider's style.
  /// * [FItemGroupStyle.dividerWidth] - The divider's width.
  /// * [FItemGroupStyle.itemStyle] - The item's style.
  @useResult
  FItemGroupStyle copyWith({
    BoxDecoration? decoration,
    double? spacing,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    FItemStyle Function(FItemStyle style)? itemStyle,
  }) => FItemGroupStyle(
    decoration: decoration ?? this.decoration,
    spacing: spacing ?? this.spacing,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );

  /// Linearly interpolate between this and another [FItemGroupStyle] using the given factor [t].
  @useResult
  FItemGroupStyle lerp(FItemGroupStyle other, double t) => FItemGroupStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    dividerColor: FWidgetStateMap.lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FItemGroupStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  double get spacing;
  FWidgetStateMap<Color> get dividerColor;
  double get dividerWidth;
  FItemStyle get itemStyle;

  /// Returns itself.
  ///
  /// Allows [FItemGroupStyle] to replace functions that accept and return a [FItemGroupStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FItemGroupStyle Function(FItemGroupStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FItemGroupStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FItemGroupStyle(...));
  /// ```
  @useResult
  FItemGroupStyle call(Object? _) => this as FItemGroupStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('spacing', spacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FItemGroupStyle &&
          decoration == other.decoration &&
          spacing == other.spacing &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          itemStyle == other.itemStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^ spacing.hashCode ^ dividerColor.hashCode ^ dividerWidth.hashCode ^ itemStyle.hashCode;
}
