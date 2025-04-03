import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'time_field_style.style.dart';

/// A time field's style.
class FTimeFieldStyle with Diagnosticable, _$FTimeFieldStyleFunctions {
  /// The time field's text field style.
  @override
  final FTextFieldStyle textFieldStyle;

  /// The time field picker's popover style.
  @override
  final FPopoverStyle popoverStyle;

  /// The time field picker's popover constraints.
  @override
  final BoxConstraints popoverConstraints;

  /// The time field's picker style.
  @override
  final FTimePickerStyle pickerStyle;

  /// The time field icon's style.
  @override
  final IconThemeData iconStyle;

  /// Creates a [FTimeFieldStyle].
  const FTimeFieldStyle({
    required this.textFieldStyle,
    required this.popoverStyle,
    required this.pickerStyle,
    required this.iconStyle,
    this.popoverConstraints = const BoxConstraints(maxWidth: 200, maxHeight: 200),
  });

  /// Creates a [FTimeFieldStyle] that inherits the [color], [text], and [style].
  FTimeFieldStyle.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        textFieldStyle: FTextFieldStyle.inherit(color: color, text: text, style: style),
        popoverStyle: FPopoverStyle.inherit(color: color, style: style),
        pickerStyle: FTimePickerStyle.inherit(color: color, text: text, style: style),
        iconStyle: IconThemeData(color: color.mutedForeground, size: 18),
      );
}
