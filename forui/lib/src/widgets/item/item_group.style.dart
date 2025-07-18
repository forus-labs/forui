// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'item_group.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FItemGroupStyleCopyWith on FItemGroupStyle {
  /// Returns a copy of this [FItemGroupStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The group's decoration.
  ///
  /// # [spacing]
  /// The vertical spacing at the top and bottom of each group. Defaults to 4.
  ///
  /// # [dividerColor]
  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  ///
  /// # [dividerWidth]
  /// The divider's width.
  ///
  /// # [itemStyle]
  /// The item's style.
  ///
  @useResult
  FItemGroupStyle copyWith({
    BoxDecoration? decoration,
    double? spacing,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    FItemStyle Function(FItemStyle)? itemStyle,
  }) => FItemGroupStyle(
    decoration: decoration ?? this.decoration,
    spacing: spacing ?? this.spacing,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
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
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
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
