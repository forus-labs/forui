// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'alert.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FAlertStylesFunctions on Diagnosticable implements FTransformable {
  FAlertStyle get primary;
  FAlertStyle get destructive;

  /// Returns a copy of this [FAlertStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FAlertStyles copyWith({FAlertStyle? primary, FAlertStyle? destructive}) =>
      FAlertStyles(primary: primary ?? this.primary, destructive: destructive ?? this.destructive);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('destructive', destructive));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FAlertStyles && primary == other.primary && destructive == other.destructive);
  @override
  int get hashCode => primary.hashCode ^ destructive.hashCode;
}
mixin _$FAlertStyleFunctions on Diagnosticable implements FTransformable {
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  IconThemeData get iconStyle;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;

  /// Returns a copy of this [FAlertStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FAlertStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    IconThemeData? iconStyle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) => FAlertStyle(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    iconStyle: iconStyle ?? this.iconStyle,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAlertStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          iconStyle == other.iconStyle &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode;
}
