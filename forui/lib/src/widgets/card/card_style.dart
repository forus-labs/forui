part of 'card.dart';

/// [FCard]'s style.
class FCardStyle {
  /// The decoration.
  final BoxDecoration decoration;

  /// The [FCardContent] style.
  final FCardContentStyle content;

  /// Creates a [FCardStyle].
  FCardStyle({required this.decoration, required this.content});

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [font].
  FCardStyle.inherit({required FColorScheme colorScheme, required FFont font, required FStyle style})
      : decoration = BoxDecoration(
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
        ),
        content = FCardContentStyle.inherit(colorScheme: colorScheme, font: font);
}
