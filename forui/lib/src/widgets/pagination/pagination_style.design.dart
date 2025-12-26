// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'pagination_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPaginationStyleTransformations on FPaginationStyle {
  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FPaginationStyle.itemPadding] - The padding around each item.
  /// * [FPaginationStyle.itemConstraints] - The item's constraints.
  /// * [FPaginationStyle.itemIconStyle] - The icon's style.
  /// * [FPaginationStyle.itemDecoration] - The decoration applied to the pagination item.
  /// * [FPaginationStyle.itemTextStyle] - The default text style applied to the pagination item.
  /// * [FPaginationStyle.ellipsisTextStyle] - The ellipsis's text style.
  /// * [FPaginationStyle.actionTappableStyle] - The action's tappable style.
  /// * [FPaginationStyle.pageTappableStyle] - The pagination item's tappable style.
  /// * [FPaginationStyle.focusedOutlineStyle] - The pagination item's focused outline style.
  @useResult
  FPaginationStyle copyWith({
    EdgeInsets? itemPadding,
    BoxConstraints? itemConstraints,
    FWidgetStateMap<IconThemeData>? itemIconStyle,
    FWidgetStateMap<BoxDecoration>? itemDecoration,
    FWidgetStateMap<TextStyle>? itemTextStyle,
    TextStyle? ellipsisTextStyle,
    FTappableStyle Function(FTappableStyle style)? actionTappableStyle,
    FTappableStyle Function(FTappableStyle style)? pageTappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => .new(
    itemPadding: itemPadding ?? this.itemPadding,
    itemConstraints: itemConstraints ?? this.itemConstraints,
    itemIconStyle: itemIconStyle ?? this.itemIconStyle,
    itemDecoration: itemDecoration ?? this.itemDecoration,
    itemTextStyle: itemTextStyle ?? this.itemTextStyle,
    ellipsisTextStyle: ellipsisTextStyle ?? this.ellipsisTextStyle,
    actionTappableStyle: actionTappableStyle != null
        ? actionTappableStyle(this.actionTappableStyle)
        : this.actionTappableStyle,
    pageTappableStyle: pageTappableStyle != null ? pageTappableStyle(this.pageTappableStyle) : this.pageTappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FPaginationStyle] using the given factor [t].
  @useResult
  FPaginationStyle lerp(FPaginationStyle other, double t) => .new(
    itemPadding: .lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
    itemConstraints: .lerp(itemConstraints, other.itemConstraints, t) ?? itemConstraints,
    itemIconStyle: .lerpIconThemeData(itemIconStyle, other.itemIconStyle, t),
    itemDecoration: .lerpBoxDecoration(itemDecoration, other.itemDecoration, t),
    itemTextStyle: .lerpTextStyle(itemTextStyle, other.itemTextStyle, t),
    ellipsisTextStyle: .lerp(ellipsisTextStyle, other.ellipsisTextStyle, t) ?? ellipsisTextStyle,
    actionTappableStyle: actionTappableStyle.lerp(other.actionTappableStyle, t),
    pageTappableStyle: pageTappableStyle.lerp(other.pageTappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FPaginationStyleFunctions on Diagnosticable {
  EdgeInsets get itemPadding;
  BoxConstraints get itemConstraints;
  FWidgetStateMap<IconThemeData> get itemIconStyle;
  FWidgetStateMap<BoxDecoration> get itemDecoration;
  FWidgetStateMap<TextStyle> get itemTextStyle;
  TextStyle get ellipsisTextStyle;
  FTappableStyle get actionTappableStyle;
  FTappableStyle get pageTappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FPaginationStyle] to replace functions that accept and return a [FPaginationStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FPaginationStyle Function(FPaginationStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FPaginationStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FPaginationStyle(...));
  /// ```
  @useResult
  FPaginationStyle call(Object? _) => this as FPaginationStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemPadding', itemPadding, level: .debug))
      ..add(DiagnosticsProperty('itemConstraints', itemConstraints, level: .debug))
      ..add(DiagnosticsProperty('itemIconStyle', itemIconStyle, level: .debug))
      ..add(DiagnosticsProperty('itemDecoration', itemDecoration, level: .debug))
      ..add(DiagnosticsProperty('itemTextStyle', itemTextStyle, level: .debug))
      ..add(DiagnosticsProperty('ellipsisTextStyle', ellipsisTextStyle, level: .debug))
      ..add(DiagnosticsProperty('actionTappableStyle', actionTappableStyle, level: .debug))
      ..add(DiagnosticsProperty('pageTappableStyle', pageTappableStyle, level: .debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPaginationStyle &&
          runtimeType == other.runtimeType &&
          itemPadding == other.itemPadding &&
          itemConstraints == other.itemConstraints &&
          itemIconStyle == other.itemIconStyle &&
          itemDecoration == other.itemDecoration &&
          itemTextStyle == other.itemTextStyle &&
          ellipsisTextStyle == other.ellipsisTextStyle &&
          actionTappableStyle == other.actionTappableStyle &&
          pageTappableStyle == other.pageTappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      itemPadding.hashCode ^
      itemConstraints.hashCode ^
      itemIconStyle.hashCode ^
      itemDecoration.hashCode ^
      itemTextStyle.hashCode ^
      ellipsisTextStyle.hashCode ^
      actionTappableStyle.hashCode ^
      pageTappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
