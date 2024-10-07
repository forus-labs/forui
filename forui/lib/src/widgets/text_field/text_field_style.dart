import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// [FTextFieldStyle]'s style.
final class FTextFieldStyle with Diagnosticable {
  /// The appearance of the keyboard. Defaults to [FColorScheme.brightness].
  ///
  /// This setting is only honored on iOS devices.
  final Brightness keyboardAppearance;

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  final Color cursorColor;

  /// The padding surrounding this text field's content.
  ///
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 14, vertical: 14)`.
  final EdgeInsets contentPadding;

  /// Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  ///
  /// Defaults to `EdgeInsets.all(20)`.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially off the screen or
  /// overlapped by the keyboard) then it will attempt to make itself visible by scrolling a surrounding [Scrollable],
  /// if one is present. This value controls how far from the edges of a [Scrollable] the TextField will be positioned
  /// after the scroll.
  final EdgeInsets scrollPadding;

  /// The label's layout style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The style when this text field is enabled.
  final FTextFieldStateStyle enabledStyle;

  /// The style when this text field is enabled.
  final FTextFieldStateStyle disabledStyle;

  /// The style when this text field has an error.
  final FTextFieldErrorStyle errorStyle;

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.keyboardAppearance,
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.cursorColor = CupertinoColors.activeBlue,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    this.scrollPadding = const EdgeInsets.all(20),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          keyboardAppearance: colorScheme.brightness,
          labelLayoutStyle: FLabelStyles.inherit(style: style).verticalStyle.layout,
          enabledStyle: FTextFieldStateStyle.inherit(
            contentColor: colorScheme.enabled.primary,
            hintColor: colorScheme.enabled.mutedForeground,
            focusedBorderColor: colorScheme.enabled.primary,
            unfocusedBorderColor: colorScheme.enabled.border,
            formFieldStyle: style.enabledFormFieldStyle,
            typography: typography,
            style: style,
          ),
          disabledStyle: FTextFieldStateStyle.inherit(
            contentColor: colorScheme.disabled.primary,
            hintColor: colorScheme.disabled.border,
            focusedBorderColor: colorScheme.disabled.border,
            unfocusedBorderColor: colorScheme.disabled.border,
            formFieldStyle: style.disabledFormFieldStyle,
            typography: typography,
            style: style,
          ),
          errorStyle: FTextFieldErrorStyle.inherit(
            contentColor: colorScheme.enabled.primary,
            hintColor: colorScheme.enabled.mutedForeground,
            focusedBorderColor: colorScheme.enabled.error,
            unfocusedBorderColor: colorScheme.enabled.error,
            formFieldErrorStyle: style.errorFormFieldStyle,
            typography: typography,
            style: style,
          ),
        );

  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  @useResult
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    EdgeInsets? contentPadding,
    EdgeInsets? scrollPadding,
    FLabelLayoutStyle? labelLayoutStyle,
    FTextFieldStateStyle? enabledStyle,
    FTextFieldStateStyle? disabledStyle,
    FTextFieldErrorStyle? errorStyle,
  }) =>
      FTextFieldStyle(
        keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
        cursorColor: cursorColor ?? this.cursorColor,
        contentPadding: contentPadding ?? this.contentPadding,
        scrollPadding: scrollPadding ?? this.scrollPadding,
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  /// The label style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
        layout: labelLayoutStyle,
        state: FLabelStateStyles(
          enabledStyle: enabledStyle,
          disabledStyle: disabledStyle,
          errorStyle: errorStyle,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance))
      ..add(ColorProperty('cursorColor', cursorColor, defaultValue: CupertinoColors.activeBlue))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding))
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStyle &&
          runtimeType == other.runtimeType &&
          keyboardAppearance == other.keyboardAppearance &&
          cursorColor == other.cursorColor &&
          contentPadding == other.contentPadding &&
          scrollPadding == other.scrollPadding &&
          labelLayoutStyle == other.labelLayoutStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode =>
      keyboardAppearance.hashCode ^
      cursorColor.hashCode ^
      contentPadding.hashCode ^
      scrollPadding.hashCode ^
      labelLayoutStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode;
}
