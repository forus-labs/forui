import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'text_field_style.style.dart';

/// [FTextFieldStyle]'s style.
final class FTextFieldStyle with Diagnosticable, _$FTextFieldStyleFunctions {
  /// The appearance of the keyboard. Defaults to [FColorScheme.brightness].
  ///
  /// This setting is only honored on iOS devices.
  @override
  final Brightness keyboardAppearance;

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  @override
  final Color cursorColor;

  /// The padding surrounding this text field's content.
  ///
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 14, vertical: 14)`.
  @override
  final EdgeInsetsGeometry contentPadding;

  /// The padding surrounding the clear button. Defaults to `EdgeInsetsDirectional.only(end: 2)`.
  @override
  final EdgeInsetsGeometry clearButtonPadding;

  /// Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  ///
  /// Defaults to `EdgeInsets.all(20)`.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially off the screen or
  /// overlapped by the keyboard) then it will attempt to make itself visible by scrolling a surrounding [Scrollable],
  /// if one is present. This value controls how far from the edges of a [Scrollable] the TextField will be positioned
  /// after the scroll.
  @override
  final EdgeInsets scrollPadding;

  /// The label's layout style.
  @override
  final FLabelLayoutStyle labelLayoutStyle;

  /// The clear button's style when [FTextField.clearable] is true.
  @override
  final FButtonCustomStyle clearButtonStyle;

  /// The style when this text field is enabled.
  @override
  final FTextFieldStateStyle enabledStyle;

  /// The style when this text field is enabled.
  @override
  final FTextFieldStateStyle disabledStyle;

  /// The style when this text field has an error.
  @override
  final FTextFieldErrorStyle errorStyle;

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.keyboardAppearance,
    required this.labelLayoutStyle,
    required this.clearButtonStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.cursorColor = CupertinoColors.activeBlue,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    this.clearButtonPadding = const EdgeInsetsDirectional.only(end: 4),
    this.scrollPadding = const EdgeInsets.all(20),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        keyboardAppearance: colorScheme.brightness,
        labelLayoutStyle: FLabelStyles.inherit(style: style).verticalStyle.layout,
        clearButtonStyle: FButtonStyles.inherit(
          colorScheme: colorScheme,
          typography: typography,
          style: style,
        ).ghost.transform(
          (ghost) => ghost.copyWith(
            iconContentStyle: ghost.iconContentStyle.copyWith(enabledColor: colorScheme.mutedForeground, size: 17),
          ),
        ),
        enabledStyle: FTextFieldStateStyle.inherit(
          contentColor: colorScheme.primary,
          hintColor: colorScheme.mutedForeground,
          focusedBorderColor: colorScheme.primary,
          unfocusedBorderColor: colorScheme.border,
          formFieldStyle: style.enabledFormFieldStyle,
          typography: typography,
          style: style,
        ),
        disabledStyle: FTextFieldStateStyle.inherit(
          contentColor: colorScheme.disable(colorScheme.primary),
          hintColor: colorScheme.disable(colorScheme.border),
          focusedBorderColor: colorScheme.disable(colorScheme.border),
          unfocusedBorderColor: colorScheme.disable(colorScheme.border),
          formFieldStyle: style.disabledFormFieldStyle,
          typography: typography,
          style: style,
        ),
        errorStyle: FTextFieldErrorStyle.inherit(
          contentColor: colorScheme.primary,
          hintColor: colorScheme.mutedForeground,
          focusedBorderColor: colorScheme.error,
          unfocusedBorderColor: colorScheme.error,
          formFieldErrorStyle: style.errorFormFieldStyle,
          typography: typography,
          style: style,
        ),
      );

  /// The label style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
    layout: labelLayoutStyle,
    state: FLabelStateStyles(enabledStyle: enabledStyle, disabledStyle: disabledStyle, errorStyle: errorStyle),
  );
}
