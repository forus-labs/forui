part of 'text_field.dart';

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
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 15, vertical: 5)`.
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
    this.cursorColor = CupertinoColors.activeBlue,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    this.scrollPadding = const EdgeInsets.all(20),
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  FTextFieldStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }):
    keyboardAppearance = colorScheme.brightness,
    cursorColor = CupertinoColors.activeBlue,
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
      hintColor: colorScheme.border.withOpacity(0.7),
      footerColor: colorScheme.border.withOpacity(0.7),
      focusedBorderColor: colorScheme.border.withOpacity(0.7),
      unfocusedBorderColor: colorScheme.border.withOpacity(0.7),
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

  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FTextFieldStyle(
  ///   enabled: ...,
  ///   disabled: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   disabled: ...,
  /// );
  ///
  /// print(style.enabled == copy.enabled); // true
  /// print(style.disabled == copy.disabled); // false
  /// ```
  @useResult FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    EdgeInsets? contentPadding,
    EdgeInsets? scrollPadding,
    FTextFieldStateStyle? enabled,
    FTextFieldStateStyle? disabled,
    FTextFieldStateStyle? error,
  }) => FTextFieldStyle(
    keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
    cursorColor: cursorColor ?? this.cursorColor,
    contentPadding: contentPadding ?? this.contentPadding,
    scrollPadding: scrollPadding ?? this.scrollPadding,
    enabled: enabled ?? this.enabled,
    disabled: disabled ?? this.disabled,
    error: error ?? this.error,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance))
      ..add(ColorProperty('cursorColor', cursorColor, defaultValue: CupertinoColors.activeBlue))
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
          cursorColor == other.cursorColor &&
          contentPadding == other.contentPadding &&
          scrollPadding == other.scrollPadding &&
          enabled == other.enabled &&
          disabled == other.disabled &&
          error == other.error;

  @override
  int get hashCode =>
      keyboardAppearance.hashCode ^
      cursorColor.hashCode ^
      contentPadding.hashCode ^
      scrollPadding.hashCode ^
      enabled.hashCode ^
      disabled.hashCode ^
      error.hashCode;
}

/// A [FTextField] state's style.
final class FTextFieldStateStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle labelTextStyle;

  /// The content's [TextStyle].
  final TextStyle contentTextStyle;

  /// The hint's [TextStyle].
  final TextStyle hintTextStyle;

  /// The help/error's [TextStyle].
  final TextStyle footerTextStyle;

  /// The border's color when focused.
  final FTextFieldBorderStyle focused;

  /// The border's style when unfocused.
  final FTextFieldBorderStyle unfocused;

  /// Creates a [FTextFieldStateStyle].
  FTextFieldStateStyle({
    required this.labelTextStyle,
    required this.contentTextStyle,
    required this.hintTextStyle,
    required this.footerTextStyle,
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
    labelTextStyle = typography.sm.copyWith(
      color: labelColor,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle = typography.sm.copyWith(
      fontFamily: typography.defaultFontFamily,
      color: contentColor,
    ),
    hintTextStyle = typography.sm.copyWith(
      fontFamily: typography.defaultFontFamily,
      color: hintColor,
    ),
    footerTextStyle = typography.sm.copyWith(
      fontFamily: typography.defaultFontFamily,
      color: footerColor,
    ),
    focused = FTextFieldBorderStyle.inherit(color: focusedBorderColor, style: style),
    unfocused = FTextFieldBorderStyle.inherit(color: unfocusedBorderColor, style: style);

  /// Returns a copy of this [FTextFieldStateStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FTextFieldStateStyle(
  ///   labelTextStyle: ...,
  ///   contentTextStyle: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   contentTextStyle: ...,
  /// );
  ///
  /// print(style.labelTextStyle == copy.labelTextStyle); // true
  /// print(style.contentTextStyle == copy.contentTextStyle); // false
  /// ```
  @useResult FTextFieldStateStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? footerTextStyle,
    FTextFieldBorderStyle? focused,
    FTextFieldBorderStyle? unfocused,
  }) => FTextFieldStateStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    hintTextStyle: hintTextStyle ?? this.hintTextStyle,
    footerTextStyle: footerTextStyle ?? this.footerTextStyle,
    focused: focused ?? this.focused,
    unfocused: unfocused ?? this.unfocused,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle))
      ..add(DiagnosticsProperty('footerTextStyle', footerTextStyle))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(DiagnosticsProperty('unfocused', unfocused));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStateStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          focused == other.focused &&
          unfocused == other.unfocused;

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      focused.hashCode ^
      unfocused.hashCode;
}

/// A [FTextField] border's style.
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

  /// Creates a [FTextFieldBorderStyle] that inherits its properties from [style].
  FTextFieldBorderStyle.inherit({
    required this.color,
    required FStyle style,
  }):
    width = style.borderWidth,
    radius = style.borderRadius;

  /// Returns a copy of this border style but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FTextFieldBorderStyle(
  ///   color: Colors.black,
  ///   width: 1,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   width: 2,
  /// );
  ///
  /// print(copy.color); // black
  /// print(copy.width); // 2
  /// ```
  @useResult FTextFieldBorderStyle copyWith({
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
