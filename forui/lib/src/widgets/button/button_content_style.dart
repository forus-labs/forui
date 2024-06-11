part of 'button.dart';

/// [FButtonContent]'s style.
class FButtonContentStyle with Diagnosticable {
  /// The [TextStyle] when this button is enabled.
  final TextStyle enabledText;

  /// The [TextStyle] when this button is disabled.
  final TextStyle disabledText;

  /// The icon's color when this button is enabled.
  final Color enabledIcon;

  /// The icon's color when this button is disabled.
  final Color disabledIcon;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledText,
    required this.disabledText,
    required this.enabledIcon,
    required this.disabledIcon,
    required this.padding,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [foreground] and [disabledForeground].
  FButtonContentStyle.inherit({ required FTypography font,required Color foreground, required Color disabledForeground})
      : padding = const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 17,
        ),
        enabledText = TextStyle(
          fontSize: font.base,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
        disabledText = TextStyle(
          fontSize: font.base,
          fontWeight: FontWeight.w600,
          color: disabledForeground,
        ),
        enabledIcon = foreground,
        disabledIcon = disabledForeground;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledText', enabledText))
      ..add(DiagnosticsProperty('disabledText', disabledText))
      ..add(DiagnosticsProperty('enabledIcon', enabledIcon))
      ..add(DiagnosticsProperty('disabledIcon', disabledIcon))
      ..add(DiagnosticsProperty('padding', padding));
  }
}
