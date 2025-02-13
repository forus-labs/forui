import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'date_picker_style.style.dart';

/// A date picker's style.
class FDatePickerStyle with Diagnosticable, _$FDatePickerStyleFunctions {
  /// The date picker's textfield style.
  @override
  final FTextFieldStyle textFieldStyle;

  /// The date picker calendar's popover style.
  @override
  final FPopoverStyle popoverStyle;

  /// The date picker's calendar style.
  @override
  final FCalendarStyle calendarStyle;

  /// The date picker icon's style.
  @override
  final FIconStyle iconStyle;

  /// Creates a [FDatePickerStyle].
  const FDatePickerStyle({
    required this.textFieldStyle,
    required this.popoverStyle,
    required this.calendarStyle,
    required this.iconStyle,
  });

  /// Creates a [FDatePickerStyle] that inherits the [colorScheme], [typography], and [style].
  FDatePickerStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        textFieldStyle: FTextFieldStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
        popoverStyle: FPopoverStyle.inherit(colorScheme: colorScheme, style: style),
        calendarStyle: FCalendarStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
        iconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
      );
}
