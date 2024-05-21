part of 'box.dart';

/// [FBox]'s style.
class FBoxStyle {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text;

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits its properties from [font] and [colorScheme].
  FBoxStyle.inherit({required FColorScheme colorScheme, required FFont font}):
    color = colorScheme.muted, text = font.toTextStyle(fontSize: 20);
}
