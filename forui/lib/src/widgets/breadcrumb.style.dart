// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'breadcrumb.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FBreadcrumbStyleCopyWith on FBreadcrumbStyle {
  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [textStyle]
  /// The text style.
  ///
  /// # [iconStyle]
  /// The divider icon style.
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  ///
  /// # [tappableStyle]
  /// The tappable's style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  @useResult
  FBreadcrumbStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    IconThemeData? iconStyle,
    EdgeInsetsGeometry? padding,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
  }) => FBreadcrumbStyle(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    padding: padding ?? this.padding,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
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
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
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
