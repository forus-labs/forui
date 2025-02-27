import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'time_field_style.style.dart';

/// A time field's style.
class FTimeFieldStyle with Diagnosticable, _$FTimeFieldStyleFunctions {
  /// The time field's textfield style.
  @override
  final FTextFieldStyle textFieldStyle;

  /// The time field picker's popover style.
  @override
  final FPopoverStyle popoverStyle;

  /// The time field's picker style.
  @override
  final FPickerStyle pickerStyle;

  /// The time field icon's style.
  @override
  final FIconStyle iconStyle;

  /// Creates a [FTimeFieldStyle].
  const FTimeFieldStyle({
    required this.textFieldStyle,
    required this.popoverStyle,
    required this.pickerStyle,
    required this.iconStyle,
  });

  /// Creates a [FTimeFieldStyle] that inherits the [colorScheme], [typography], and [style].
  FTimeFieldStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        textFieldStyle: FTextFieldStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
        popoverStyle: FPopoverStyle.inherit(colorScheme: colorScheme, style: style),
        pickerStyle: FPickerStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
        iconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
      );
}
