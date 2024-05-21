part of 'card.dart';

/// [FCardContent]'s style.
class FCardContentStyle {
  /// The padding.
  final EdgeInsets padding;

  /// The title.
  final TextStyle title;

  /// The subtitle.
  final TextStyle subtitle;

  /// Creates a [FCardContentStyle].
  const FCardContentStyle({required this.padding, required this.title, required this.subtitle});

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme] and [font].
  FCardContentStyle.inherit({required FColorScheme colorScheme, required FFont font}):
      padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
      title = font.toTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.foreground,
      ),
      subtitle = TextStyle(
        fontSize: 12,
        color: colorScheme.mutedForeground,
      );

}
