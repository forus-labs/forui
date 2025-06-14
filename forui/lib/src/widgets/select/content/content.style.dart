// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSelectContentStyleFunctions on Diagnosticable implements FTransformable {
  FSelectSectionStyle get sectionStyle;
  FSelectScrollHandleStyle get scrollHandleStyle;
  EdgeInsetsGeometry get padding;

  /// Returns a copy of this [FSelectContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSelectContentStyle copyWith({
    FSelectSectionStyle? sectionStyle,
    FSelectScrollHandleStyle? scrollHandleStyle,
    EdgeInsetsGeometry? padding,
  }) => FSelectContentStyle(
    sectionStyle: sectionStyle ?? this.sectionStyle,
    scrollHandleStyle: scrollHandleStyle ?? this.scrollHandleStyle,
    padding: padding ?? this.padding,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle))
      ..add(DiagnosticsProperty('scrollHandleStyle', scrollHandleStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectContentStyle &&
          sectionStyle == other.sectionStyle &&
          scrollHandleStyle == other.scrollHandleStyle &&
          padding == other.padding);
  @override
  int get hashCode => sectionStyle.hashCode ^ scrollHandleStyle.hashCode ^ padding.hashCode;
}
