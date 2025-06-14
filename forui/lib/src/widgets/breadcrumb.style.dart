// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'breadcrumb.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FBreadcrumbStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<TextStyle> get textStyle;
  IconThemeData get iconStyle;
  EdgeInsetsGeometry get padding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FBreadcrumbStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    IconThemeData? iconStyle,
    EdgeInsetsGeometry? padding,
    FTappableStyle? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FBreadcrumbStyle(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    padding: padding ?? this.padding,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBreadcrumbStyle &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconStyle.hashCode ^
      padding.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
