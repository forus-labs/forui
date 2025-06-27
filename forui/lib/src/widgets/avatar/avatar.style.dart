// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'avatar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FAvatarStyleCopyWith on FAvatarStyle {
  /// Returns a copy of this [FAvatarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [backgroundColor]
  /// The fallback's background color.
  ///
  /// # [foregroundColor]
  /// The fallback's color.
  ///
  /// # [textStyle]
  /// The text style for the fallback text.
  ///
  /// # [fadeInDuration]
  /// Duration for the transition animation. Defaults to 500ms.
  ///
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
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration));
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
