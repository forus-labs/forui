part of 'box.dart';

/// [FBox]'s style.
class FBoxStyle {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text;

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits its properties from [font] and [style].
  FBoxStyle.inherit({required FStyleData style, required FFontData font}):
    color = style.muted, text = ScaledTextStyle(const TextStyle(fontSize: 20), font);
}
