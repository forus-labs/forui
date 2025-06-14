// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FCardStyleFunctions on Diagnosticable implements FTransformable {
  BoxDecoration get decoration;
  FCardContentStyle get contentStyle;

  /// Returns a copy of this [FCardStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FCardStyle copyWith({BoxDecoration? decoration, FCardContentStyle? contentStyle}) =>
      FCardStyle(decoration: decoration ?? this.decoration, contentStyle: contentStyle ?? this.contentStyle);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCardStyle && decoration == other.decoration && contentStyle == other.contentStyle);
  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}
