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
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 15, vertical: 15)`.
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

  /// The style when this text field is enabled.
  final FTextFieldStateStyle enabledStyle;

  /// The style when this text field is enabled.
  final FTextFieldStateStyle disabledStyle;

  /// The style when this text field has an error.
  final FTextFieldErrorStyle errorStyle;

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.keyboardAppearance,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.cursorColor = CupertinoColors.activeBlue,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    this.scrollPadding = const EdgeInsets.all(20),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  })  : keyboardAppearance = colorScheme.brightness,
        cursorColor = CupertinoColors.activeBlue,
        contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        scrollPadding = const EdgeInsets.all(20.0),
        enabledStyle = FTextFieldStateStyle.inherit(
          contentColor: colorScheme.primary,
          hintColor: colorScheme.mutedForeground,
          focusedBorderColor: colorScheme.primary,
          unfocusedBorderColor: colorScheme.border,
          formFieldStyle: style.enabledFormFieldStyle,
          typography: typography,
          style: style,
        ),
        disabledStyle = FTextFieldStateStyle.inherit(
          contentColor: colorScheme.primary.withOpacity(0.7),
          hintColor: colorScheme.border.withOpacity(0.7),
          focusedBorderColor: colorScheme.border.withOpacity(0.7),
          unfocusedBorderColor: colorScheme.border.withOpacity(0.7),
          formFieldStyle: style.disabledFormFieldStyle,
          typography: typography,
          style: style,
        ),
        errorStyle = FTextFieldErrorStyle.inherit(
          contentColor: colorScheme.primary,
          hintColor: colorScheme.mutedForeground,
          focusedBorderColor: colorScheme.error,
          unfocusedBorderColor: colorScheme.error,
          formFieldErrorStyle: style.errorFormFieldStyle,
          typography: typography,
          style: style,
        );

  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  @useResult
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    EdgeInsets? contentPadding,
    EdgeInsets? scrollPadding,
    FTextFieldStateStyle? enabledStyle,
    FTextFieldStateStyle? disabledStyle,
    FTextFieldErrorStyle? errorStyle,
  }) =>
      FTextFieldStyle(
        keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
        cursorColor: cursorColor ?? this.cursorColor,
        contentPadding: contentPadding ?? this.contentPadding,
        scrollPadding: scrollPadding ?? this.scrollPadding,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance))
      ..add(ColorProperty('cursorColor', cursorColor, defaultValue: CupertinoColors.activeBlue))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding))
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
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode =>
      keyboardAppearance.hashCode ^
      cursorColor.hashCode ^
      contentPadding.hashCode ^
      scrollPadding.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode;
}
