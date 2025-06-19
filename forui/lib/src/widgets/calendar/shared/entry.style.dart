// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'entry.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FCalendarEntryStyleCopyWith on FCalendarEntryStyle {
  /// Returns a copy of this [FCalendarEntryStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [backgroundColor]
  /// The day's background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [borderColor]
  /// The border.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [textStyle]
  /// The day's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [radius]
  /// The entry border's radius. Defaults to `Radius.circular(4)`.
  ///
  @useResult
  FCalendarEntryStyle copyWith({
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color?>? borderColor,
    FWidgetStateMap<TextStyle>? textStyle,
    Radius? radius,
  }) => FCalendarEntryStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    borderColor: borderColor ?? this.borderColor,
    textStyle: textStyle ?? this.textStyle,
    radius: radius ?? this.radius,
  );
}

mixin _$FCalendarEntryStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color?> get borderColor;
  FWidgetStateMap<TextStyle> get textStyle;
  Radius get radius;

  /// Returns itself.
  ///
  /// Allows [FCalendarEntryStyle] to replace functions that accept and return a [FCalendarEntryStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarEntryStyle Function(FCalendarEntryStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarEntryStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarEntryStyle(...));
  /// ```
  @useResult
  FCalendarEntryStyle call(Object? _) => this as FCalendarEntryStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('borderColor', borderColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('radius', radius));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarEntryStyle &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          textStyle == other.textStyle &&
          radius == other.radius);
  @override
  int get hashCode => backgroundColor.hashCode ^ borderColor.hashCode ^ textStyle.hashCode ^ radius.hashCode;
}
