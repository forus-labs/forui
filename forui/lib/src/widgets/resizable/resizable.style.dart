// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'resizable.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FResizableStyleCopyWith on FResizableStyle {
  /// Returns a copy of this [FResizableStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [horizontalDividerStyle]
  /// The horizontal divider style.
  ///
  /// # [verticalDividerStyle]
  /// The vertical divider style.
  ///
  @useResult
  FResizableStyle copyWith({
    FResizableDividerStyle Function(FResizableDividerStyle)? horizontalDividerStyle,
    FResizableDividerStyle Function(FResizableDividerStyle)? verticalDividerStyle,
  }) => FResizableStyle(
    horizontalDividerStyle: horizontalDividerStyle != null
        ? horizontalDividerStyle(this.horizontalDividerStyle)
        : this.horizontalDividerStyle,
    verticalDividerStyle: verticalDividerStyle != null
        ? verticalDividerStyle(this.verticalDividerStyle)
        : this.verticalDividerStyle,
  );
}

mixin _$FResizableStyleFunctions on Diagnosticable {
  FResizableDividerStyle get horizontalDividerStyle;
  FResizableDividerStyle get verticalDividerStyle;

  /// Returns itself.
  ///
  /// Allows [FResizableStyle] to replace functions that accept and return a [FResizableStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FResizableStyle Function(FResizableStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FResizableStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FResizableStyle(...));
  /// ```
  @useResult
  FResizableStyle call(Object? _) => this as FResizableStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalDividerStyle', horizontalDividerStyle))
      ..add(DiagnosticsProperty('verticalDividerStyle', verticalDividerStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableStyle &&
          horizontalDividerStyle == other.horizontalDividerStyle &&
          verticalDividerStyle == other.verticalDividerStyle);
  @override
  int get hashCode => horizontalDividerStyle.hashCode ^ verticalDividerStyle.hashCode;
}
