part of 'box.dart';

/// [FBox]'s style.
class FBoxStyle {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text;

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits its properties from [colorScheme].
  FBoxStyle.inherit({required FColorScheme colorScheme}):
    color = colorScheme.muted,
    text = const TextStyle(fontSize: 20);
}
