// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'avatar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAvatarStyleTransformations on FAvatarStyle {
  /// Returns a copy of this [FAvatarStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAvatarStyle.backgroundColor] - The fallback's background color.
  /// * [FAvatarStyle.foregroundColor] - The fallback's color.
  /// * [FAvatarStyle.textStyle] - The text style for the fallback text.
  /// * [FAvatarStyle.fadeInDuration] - Duration for the transition animation.
  @useResult
  FAvatarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    Duration? fadeInDuration,
  }) => FAvatarStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    textStyle: textStyle ?? this.textStyle,
    fadeInDuration: fadeInDuration ?? this.fadeInDuration,
  );

  /// Linearly interpolate between this and another [FAvatarStyle] using the given factor [t].
  @useResult
  FAvatarStyle lerp(FAvatarStyle other, double t) => FAvatarStyle(
    backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
    foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t) ?? foregroundColor,
    textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
    fadeInDuration: t < 0.5 ? fadeInDuration : other.fadeInDuration,
  );
}

mixin _$FAvatarStyleFunctions on Diagnosticable {
  Color get backgroundColor;
  Color get foregroundColor;
  TextStyle get textStyle;
  Duration get fadeInDuration;

  /// Returns itself.
  ///
  /// Allows [FAvatarStyle] to replace functions that accept and return a [FAvatarStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAvatarStyle Function(FAvatarStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAvatarStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAvatarStyle(...));
  /// ```
  @useResult
  FAvatarStyle call(Object? _) => this as FAvatarStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(ColorProperty('foregroundColor', foregroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAvatarStyle &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          textStyle == other.textStyle &&
          fadeInDuration == other.fadeInDuration);

  @override
  int get hashCode =>
      backgroundColor.hashCode ^ foregroundColor.hashCode ^ textStyle.hashCode ^ fadeInDuration.hashCode;
}
