part of 'text_field.dart';

/// A [FTextFieldStyle]'s style.
final class FTextFieldStyle with Diagnosticable {
  /// The appearance of the keyboard. Defaults to [FColorScheme.brightness].
  ///
  /// This setting is only honored on iOS devices.
  final Brightness keyboardAppearance;

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  final Color cursor;

  /// The padding surrounding this text field's content. Defaults to
  /// `const EdgeInsets.symmetric(horizontal: 15, vertical: 6)`.
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

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.keyboardAppearance,
    required this.enabled,
    required this.disabled,
    required this.error,
    this.cursor = CupertinoColors.activeBlue,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    this.scrollPadding = const EdgeInsets.all(20.0),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }):
    keyboardAppearance = colorScheme.brightness,
    cursor = CupertinoColors.activeBlue,
    contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    scrollPadding = const EdgeInsets.all(20.0),
    enabled = FTextFieldStateStyle.inherit(
      labelColor: colorScheme.primary,
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      footerColor: colorScheme.mutedForeground,
      focusedBorderColor: colorScheme.primary,
      unfocusedBorderColor: colorScheme.border,
      typography: typography,
      style: style,
    ),
    disabled = FTextFieldStateStyle.inherit(
      labelColor: colorScheme.primary,
      contentColor: colorScheme.primary,
      hintColor: colorScheme.border.withOpacity(0.5),
      footerColor: colorScheme.border.withOpacity(0.5),
      focusedBorderColor: colorScheme.border.withOpacity(0.5),
      unfocusedBorderColor: colorScheme.border.withOpacity(0.5),
      typography: typography,
      style: style,
    ),
    error = FTextFieldStateStyle.inherit(
      labelColor: colorScheme.primary,
      contentColor: colorScheme.primary,
      hintColor: colorScheme.mutedForeground,
      footerColor: colorScheme.error,
      focusedBorderColor: colorScheme.error,
      unfocusedBorderColor: colorScheme.error,
      typography: typography,
      style: style,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance))
      ..add(ColorProperty('cursor', cursor, defaultValue: CupertinoColors.activeBlue))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding))
      ..add(DiagnosticsProperty('enabledBorder', enabled))
      ..add(DiagnosticsProperty('disabledBorder', disabled))
      ..add(DiagnosticsProperty('errorBorder', error));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStyle &&
          runtimeType == other.runtimeType &&
          keyboardAppearance == other.keyboardAppearance &&
          cursor == other.cursor &&
          contentPadding == other.contentPadding &&
          scrollPadding == other.scrollPadding &&
          enabled == other.enabled &&
          disabled == other.disabled &&
          error == other.error;

  @override
  int get hashCode =>
      keyboardAppearance.hashCode ^
      cursor.hashCode ^
      contentPadding.hashCode ^
      scrollPadding.hashCode ^
      enabled.hashCode ^
      disabled.hashCode ^
      error.hashCode;
}

/// A [FTextFieldStateStyle]'s style.
final class FTextFieldStateStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle label;

  /// The content's [TextStyle].
  final TextStyle content;

  /// The hint's [TextStyle].
  final TextStyle hint;

  /// The help/error's [TextStyle].
  final TextStyle footer;

  /// The border's color when focused.
  final FTextFieldBorderStyle focused;

  /// The border's style when unfocused.
  final FTextFieldBorderStyle unfocused;

  /// Creates a [FTextFieldStateStyle].
  FTextFieldStateStyle({
    required this.label,
    required this.content,
    required this.hint,
    required this.footer,
    required this.focused,
    required this.unfocused,
  });

  /// Creates a [FTextFieldStateStyle] that inherits its properties.
  FTextFieldStateStyle.inherit({
    required Color labelColor,
    required Color contentColor,
    required Color hintColor,
    required Color footerColor,
    required Color focusedBorderColor,
    required Color unfocusedBorderColor,
    required FTypography typography,
    required FStyle style,
  }):
    label = TextStyle(
      color: labelColor,
      fontSize: typography.sm,
      fontWeight: FontWeight.w600,
    ),
    content = TextStyle(
      fontFamily: typography.defaultFontFamily,
      fontSize: typography.sm,
      color: contentColor,
    ),
    hint = TextStyle(
      fontFamily: typography.defaultFontFamily,
      fontSize: typography.sm,
      color: hintColor,
    ),
    footer = TextStyle(
      fontFamily: typography.defaultFontFamily,
      fontSize: typography.sm,
      color: footerColor,
    ),
    focused = FTextFieldBorderStyle.inherit(color: focusedBorderColor, style: style),
    unfocused = FTextFieldBorderStyle.inherit(color: unfocusedBorderColor, style: style);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('hint', hint))
      ..add(DiagnosticsProperty('footer', footer))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(DiagnosticsProperty('unfocused', unfocused));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStateStyle &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          content == other.content &&
          hint == other.hint &&
          focused == other.focused &&
          unfocused == other.unfocused;

  @override
  int get hashCode =>
      label.hashCode ^
      content.hashCode ^
      hint.hashCode ^
      focused.hashCode ^
      unfocused.hashCode;
}

/// A [FTextFieldBorderStyle]'s style.
final class FTextFieldBorderStyle with Diagnosticable {
  /// The border's color.
  final Color color;

  /// The border's width. Defaults to [FStyle.borderWidth].
  final double width;

  /// The border's width. Defaults to [FStyle.borderRadius].
  final BorderRadius radius;

  /// Creates a [FTextFieldBorderStyle].
  FTextFieldBorderStyle({
    required this.color,
    required this.width,
    required this.radius,
  });

  /// Creates a [FTextFieldBorderStyle] that inherits its properties.
  FTextFieldBorderStyle.inherit({
    required this.color,
    required FStyle style,
  }):
    width = style.borderWidth,
    radius = style.borderRadius;

  /// Creates a copy of this border style but with the given fields replaced with the new values.
  FTextFieldBorderStyle copyWith({
    Color? color,
    double? width,
    BorderRadius? radius,
  }) => FTextFieldBorderStyle(
    color: color ?? this.color,
    width: width ?? this.width,
    radius: radius ?? this.radius,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('radius', radius));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldBorderStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          width == other.width &&
          radius == other.radius;

  @override
  int get hashCode => color.hashCode ^ width.hashCode ^ radius.hashCode;
}
