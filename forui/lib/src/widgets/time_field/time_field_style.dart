import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'time_field_style.design.dart';

/// A time field's style.
class FTimeFieldStyle with Diagnosticable, _$FTimeFieldStyleFunctions {
  /// The time field's text field style.
  @override
  final FTextFieldStyle fieldStyle;

  /// The time field picker's popover style.
  @override
  final FPopoverStyle popoverStyle;

  /// The time field's picker style.
  @override
  final FTimePickerStyle pickerStyle;

  /// Creates a [FTimeFieldStyle].
  const FTimeFieldStyle({required this.fieldStyle, required this.popoverStyle, required this.pickerStyle});

  /// Creates a [FTimeFieldStyle] that inherits its properties.
  FTimeFieldStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        fieldStyle: .inherit(colors: colors, typography: typography, style: style),
        popoverStyle: .inherit(colors: colors, style: style),
        pickerStyle: .inherit(colors: colors, typography: typography, style: style),
      );
}
