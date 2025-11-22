// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'breadcrumb.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBreadcrumbStyleTransformations on FBreadcrumbStyle {
  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBreadcrumbStyle.textStyle] - The text style.
  /// * [FBreadcrumbStyle.iconStyle] - The divider icon style.
  /// * [FBreadcrumbStyle.padding] - The padding.
  /// * [FBreadcrumbStyle.tappableStyle] - The tappable's style.
  /// * [FBreadcrumbStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FBreadcrumbStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    IconThemeData? iconStyle,
    EdgeInsetsGeometry? padding,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => FBreadcrumbStyle(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    padding: padding ?? this.padding,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FBreadcrumbStyle] using the given factor [t].
  @useResult
  FBreadcrumbStyle lerp(FBreadcrumbStyle other, double t) => FBreadcrumbStyle(
    textStyle: FWidgetStateMap.lerpTextStyle(textStyle, other.textStyle, t),
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FBreadcrumbStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  IconThemeData get iconStyle;
  EdgeInsetsGeometry get padding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FBreadcrumbStyle] to replace functions that accept and return a [FBreadcrumbStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBreadcrumbStyle Function(FBreadcrumbStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBreadcrumbStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBreadcrumbStyle(...));
  /// ```
  @useResult
  FBreadcrumbStyle call(Object? _) => this as FBreadcrumbStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBreadcrumbStyle &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconStyle.hashCode ^
      padding.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}
