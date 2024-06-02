part of 'button.dart';

/// [FButtonContent]'s style.
class FButtonContentStyle with Diagnosticable {
  /// The TextStyle for an enabled button.
  final TextStyle enabledText;

  /// The TextStyle for an disabled button.
  final TextStyle disabledText;

  /// The ColorFilter for an enabled button.
  final ColorFilter enabledIcon;

  /// The ColorFilter for an disabled button.
  final ColorFilter disabledIcon;

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

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [foreground] and [].
  FButtonContentStyle.inherit({ required FFont font,required Color foreground, required Color disabledForeground})
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
        enabledIcon = ColorFilter.mode(foreground, BlendMode.srcIn),
        disabledIcon = ColorFilter.mode(disabledForeground, BlendMode.srcIn);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<TextStyle>('enabledText', enabledText))
    ..add(DiagnosticsProperty<TextStyle>('disabledText', disabledText))
    ..add(DiagnosticsProperty<ColorFilter>('enabledIcon', enabledIcon))
    ..add(DiagnosticsProperty<ColorFilter>('disabledIcon', disabledIcon))
    ..add(DiagnosticsProperty<EdgeInsets>('padding', padding));
  }
}
