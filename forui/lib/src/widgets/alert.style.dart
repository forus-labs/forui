// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'alert.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FAlertStylesCopyWith on FAlertStyles {
  /// Returns a copy of this [FAlertStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [primary]
  /// The primary alert style.
  ///
  /// # [destructive]
  /// The destructive alert style.
  ///
  @useResult
  FAlertStyles copyWith({FAlertStyle Function(FAlertStyle)? primary, FAlertStyle Function(FAlertStyle)? destructive}) =>
      FAlertStyles(
        primary: primary != null ? primary(this.primary) : this.primary,
        destructive: destructive != null ? destructive(this.destructive) : this.destructive,
      );
}

/// Provides a `copyWith` method.
extension $FAlertStyleCopyWith on FAlertStyle {
  /// Returns a copy of this [FAlertStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 12)`.
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// # [titleTextStyle]
  /// The title's [TextStyle].
  ///
  /// # [subtitleTextStyle]
  /// The subtitle's [TextStyle].
  ///
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
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('destructive', destructive));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FAlertStyles && primary == other.primary && destructive == other.destructive);
  @override
  int get hashCode => primary.hashCode ^ destructive.hashCode;
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
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle));
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
