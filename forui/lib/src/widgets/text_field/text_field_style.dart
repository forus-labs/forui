part of 'text_field.dart';

/// A [FTextFieldStyle]'s style.
final class FTextFieldStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle label;

  /// The appearance of the keyboard. Defaults to [FColorScheme.brightness].
  ///
  /// This setting is only honored on iOS devices.
  final Brightness keyboardAppearance;

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  final Color cursor;

  /// The padding surrounding this text field's content. Defaults to
  /// `const EdgeInsets.symmetric(horizontal: 16, vertical: 7)`.
  final EdgeInsets contentPadding;

  /// Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  ///
  /// Defaults to `EdgeInsets.all(20.0)`.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially off the screen or
  /// overlapped by the keyboard) then it will attempt to make itself visible by scrolling a surrounding [Scrollable],
  /// if one is present. This value controls how far from the edges of a [Scrollable] the TextField will be positioned
  /// after the scroll.
  final EdgeInsets scrollPadding;

  /// The style when this text field is enabled.
  final FTextFieldStateStyle enabled;

  /// The style when this text field is enabled.
  final FTextFieldStateStyle disabled;

  /// The style when this text field has an error.
  final FTextFieldStateStyle error;

  /// The style when this text field is focused.
  final FTextFieldStateStyle focused;

  /// The style when this text field is focused and has an error.
  final FTextFieldStateStyle focusedError;

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.label,
    required this.keyboardAppearance,
    required this.enabled,
    required this.disabled,
    required this.error,
    required this.focused,
    required this.focusedError,
    this.cursor = CupertinoColors.activeBlue,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
    this.scrollPadding = const EdgeInsets.all(20.0),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({
    required FColorScheme colorScheme,
    required FFont font,
    required FStyle style,
  }):
    label = TextStyle(
      color: colorScheme.primary,
      fontSize: font.sm,
      fontWeight: FontWeight.w600,
    ),
    keyboardAppearance = colorScheme.brightness,
    cursor = CupertinoColors.activeBlue,
    contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
    scrollPadding = const EdgeInsets.all(20.0),
    enabled = FTextFieldStateStyle.inherit(
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      borderColor: colorScheme.border,
      font: font,
      style: style,
    ),
    disabled = FTextFieldStateStyle.inherit(
      contentColor: colorScheme.primary,
      hintColor: colorScheme.border.withOpacity(0.5),
      borderColor: colorScheme.border.withOpacity(0.5),
      font: font,
      style: style,
    ),
    error = FTextFieldStateStyle.inherit( // TODO: add error colors
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      borderColor: colorScheme.border,
      font: font,
      style: style,
    ),
    focused = FTextFieldStateStyle.inherit(
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      borderColor: colorScheme.primary,
      font: font,
      style: style,
    ),
    focusedError = FTextFieldStateStyle.inherit( // TODO: add error colors
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      borderColor: colorScheme.primary,
      font: font,
      style: style,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('label', label))
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance))
      ..add(ColorProperty('cursor', cursor, defaultValue: CupertinoColors.activeBlue))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding))
      ..add(DiagnosticsProperty('enabledBorder', enabled))
      ..add(DiagnosticsProperty('disabledBorder', disabled))
      ..add(DiagnosticsProperty('errorBorder', error))
      ..add(DiagnosticsProperty('focusedBorder', focused))
      ..add(DiagnosticsProperty('focusedErrorBorder', focusedError));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStyle &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          keyboardAppearance == other.keyboardAppearance &&
          cursor == other.cursor &&
          contentPadding == other.contentPadding &&
          scrollPadding == other.scrollPadding &&
          enabled == other.enabled &&
          disabled == other.disabled &&
          error == other.error &&
          focused == other.focused &&
          focusedError == other.focusedError;

  @override
  int get hashCode =>
      label.hashCode ^
      keyboardAppearance.hashCode ^
      cursor.hashCode ^
      contentPadding.hashCode ^
      scrollPadding.hashCode ^
      enabled.hashCode ^
      disabled.hashCode ^
      error.hashCode ^
      focused.hashCode ^
      focusedError.hashCode;
}

/// A [FTextFieldStateStyle]'s style.
final class FTextFieldStateStyle with Diagnosticable {
  /// The content's [TextStyle].
  final TextStyle content;

  /// The hint's [TextStyle].
  final TextStyle hint;

  /// The border's color.
  final Color borderColor;

  /// The border's width. Defaults to [FStyle.borderWidth].
  final double borderWidth;

  /// The border's width. Defaults to [FStyle.borderRadius].
  final BorderRadius borderRadius;

  /// Creates a [FTextFieldStateStyle].
  FTextFieldStateStyle({
    required this.content,
    required this.hint,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
  });

  /// Creates a [FTextFieldStateStyle] that inherits its properties.
  FTextFieldStateStyle.inherit({
    required Color contentColor,
    required Color hintColor,
    required this.borderColor,
    required FFont font,
    required FStyle style,
  }):
    content = TextStyle(
      fontFamily: font.family,
      fontSize: font.sm,
      color: contentColor,
    ),
    hint = TextStyle(
      fontFamily: font.family,
      fontSize: font.sm,
      color: hintColor,
    ),
    borderWidth = style.borderWidth,
    borderRadius = style.borderRadius;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('hint', hint))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty('borderRadius', borderRadius));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStateStyle &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          hint == other.hint &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          borderRadius == other.borderRadius;

  @override
  int get hashCode =>
      content.hashCode ^
      hint.hashCode ^
      borderColor.hashCode ^
      borderWidth.hashCode ^
      borderRadius.hashCode;
}
