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

  /// The base fill color of the decoration's container color.
  @override
  final Color? fillColor;

  /// If true the decoration's container is filled with [fillColor]. Defaults to false.
  @override
  final bool filled;

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
  final FButtonStyle clearButtonStyle;

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
    this.fillColor,
    this.filled = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    this.clearButtonPadding = const EdgeInsetsDirectional.only(end: 4),
    this.scrollPadding = const EdgeInsets.all(20),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        keyboardAppearance: color.brightness,
        labelLayoutStyle: FLabelStyles.inherit(style: style).verticalStyle.layout,
        clearButtonStyle: FButtonStyles.inherit(color: color, text: text, style: style).ghost.transform(
          (ghost) => ghost.copyWith(
            iconContentStyle: ghost.iconContentStyle.copyWith(
              enabledStyle: IconThemeData(color: color.mutedForeground, size: 17),
            ),
          ),
        ),
        enabledStyle: FTextFieldStateStyle.inherit(
          contentColor: color.primary,
          hintColor: color.mutedForeground,
          focusedBorderColor: color.primary,
          unfocusedBorderColor: color.border,
          formFieldStyle: style.enabledFormFieldStyle,
          text: text,
          style: style,
        ),
        disabledStyle: FTextFieldStateStyle.inherit(
          contentColor: color.disable(color.primary),
          hintColor: color.disable(color.border),
          focusedBorderColor: color.disable(color.border),
          unfocusedBorderColor: color.disable(color.border),
          formFieldStyle: style.disabledFormFieldStyle,
          text: text,
          style: style,
        ),
        errorStyle: FTextFieldErrorStyle.inherit(
          contentColor: color.primary,
          hintColor: color.mutedForeground,
          focusedBorderColor: color.error,
          unfocusedBorderColor: color.error,
          formFieldErrorStyle: style.errorFormFieldStyle,
          text: text,
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
