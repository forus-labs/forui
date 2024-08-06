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
  final FTextFieldStateStyle errorStyle;

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
          formFieldStateStyle: style.formFieldStyle.enabledStyle,
          typography: typography,
          style: style,
        ),
        disabledStyle = FTextFieldStateStyle.inherit(
          contentColor: colorScheme.primary.withOpacity(0.7),
          hintColor: colorScheme.border.withOpacity(0.7),
          focusedBorderColor: colorScheme.border.withOpacity(0.7),
          unfocusedBorderColor: colorScheme.border.withOpacity(0.7),
          formFieldStateStyle: style.formFieldStyle.disabledStyle,
          typography: typography,
          style: style,
        ),
        errorStyle = FTextFieldStateStyle.inherit(
          contentColor: colorScheme.primary,
          hintColor: colorScheme.mutedForeground,
          focusedBorderColor: colorScheme.error,
          unfocusedBorderColor: colorScheme.error,
          formFieldStateStyle: style.formFieldStyle.errorStyle,
          typography: typography,
          style: style,
        );

  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FTextFieldStyle(
  ///   enabledStyle: ...,
  ///   disabledStyle: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   disabledStyle: ...,
  /// );
  ///
  /// print(style.enabledStyle == copy.enabledStyle); // true
  /// print(style.disabledStyle == copy.disabledStyle); // false
  /// ```
  @useResult
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    EdgeInsets? contentPadding,
    EdgeInsets? scrollPadding,
    FTextFieldStateStyle? enabledStyle,
    FTextFieldStateStyle? disabledStyle,
    FTextFieldStateStyle? errorStyle,
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

/// A [FTextField] state's style.
final class FTextFieldStateStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle labelTextStyle;

  /// The content's [TextStyle].
  final TextStyle contentTextStyle;

  /// The hint's [TextStyle].
  final TextStyle hintTextStyle;

  /// The help/error's [TextStyle].
  final TextStyle descriptionTextStyle;

  /// The border's color when focused.
  final FTextFieldBorderStyle focusedStyle;

  /// The border's style when unfocused.
  final FTextFieldBorderStyle unfocusedStyle;

  /// Creates a [FTextFieldStateStyle].
  FTextFieldStateStyle({
    required this.labelTextStyle,
    required this.contentTextStyle,
    required this.hintTextStyle,
    required this.descriptionTextStyle,
    required this.focusedStyle,
    required this.unfocusedStyle,
  });

  /// Creates a [FTextFieldStateStyle] that inherits its properties.
  FTextFieldStateStyle.inherit({
    required Color contentColor,
    required Color hintColor,
    required Color focusedBorderColor,
    required Color unfocusedBorderColor,
    required FFormFieldStateStyle formFieldStateStyle,
    required FTypography typography,
    required FStyle style,
  })  : labelTextStyle = formFieldStateStyle.labelTextStyle,
        contentTextStyle = typography.sm.copyWith(
          fontFamily: typography.defaultFontFamily,
          color: contentColor,
        ),
        hintTextStyle = typography.sm.copyWith(
          fontFamily: typography.defaultFontFamily,
          color: hintColor,
        ),
        descriptionTextStyle = formFieldStateStyle.descriptionTextStyle,
        focusedStyle = FTextFieldBorderStyle.inherit(color: focusedBorderColor, style: style),
        unfocusedStyle = FTextFieldBorderStyle.inherit(color: unfocusedBorderColor, style: style);

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
  @useResult
  FTextFieldStateStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? descriptionTextStyle,
    FTextFieldBorderStyle? focusedStyle,
    FTextFieldBorderStyle? unfocusedStyle,
  }) =>
      FTextFieldStateStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        hintTextStyle: hintTextStyle ?? this.hintTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        focusedStyle: focusedStyle ?? this.focusedStyle,
        unfocusedStyle: unfocusedStyle ?? this.unfocusedStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('focusedStyle', focusedStyle))
      ..add(DiagnosticsProperty('unfocusedStyle', unfocusedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStateStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          focusedStyle == other.focusedStyle &&
          unfocusedStyle == other.unfocusedStyle;

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      focusedStyle.hashCode ^
      unfocusedStyle.hashCode;
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
  })  : width = style.borderWidth,
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
  @useResult
  FTextFieldBorderStyle copyWith({
    Color? color,
    double? width,
    BorderRadius? radius,
  }) =>
      FTextFieldBorderStyle(
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
