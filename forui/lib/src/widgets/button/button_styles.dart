part of 'button.dart';

/// [FButtonStyle]'s style.
class FButtonStyles {
  /// The primary style.
  final FButtonStyle primary;

  /// The secondary style.
  final FButtonStyle secondary;

  /// The destructive style.
  final FButtonStyle destructive;

  /// The outlined style.
  final FButtonStyle outlined;

  /// Creates a [FButtonStyle].
  const FButtonStyles({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outlined,
  });

  /// Creates a [FButtonStyle] that inherits its properties from [data] and [style].
  FButtonStyles.inherit({required FFontData font, required FStyleData style})
      : primary = FButtonStyle(
          background: style.primary,
          foreground: style.primaryForeground,
          disabled: const Color(0xFF787878),
          border: style.primary,
          disabledBorder: const Color(0xFF787878),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            font: font,
            color: style.primaryForeground,
          ),
        ),
        secondary = FButtonStyle(
          background: style.secondary,
          foreground: style.secondaryForeground,
          disabled: const Color(0xFFF7F7F8),
          border: style.secondary,
          disabledBorder: const Color(0xFFF7F7F8),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            font: font,
            color: style.secondaryForeground,
          ),
        ),
        destructive = FButtonStyle(
          background: style.destructive,
          foreground: style.destructiveForeground,
          disabled: const Color(0xFFEFAAAA),
          border: style.destructive,
          disabledBorder: const Color(0xFFEFAAAA),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            font: font,
            color: style.destructiveForeground,
          ),
        ),
        outlined = FButtonStyle(
          background: style.background,
          foreground: style.secondaryForeground,
          disabled:  style.background,
          border: style.border,
          disabledBorder: const Color(0xFFF0F0F0),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            font: font,
            color: style.secondaryForeground,
          ),
        );

  /// Returns a [FButtonStyle] based on the corresponding [FButtonVariant].
  FButtonStyle variant(FButtonDesign style) => switch (style) {
        final FButtonStyle style => style,
        FButtonVariant.primary => primary,
        FButtonVariant.secondary => secondary,
        FButtonVariant.destructive => destructive,
        FButtonVariant.outlined => outlined,
      };
}
