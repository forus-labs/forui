// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FButtonContentStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<TextStyle> get textStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  EdgeInsetsGeometry get padding;

  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FButtonContentStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    EdgeInsetsGeometry? padding,
  }) => FButtonContentStyle(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    padding: padding ?? this.padding,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonContentStyle &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding);
  @override
  int get hashCode => textStyle.hashCode ^ iconStyle.hashCode ^ padding.hashCode;
}
mixin _$FButtonIconContentStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  EdgeInsetsGeometry get padding;

  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FButtonIconContentStyle copyWith({FWidgetStateMap<IconThemeData>? iconStyle, EdgeInsetsGeometry? padding}) =>
      FButtonIconContentStyle(iconStyle: iconStyle ?? this.iconStyle, padding: padding ?? this.padding);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonIconContentStyle && iconStyle == other.iconStyle && padding == other.padding);
  @override
  int get hashCode => iconStyle.hashCode ^ padding.hashCode;
}
