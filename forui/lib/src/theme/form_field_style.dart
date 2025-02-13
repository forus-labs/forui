import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'form_field_style.style.dart';

/// A form field state's style.
class FFormFieldStyle with Diagnosticable, _$FFormFieldStyleFunctions {
  /// The label's text style.
  @override
  final TextStyle labelTextStyle;

  /// The description's text style.
  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FFormFieldStyle].
  const FFormFieldStyle({required this.labelTextStyle, required this.descriptionTextStyle});

  /// Creates a [FFormFieldStyle] that inherits its properties from the given [FTypography].
  FFormFieldStyle.inherit({required Color labelColor, required Color descriptionColor, required FTypography typography})
    : labelTextStyle = typography.sm.copyWith(color: labelColor, fontWeight: FontWeight.w600),
      descriptionTextStyle = typography.sm.copyWith(color: descriptionColor);
}

/// A form field's error style.
class FFormFieldErrorStyle extends FFormFieldStyle with _$FFormFieldErrorStyleFunctions {
  /// The error's text style.
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FFormFieldErrorStyle].
  FFormFieldErrorStyle({
    required this.errorTextStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
  });

  /// Creates a [FFormFieldErrorStyle] that inherits its properties from the given arguments.
  FFormFieldErrorStyle.inherit({
    required Color errorColor,
    required super.labelColor,
    required super.descriptionColor,
    required super.typography,
  }) : errorTextStyle = typography.sm.copyWith(color: errorColor, fontWeight: FontWeight.w600),
       super.inherit();
}
