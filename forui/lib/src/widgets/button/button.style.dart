// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FButtonStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<BoxDecoration> get decoration;
  FButtonContentStyle get contentStyle;
  FButtonIconContentStyle get iconContentStyle;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FButtonStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FButtonStyle copyWith({
    FWidgetStateMap<BoxDecoration>? decoration,
    FButtonContentStyle? contentStyle,
    FButtonIconContentStyle? iconContentStyle,
    FTappableStyle? tappableStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FButtonStyle(
    decoration: decoration ?? this.decoration,
    contentStyle: contentStyle ?? this.contentStyle,
    iconContentStyle: iconContentStyle ?? this.iconContentStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentStyle', contentStyle))
      ..add(DiagnosticsProperty('iconContentStyle', iconContentStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonStyle &&
          decoration == other.decoration &&
          contentStyle == other.contentStyle &&
          iconContentStyle == other.iconContentStyle &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode =>
      decoration.hashCode ^
      contentStyle.hashCode ^
      iconContentStyle.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
