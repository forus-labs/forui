// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FHeaderStylesFunctions on Diagnosticable implements FTransformable {
  FHeaderStyle get rootStyle;
  FHeaderStyle get nestedStyle;

  /// Returns a copy of this [FHeaderStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FHeaderStyles copyWith({FHeaderStyle? rootStyle, FHeaderStyle? nestedStyle}) =>
      FHeaderStyles(rootStyle: rootStyle ?? this.rootStyle, nestedStyle: nestedStyle ?? this.nestedStyle);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('rootStyle', rootStyle))
      ..add(DiagnosticsProperty('nestedStyle', nestedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyles && rootStyle == other.rootStyle && nestedStyle == other.nestedStyle);
  @override
  int get hashCode => rootStyle.hashCode ^ nestedStyle.hashCode;
}
mixin _$FHeaderStyleFunctions on Diagnosticable implements FTransformable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  double get actionSpacing;
  TextStyle get titleTextStyle;
  FHeaderActionStyle get actionStyle;

  /// Returns a copy of this [FHeaderStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FHeaderStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    double? actionSpacing,
    TextStyle? titleTextStyle,
    FHeaderActionStyle? actionStyle,
  }) => FHeaderStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    actionSpacing: actionSpacing ?? this.actionSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    actionStyle: actionStyle ?? this.actionStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('actionSpacing', actionSpacing))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('actionStyle', actionStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          actionSpacing == other.actionSpacing &&
          titleTextStyle == other.titleTextStyle &&
          actionStyle == other.actionStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      actionSpacing.hashCode ^
      titleTextStyle.hashCode ^
      actionStyle.hashCode;
}
mixin _$FHeaderActionStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FTappableStyle get tappableStyle;

  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FHeaderActionStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
    FTappableStyle? tappableStyle,
  }) => FHeaderActionStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FHeaderActionStyle &&
          iconStyle == other.iconStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          tappableStyle == other.tappableStyle);
  @override
  int get hashCode => iconStyle.hashCode ^ focusedOutlineStyle.hashCode ^ tappableStyle.hashCode;
}
