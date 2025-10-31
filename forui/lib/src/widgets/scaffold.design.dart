// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scaffold.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FScaffoldStyleTransformations on FScaffoldStyle {
  /// Returns a copy of this [FScaffoldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FScaffoldStyle.systemOverlayStyle] - The fallback system overlay style.
  /// * [FScaffoldStyle.backgroundColor] - The background color.
  /// * [FScaffoldStyle.sidebarBackgroundColor] - The sidebar background color.
  /// * [FScaffoldStyle.childPadding] - The child padding.
  /// * [FScaffoldStyle.headerDecoration] - The header decoration.
  /// * [FScaffoldStyle.footerDecoration] - The footer decoration.
  @useResult
  FScaffoldStyle copyWith({
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? backgroundColor,
    Color? sidebarBackgroundColor,
    EdgeInsetsGeometry? childPadding,
    BoxDecoration? headerDecoration,
    BoxDecoration? footerDecoration,
  }) => FScaffoldStyle(
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    sidebarBackgroundColor: sidebarBackgroundColor ?? this.sidebarBackgroundColor,
    childPadding: childPadding ?? this.childPadding,
    headerDecoration: headerDecoration ?? this.headerDecoration,
    footerDecoration: footerDecoration ?? this.footerDecoration,
  );

  /// Linearly interpolate between this and another [FScaffoldStyle] using the given factor [t].
  @useResult
  FScaffoldStyle lerp(FScaffoldStyle other, double t) => FScaffoldStyle(
    systemOverlayStyle: t < 0.5 ? systemOverlayStyle : other.systemOverlayStyle,
    backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
    sidebarBackgroundColor:
        Color.lerp(sidebarBackgroundColor, other.sidebarBackgroundColor, t) ?? sidebarBackgroundColor,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    headerDecoration: BoxDecoration.lerp(headerDecoration, other.headerDecoration, t) ?? headerDecoration,
    footerDecoration: BoxDecoration.lerp(footerDecoration, other.footerDecoration, t) ?? footerDecoration,
  );
}

mixin _$FScaffoldStyleFunctions on Diagnosticable {
  SystemUiOverlayStyle get systemOverlayStyle;
  Color get backgroundColor;
  Color get sidebarBackgroundColor;
  EdgeInsetsGeometry get childPadding;
  BoxDecoration get headerDecoration;
  BoxDecoration get footerDecoration;

  /// Returns itself.
  ///
  /// Allows [FScaffoldStyle] to replace functions that accept and return a [FScaffoldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FScaffoldStyle Function(FScaffoldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FScaffoldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FScaffoldStyle(...));
  /// ```
  @useResult
  FScaffoldStyle call(Object? _) => this as FScaffoldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle, level: DiagnosticLevel.debug))
      ..add(ColorProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(ColorProperty('sidebarBackgroundColor', sidebarBackgroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('headerDecoration', headerDecoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('footerDecoration', footerDecoration, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FScaffoldStyle &&
          systemOverlayStyle == other.systemOverlayStyle &&
          backgroundColor == other.backgroundColor &&
          sidebarBackgroundColor == other.sidebarBackgroundColor &&
          childPadding == other.childPadding &&
          headerDecoration == other.headerDecoration &&
          footerDecoration == other.footerDecoration);

  @override
  int get hashCode =>
      systemOverlayStyle.hashCode ^
      backgroundColor.hashCode ^
      sidebarBackgroundColor.hashCode ^
      childPadding.hashCode ^
      headerDecoration.hashCode ^
      footerDecoration.hashCode;
}
