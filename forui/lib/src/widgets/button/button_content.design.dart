// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FButtonContentStyleTransformations on FButtonContentStyle {
  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonContentStyle.textStyle] - The [TextStyle].
  /// * [FButtonContentStyle.iconStyle] - The icon's style.
  /// * [FButtonContentStyle.circularProgressStyle] - The circular progress's style.
  /// * [FButtonContentStyle.padding] - The padding.
  /// * [FButtonContentStyle.spacing] - The spacing between prefix, child, and suffix.
  @useResult
  FButtonContentStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<FCircularProgressStyle>? circularProgressStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
  }) => FButtonContentStyle(
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    circularProgressStyle: circularProgressStyle ?? this.circularProgressStyle,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
  );

  /// Linearly interpolate between this and another [FButtonContentStyle] using the given factor [t].
  @useResult
  FButtonContentStyle lerp(FButtonContentStyle other, double t) => FButtonContentStyle(
    textStyle: FWidgetStateMap.lerpTextStyle(textStyle, other.textStyle, t),
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    circularProgressStyle: t < 0.5 ? circularProgressStyle : other.circularProgressStyle,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
  );
}

mixin _$FButtonContentStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FWidgetStateMap<FCircularProgressStyle> get circularProgressStyle;
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
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('circularProgressStyle', circularProgressStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('spacing', spacing, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonContentStyle &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          circularProgressStyle == other.circularProgressStyle &&
          padding == other.padding &&
          spacing == other.spacing);

  @override
  int get hashCode =>
      textStyle.hashCode ^ iconStyle.hashCode ^ circularProgressStyle.hashCode ^ padding.hashCode ^ spacing.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FButtonIconContentStyleTransformations on FButtonIconContentStyle {
  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonIconContentStyle.iconStyle] - The icon's style.
  /// * [FButtonIconContentStyle.padding] - The padding.
  @useResult
  FButtonIconContentStyle copyWith({FWidgetStateMap<IconThemeData>? iconStyle, EdgeInsetsGeometry? padding}) =>
      FButtonIconContentStyle(iconStyle: iconStyle ?? this.iconStyle, padding: padding ?? this.padding);

  /// Linearly interpolate between this and another [FButtonIconContentStyle] using the given factor [t].
  @useResult
  FButtonIconContentStyle lerp(FButtonIconContentStyle other, double t) => FButtonIconContentStyle(
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
  );
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
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonIconContentStyle && iconStyle == other.iconStyle && padding == other.padding);

  @override
  int get hashCode => iconStyle.hashCode ^ padding.hashCode;
}
