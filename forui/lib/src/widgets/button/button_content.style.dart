// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FButtonContentStyleCopyWith on FButtonContentStyle {
  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [textStyle]
  /// The [TextStyle].
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 12.5)`.
  ///
  /// # [spacing]
  /// The spacing between prefix, child, and suffix. Defaults to 10.
  ///
  @useResult
  FButtonContentStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
  }) => FButtonContentStyle(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
  );
}

/// Provides a `copyWith` method.
extension $FButtonIconContentStyleCopyWith on FButtonIconContentStyle {
  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.all(7.5)`.
  ///
  @useResult
  FButtonIconContentStyle copyWith({FWidgetStateMap<IconThemeData>? iconStyle, EdgeInsetsGeometry? padding}) =>
      FButtonIconContentStyle(iconStyle: iconStyle ?? this.iconStyle, padding: padding ?? this.padding);
}

mixin _$FButtonContentStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;

  /// Returns itself.
  ///
  /// Allows [FButtonContentStyle] to replace functions that accept and return a [FButtonContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonContentStyle Function(FButtonContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonContentStyle(...));
  /// ```
  @useResult
  FButtonContentStyle call(Object? _) => this as FButtonContentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('spacing', spacing));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonContentStyle &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding &&
          spacing == other.spacing);
  @override
  int get hashCode => textStyle.hashCode ^ iconStyle.hashCode ^ padding.hashCode ^ spacing.hashCode;
}
mixin _$FButtonIconContentStyleFunctions on Diagnosticable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  EdgeInsetsGeometry get padding;

  /// Returns itself.
  ///
  /// Allows [FButtonIconContentStyle] to replace functions that accept and return a [FButtonIconContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonIconContentStyle Function(FButtonIconContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonIconContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonIconContentStyle(...));
  /// ```
  @useResult
  FButtonIconContentStyle call(Object? _) => this as FButtonIconContentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonIconContentStyle && iconStyle == other.iconStyle && padding == other.padding);
  @override
  int get hashCode => iconStyle.hashCode ^ padding.hashCode;
}
