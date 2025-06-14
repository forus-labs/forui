// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tooltip.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTooltipStyleFunctions on Diagnosticable implements FTransformable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsets get padding;
  TextStyle get textStyle;

  /// Returns a copy of this [FTooltipStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FTooltipStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsets? padding,
    TextStyle? textStyle,
  }) => FTooltipStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    textStyle: textStyle ?? this.textStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('textStyle', textStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTooltipStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          textStyle == other.textStyle);
  @override
  int get hashCode => decoration.hashCode ^ backgroundFilter.hashCode ^ padding.hashCode ^ textStyle.hashCode;
}
