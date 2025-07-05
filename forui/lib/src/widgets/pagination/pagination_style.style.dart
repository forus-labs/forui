// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'pagination_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FPaginationStyleCopyWith on FPaginationStyle {
  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [itemPadding]
  /// The padding around each item. Defaults to EdgeInsets.symmetric(horizontal: 2)`.
  ///
  /// # [itemConstraints]
  /// The item's constraints. Defaults to `BoxConstraints(maxWidth: 40, minWidth: 40, maxHeight: 40, minHeight: 40)`.
  ///
  /// # [itemIconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [itemDecoration]
  /// The decoration applied to the pagination item.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [itemTextStyle]
  /// The default text style applied to the pagination item.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [ellipsisTextStyle]
  /// The ellipsis's text style.
  ///
  /// # [actionTappableStyle]
  /// The action's tappable style.
  ///
  /// # [pageTappableStyle]
  /// The pagination item's tappable style.
  ///
  /// # [focusedOutlineStyle]
  /// The pagination item's focused outline style.
  ///
  @useResult
  FPaginationStyle copyWith({
    EdgeInsets? itemPadding,
    BoxConstraints? itemConstraints,
    FWidgetStateMap<IconThemeData>? itemIconStyle,
    FWidgetStateMap<BoxDecoration>? itemDecoration,
    FWidgetStateMap<TextStyle>? itemTextStyle,
    TextStyle? ellipsisTextStyle,
    FTappableStyle Function(FTappableStyle)? actionTappableStyle,
    FTappableStyle Function(FTappableStyle)? pageTappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FPaginationStyle(
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
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('itemConstraints', itemConstraints))
      ..add(DiagnosticsProperty('itemIconStyle', itemIconStyle))
      ..add(DiagnosticsProperty('itemDecoration', itemDecoration))
      ..add(DiagnosticsProperty('itemTextStyle', itemTextStyle))
      ..add(DiagnosticsProperty('ellipsisTextStyle', ellipsisTextStyle))
      ..add(DiagnosticsProperty('actionTappableStyle', actionTappableStyle))
      ..add(DiagnosticsProperty('pageTappableStyle', pageTappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPaginationStyle &&
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
