part of 'card.dart';

/// [FCard]'s style.
class FCardStyle {
  /// The decoration.
  final BoxDecoration decoration;

  /// The [FCardContent] style.
  final FCardContentStyle content;

  /// Creates a [FCardStyle].
  FCardStyle({required this.decoration, required this.content});

  /// Creates a [FCardStyle] that inherits its properties from [style] and [font].
  FCardStyle.inherit({required FStyleData style, required FFontData font})
      : decoration = BoxDecoration(
          border: Border.all(color: style.border),
          borderRadius: style.borderRadius,
        ),
        content = FCardContentStyle.inherit(style: style, font: font);
}
