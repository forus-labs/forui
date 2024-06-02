part of 'button.dart';

/// [FButtonContent]'s style.
class FButtonContentStyle {
  /// The textile of .
  final TextStyle enabledText;

  /// The title.
  final TextStyle disabledText;

  /// the color
  final ColorFilter enabledIcon;

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

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [color].
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
}
