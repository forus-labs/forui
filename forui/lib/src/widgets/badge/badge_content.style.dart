// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FBadgeContentStyleFunctions on Diagnosticable implements FTransformable {
  TextStyle get labelTextStyle;
  EdgeInsetsGeometry get padding;

  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FBadgeContentStyle copyWith({TextStyle? labelTextStyle, EdgeInsetsGeometry? padding}) =>
      FBadgeContentStyle(labelTextStyle: labelTextStyle ?? this.labelTextStyle, padding: padding ?? this.padding);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeContentStyle && labelTextStyle == other.labelTextStyle && padding == other.padding);
  @override
  int get hashCode => labelTextStyle.hashCode ^ padding.hashCode;
}
