// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scaffold.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FScaffoldStyleFunctions on Diagnosticable implements FTransformable {
  Color get backgroundColor;
  Color get sidebarBackgroundColor;
  EdgeInsetsGeometry get childPadding;
  BoxDecoration get headerDecoration;
  BoxDecoration get footerDecoration;

  /// Returns a copy of this [FScaffoldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FScaffoldStyle copyWith({
    Color? backgroundColor,
    Color? sidebarBackgroundColor,
    EdgeInsetsGeometry? childPadding,
    BoxDecoration? headerDecoration,
    BoxDecoration? footerDecoration,
  }) => FScaffoldStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    sidebarBackgroundColor: sidebarBackgroundColor ?? this.sidebarBackgroundColor,
    childPadding: childPadding ?? this.childPadding,
    headerDecoration: headerDecoration ?? this.headerDecoration,
    footerDecoration: footerDecoration ?? this.footerDecoration,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('sidebarBackgroundColor', sidebarBackgroundColor))
      ..add(DiagnosticsProperty('childPadding', childPadding))
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration))
      ..add(DiagnosticsProperty('footerDecoration', footerDecoration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FScaffoldStyle &&
          backgroundColor == other.backgroundColor &&
          sidebarBackgroundColor == other.sidebarBackgroundColor &&
          childPadding == other.childPadding &&
          headerDecoration == other.headerDecoration &&
          footerDecoration == other.footerDecoration);
  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      sidebarBackgroundColor.hashCode ^
      childPadding.hashCode ^
      headerDecoration.hashCode ^
      footerDecoration.hashCode;
}
