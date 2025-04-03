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

  /// Creates a [FDateFieldStyle] that inherits the [color], [text], and [style].
  FDateFieldStyle.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        textFieldStyle: FTextFieldStyle.inherit(color: color, text: text, style: style),
        popoverStyle: FPopoverStyle.inherit(color: color, style: style),
        calendarStyle: FCalendarStyle.inherit(color: color, text: text, style: style),
        iconStyle: IconThemeData(color: color.mutedForeground, size: 18),
      );
}
