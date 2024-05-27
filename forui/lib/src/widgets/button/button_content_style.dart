part of 'button.dart';

/// [FButtonContent]'s style.
class FButtonContentStyle {
  /// The title.
  final TextStyle text;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonContentStyle].
  const FButtonContentStyle({
    required this.text,
    required this.padding,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from [style] and [font].
  FButtonContentStyle.inherit({required FFontData font, required Color color})
      : padding = const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 17,
        ),
        text = ScaledTextStyle(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
          font,
        );
}
