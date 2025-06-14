// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'resizable.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FResizableStyleFunctions on Diagnosticable implements FTransformable {
  FResizableDividerStyle get horizontalDividerStyle;
  FResizableDividerStyle get verticalDividerStyle;

  /// Returns a copy of this [FResizableStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FResizableStyle copyWith({
    FResizableDividerStyle? horizontalDividerStyle,
    FResizableDividerStyle? verticalDividerStyle,
  }) => FResizableStyle(
    horizontalDividerStyle: horizontalDividerStyle ?? this.horizontalDividerStyle,
    verticalDividerStyle: verticalDividerStyle ?? this.verticalDividerStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalDividerStyle', horizontalDividerStyle))
      ..add(DiagnosticsProperty('verticalDividerStyle', verticalDividerStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FResizableStyle &&
          horizontalDividerStyle == other.horizontalDividerStyle &&
          verticalDividerStyle == other.verticalDividerStyle);
  @override
  int get hashCode => horizontalDividerStyle.hashCode ^ verticalDividerStyle.hashCode;
}
