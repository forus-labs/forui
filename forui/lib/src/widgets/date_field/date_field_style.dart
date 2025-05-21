import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'date_field_style.style.dart';

/// A date field's style.
class FDateFieldStyle with Diagnosticable, _$FDateFieldStyleFunctions {
  /// The date field's textfield style.
  @override
  final FTextFieldStyle textFieldStyle;

  /// The date field calendar's popover style.
  @override
  final FPopoverStyle popoverStyle;

  /// The date field's calendar style.
  @override
  final FCalendarStyle calendarStyle;

  /// The date field icon's style.
  @override
  final IconThemeData iconStyle;

  /// Creates a [FDateFieldStyle].
  const FDateFieldStyle({
    required this.textFieldStyle,
    required this.popoverStyle,
    required this.calendarStyle,
    required this.iconStyle,
  });

  /// Creates a [FDateFieldStyle] that inherits its properties.
  FDateFieldStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        textFieldStyle: FTextFieldStyle.inherit(colors: colors, typography: typography, style: style),
        popoverStyle: FPopoverStyle.inherit(colors: colors, style: style),
        calendarStyle: FCalendarStyle.inherit(colors: colors, typography: typography, style: style),
        iconStyle: IconThemeData(color: colors.mutedForeground, size: 18),
      );
}
