import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'text_field_state_style.style.dart';

/// A [FTextField] state's style.
// ignore: avoid_implementing_value_types
class FTextFieldStateStyle with Diagnosticable, _$FTextFieldStateStyleFunctions implements FFormFieldStyle {
  /// The label's [TextStyle].
  @override
  final TextStyle labelTextStyle;

  /// The help/error's [TextStyle].
  @override
  final TextStyle descriptionTextStyle;

  @override
  final TextStyle counterTextStyle;

  /// The content's [TextStyle].
  @override
  final TextStyle contentTextStyle;

  /// The hint's [TextStyle].
  @override
  final TextStyle hintTextStyle;

  /// The border's color when focused.
  @override
  final FTextFieldBorderStyle focusedStyle;

  /// The border's style when unfocused.
  @override
  final FTextFieldBorderStyle unfocusedStyle;

  /// Creates a [FTextFieldStateStyle].
  FTextFieldStateStyle({
    required this.labelTextStyle,
    required this.contentTextStyle,
    required this.hintTextStyle,
    required this.descriptionTextStyle,
    required this.counterTextStyle,
    required this.focusedStyle,
    required this.unfocusedStyle,
  });

  /// Creates a [FTextFieldStateStyle] that inherits its properties.
  FTextFieldStateStyle.inherit({
    required Color contentColor,
    required Color hintColor,
    required Color focusedBorderColor,
    required Color unfocusedBorderColor,
    required FFormFieldStyle formFieldStyle,
    required FTypography typography,
    required FStyle style,
  }) : this(
         labelTextStyle: formFieldStyle.labelTextStyle,
         contentTextStyle: typography.sm.copyWith(fontFamily: typography.defaultFontFamily, color: contentColor),
         hintTextStyle: typography.sm.copyWith(fontFamily: typography.defaultFontFamily, color: hintColor),
         counterTextStyle: typography.sm.copyWith(fontFamily: typography.defaultFontFamily, color: contentColor),
         descriptionTextStyle: formFieldStyle.descriptionTextStyle,
         focusedStyle: FTextFieldBorderStyle.inherit(color: focusedBorderColor, style: style),
         unfocusedStyle: FTextFieldBorderStyle.inherit(color: unfocusedBorderColor, style: style),
       );
}

/// A [FTextField] error state's style.
final class FTextFieldErrorStyle extends FTextFieldStateStyle
    with _$FTextFieldErrorStyleFunctions
        // ignore: avoid_implementing_value_types
        implements
        FFormFieldErrorStyle {
  /// The error's [TextStyle].
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FTextFieldErrorStyle].
  FTextFieldErrorStyle({
    required this.errorTextStyle,
    required super.labelTextStyle,
    required super.contentTextStyle,
    required super.hintTextStyle,
    required super.descriptionTextStyle,
    required super.counterTextStyle,
    required super.focusedStyle,
    required super.unfocusedStyle,
  });

  /// Creates a [FTextFieldErrorStyle] that inherits its properties.
  FTextFieldErrorStyle.inherit({
    required FFormFieldErrorStyle formFieldErrorStyle,
    required super.contentColor,
    required super.hintColor,
    required super.focusedBorderColor,
    required super.unfocusedBorderColor,
    required super.typography,
    required super.style,
  }) : errorTextStyle = formFieldErrorStyle.errorTextStyle,
       super.inherit(formFieldStyle: formFieldErrorStyle);
}

/// A [FTextField] border's style.
final class FTextFieldBorderStyle with Diagnosticable, _$FTextFieldBorderStyleFunctions {
  /// The border's color.
  @override
  final Color color;

  /// The border's width. Defaults to [FStyle.borderWidth].
  @override
  final double width;

  /// The border's width. Defaults to [FStyle.borderRadius].
  @override
  final BorderRadius radius;

  /// Creates a [FTextFieldBorderStyle].
  FTextFieldBorderStyle({required this.color, required this.width, required this.radius});

  /// Creates a [FTextFieldBorderStyle] that inherits its properties from [style].
  FTextFieldBorderStyle.inherit({required Color color, required FStyle style})
    : this(color: color, width: style.borderWidth, radius: style.borderRadius);
}
