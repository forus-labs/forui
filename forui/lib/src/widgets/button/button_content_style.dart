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

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [color].
  FButtonContentStyle.inherit({required Color color}):
      padding = const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 17,
      ),
      text = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );
}
