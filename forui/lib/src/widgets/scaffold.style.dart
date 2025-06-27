// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scaffold.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FScaffoldStyleCopyWith on FScaffoldStyle {
  /// Returns a copy of this [FScaffoldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [systemOverlayStyle]
  /// The fallback system overlay style.
  ///
  /// This is used as a fallback when no other widgets override [AnnotatedRegion<SystemUiOverlayStyle>]. Typically, the
  /// [SystemUiOverlayStyle] property is overridden by [FHeader].
  ///
  /// # [backgroundColor]
  /// The background color.
  ///
  /// # [sidebarBackgroundColor]
  /// The sidebar background color.
  ///
  /// # [childPadding]
  /// The child padding. Only used when [FScaffold.childPad] is `true`.
  ///
  /// # [headerDecoration]
  /// The header decoration.
  ///
  /// # [footerDecoration]
  /// The footer decoration.
  ///
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
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle))
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
