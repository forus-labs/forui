// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FCalendarHeaderStyleCopyWith on FCalendarHeaderStyle {
  /// Returns a copy of this [FCalendarHeaderStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  /// # [buttonStyle]
  /// The button style.
  ///
  /// # [headerTextStyle]
  /// The header's text style.
  ///
  /// # [animationDuration]
  /// The arrow turn animation's duration. Defaults to 200ms.
  ///
  @useResult
  FCalendarHeaderStyle copyWith({
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
    FButtonStyle Function(FButtonStyle)? buttonStyle,
    TextStyle? headerTextStyle,
    Duration? animationDuration,
  }) => FCalendarHeaderStyle(
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    buttonStyle: buttonStyle != null ? buttonStyle(this.buttonStyle) : this.buttonStyle,
    headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    animationDuration: animationDuration ?? this.animationDuration,
  );
}

mixin _$FCalendarHeaderStyleFunctions on Diagnosticable {
  FFocusedOutlineStyle get focusedOutlineStyle;
  FButtonStyle get buttonStyle;
  TextStyle get headerTextStyle;
  Duration get animationDuration;

  /// Returns itself.
  ///
  /// Allows [FCalendarHeaderStyle] to replace functions that accept and return a [FCalendarHeaderStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarHeaderStyle Function(FCalendarHeaderStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarHeaderStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarHeaderStyle(...));
  /// ```
  @useResult
  FCalendarHeaderStyle call(Object? _) => this as FCalendarHeaderStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('buttonStyle', buttonStyle))
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(DiagnosticsProperty('animationDuration', animationDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarHeaderStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          buttonStyle == other.buttonStyle &&
          headerTextStyle == other.headerTextStyle &&
          animationDuration == other.animationDuration);
  @override
  int get hashCode =>
      focusedOutlineStyle.hashCode ^ buttonStyle.hashCode ^ headerTextStyle.hashCode ^ animationDuration.hashCode;
}
