import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A date picker's style.
class FDatePickerStyle with Diagnosticable {
  /// The date picker's textfield style.
  final FTextFieldStyle textFieldStyle;

  /// The date picker calendar's popover style.
  final FPopoverStyle popoverStyle;

  /// The date picker's calendar style.
  final FCalendarStyle calendarStyle;

  /// The date picker icon's style.
  final FIconStyle iconStyle;

  /// The date picker's focused outline style.
  final FFocusedOutlineStyle iconFocusedOutlineStyle;

  /// Creates a [FDatePickerStyle].
  const FDatePickerStyle({
    required this.textFieldStyle,
    required this.popoverStyle,
    required this.calendarStyle,
    required this.iconStyle,
    required this.iconFocusedOutlineStyle,
  });

  /// Creates a [FDatePickerStyle] that inherits the [colorScheme], [typography], and [style].
  FDatePickerStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          textFieldStyle: FTextFieldStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
          popoverStyle: FPopoverStyle.inherit(colorScheme: colorScheme, style: style),
          calendarStyle: FCalendarStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
          iconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
          iconFocusedOutlineStyle: style.focusedOutlineStyle,
        );

  /// Returns a copy of this [FDatePickerStyle] with the given fields replaced with the new values.
  @useResult
  FDatePickerStyle copyWith({
    FTextFieldStyle? textFieldStyle,
    FPopoverStyle? popoverStyle,
    FCalendarStyle? calendarStyle,
    FIconStyle? iconStyle,
    FFocusedOutlineStyle? iconFocusedOutlineStyle,
  }) =>
      FDatePickerStyle(
        textFieldStyle: textFieldStyle ?? this.textFieldStyle,
        popoverStyle: popoverStyle ?? this.popoverStyle,
        calendarStyle: calendarStyle ?? this.calendarStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        iconFocusedOutlineStyle: iconFocusedOutlineStyle ?? this.iconFocusedOutlineStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textfieldStyle', textFieldStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('iconFocusedOutlineStyle', iconFocusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDatePickerStyle &&
          runtimeType == other.runtimeType &&
          textFieldStyle == other.textFieldStyle &&
          popoverStyle == other.popoverStyle &&
          calendarStyle == other.calendarStyle &&
          iconStyle == other.iconStyle &&
          iconFocusedOutlineStyle == other.iconFocusedOutlineStyle;

  @override
  int get hashCode =>
      textFieldStyle.hashCode ^
      popoverStyle.hashCode ^
      calendarStyle.hashCode ^
      iconStyle.hashCode ^
      iconFocusedOutlineStyle.hashCode;
}
