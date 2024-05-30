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

  /// Creates a [FButtonStyle] that inherits its properties from [colorScheme].
  FButtonStyles.inherit({required FColorScheme colorScheme, required FStyle style})
      : primary = FButtonStyle(
          background: colorScheme.primary,
          foreground: colorScheme.primaryForeground,
          disabled: const Color(0xFF787878),
          border: colorScheme.primary,
          disabledBorder: const Color(0xFF787878),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            color: colorScheme.primaryForeground,
          ),
        ),
        secondary = FButtonStyle(
          background: colorScheme.secondary,
          foreground: colorScheme.secondaryForeground,
          disabled: const Color(0xFFF7F7F8),
          border: colorScheme.secondary,
          disabledBorder: const Color(0xFFF7F7F8),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            color: colorScheme.secondaryForeground,
          ),
        ),
        destructive = FButtonStyle(
          background: colorScheme.destructive,
          foreground: colorScheme.destructiveForeground,
          disabled: const Color(0xFFEFAAAA),
          border: colorScheme.destructive,
          disabledBorder: const Color(0xFFEFAAAA),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            color: colorScheme.destructiveForeground,
          ),
        ),
        outlined = FButtonStyle(
          background: colorScheme.background,
          foreground: colorScheme.secondaryForeground,
          disabled:  colorScheme.background,
          border: colorScheme.border,
          disabledBorder: const Color(0xFFF0F0F0),
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(
            color: colorScheme.secondaryForeground,
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
