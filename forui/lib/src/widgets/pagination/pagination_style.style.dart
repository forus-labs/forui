// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'pagination_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FPaginationStyleFunctions on Diagnosticable implements FTransformable {
  EdgeInsets get itemPadding;
  BoxConstraints get itemConstraints;
  FWidgetStateMap<IconThemeData> get itemIconStyle;
  FWidgetStateMap<BoxDecoration> get itemDecoration;
  FWidgetStateMap<TextStyle> get itemTextStyle;
  TextStyle get ellipsisTextStyle;
  FTappableStyle get actionTappableStyle;
  FTappableStyle get pageTappableStyle;

  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FPaginationStyle copyWith({
    EdgeInsets? itemPadding,
    BoxConstraints? itemConstraints,
    FWidgetStateMap<IconThemeData>? itemIconStyle,
    FWidgetStateMap<BoxDecoration>? itemDecoration,
    FWidgetStateMap<TextStyle>? itemTextStyle,
    TextStyle? ellipsisTextStyle,
    FTappableStyle? actionTappableStyle,
    FTappableStyle? pageTappableStyle,
  }) => FPaginationStyle(
    itemPadding: itemPadding ?? this.itemPadding,
    itemConstraints: itemConstraints ?? this.itemConstraints,
    itemIconStyle: itemIconStyle ?? this.itemIconStyle,
    itemDecoration: itemDecoration ?? this.itemDecoration,
    itemTextStyle: itemTextStyle ?? this.itemTextStyle,
    ellipsisTextStyle: ellipsisTextStyle ?? this.ellipsisTextStyle,
    actionTappableStyle: actionTappableStyle ?? this.actionTappableStyle,
    pageTappableStyle: pageTappableStyle ?? this.pageTappableStyle,
  );
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
      ..add(DiagnosticsProperty('pageTappableStyle', pageTappableStyle));
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
          pageTappableStyle == other.pageTappableStyle);
  @override
  int get hashCode =>
      itemPadding.hashCode ^
      itemConstraints.hashCode ^
      itemIconStyle.hashCode ^
      itemDecoration.hashCode ^
      itemTextStyle.hashCode ^
      ellipsisTextStyle.hashCode ^
      actionTappableStyle.hashCode ^
      pageTappableStyle.hashCode;
}
