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

  /// Creates a [FCardContentStyle] that inherits its properties from [style] and [font].
  FCardContentStyle.inherit({required FStyleData style, required FFontData font})
      : padding = const EdgeInsets.all(20),
        title = ScaledTextStyle(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: style.foreground,
          ),
          font,
        ),
        subtitle = ScaledTextStyle(
          TextStyle(
            fontSize: 12,
            color: style.mutedForeground,
          ),
          font,
        );
}
