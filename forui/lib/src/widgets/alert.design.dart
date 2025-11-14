// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'alert.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAlertStylesTransformations on FAlertStyles {
  /// Returns a copy of this [FAlertStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAlertStyles.primary] - The primary alert style.
  /// * [FAlertStyles.destructive] - The destructive alert style.
  @useResult
  FAlertStyles copyWith({
    FAlertStyle Function(FAlertStyle style)? primary,
    FAlertStyle Function(FAlertStyle style)? destructive,
  }) => FAlertStyles(
    primary: primary != null ? primary(this.primary) : this.primary,
    destructive: destructive != null ? destructive(this.destructive) : this.destructive,
  );

  /// Linearly interpolate between this and another [FAlertStyles] using the given factor [t].
  @useResult
  FAlertStyles lerp(FAlertStyles other, double t) =>
      FAlertStyles(primary: primary.lerp(other.primary, t), destructive: destructive.lerp(other.destructive, t));
}

mixin _$FAlertStylesFunctions on Diagnosticable {
  FAlertStyle get primary;
  FAlertStyle get destructive;

  /// Returns itself.
  ///
  /// Allows [FAlertStyles] to replace functions that accept and return a [FAlertStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAlertStyles Function(FAlertStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAlertStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAlertStyles(...));
  /// ```
  @useResult
  FAlertStyles call(Object? _) => this as FAlertStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('destructive', destructive, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FAlertStyles && primary == other.primary && destructive == other.destructive);

  @override
  int get hashCode => primary.hashCode ^ destructive.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FAlertStyleTransformations on FAlertStyle {
  /// Returns a copy of this [FAlertStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAlertStyle.decoration] - The decoration.
  /// * [FAlertStyle.padding] - The padding.
  /// * [FAlertStyle.iconStyle] - The icon's style.
  /// * [FAlertStyle.titleTextStyle] - The title's [TextStyle].
  /// * [FAlertStyle.subtitleTextStyle] - The subtitle's [TextStyle].
  @useResult
  FAlertStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    IconThemeData? iconStyle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) => FAlertStyle(
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    iconStyle: iconStyle ?? this.iconStyle,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
  );

  /// Linearly interpolate between this and another [FAlertStyle] using the given factor [t].
  @useResult
  FAlertStyle lerp(FAlertStyle other, double t) => FAlertStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t) ?? subtitleTextStyle,
  );
}

mixin _$FAlertStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  IconThemeData get iconStyle;
  TextStyle get titleTextStyle;
  TextStyle get subtitleTextStyle;

  /// Returns itself.
  ///
  /// Allows [FAlertStyle] to replace functions that accept and return a [FAlertStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAlertStyle Function(FAlertStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAlertStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAlertStyle(...));
  /// ```
  @useResult
  FAlertStyle call(Object? _) => this as FAlertStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAlertStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          iconStyle == other.iconStyle &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode;
}
