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
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.primary,
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.primary.withOpacity(0.5),
          ),
          content: FButtonContentStyle.inherit(
              foreground: colorScheme.primaryForeground,
              disabledForeground: colorScheme.primaryForeground.withOpacity(0.5)),
        ),
        secondary = FButtonStyle(
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary,
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary.withOpacity(0.5),
          ),
          content: FButtonContentStyle.inherit(
              foreground: colorScheme.secondaryForeground,
              disabledForeground: colorScheme.secondaryForeground.withOpacity(0.5)),
        ),
        destructive = FButtonStyle(
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.destructive,
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.destructive.withOpacity(0.5),
          ),
          content: FButtonContentStyle.inherit(
              foreground: colorScheme.destructiveForeground,
              disabledForeground: colorScheme.destructiveForeground.withOpacity(0.5)),
        ),
        outlined = FButtonStyle(
          enabledBoxDecoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.border,
            ),
            borderRadius: style.borderRadius,
            color: colorScheme.background,
          ),
          disabledBoxDecoration: BoxDecoration(
            border: Border.all(color: colorScheme.border.withOpacity(0.5)),
            borderRadius: style.borderRadius,
            color: colorScheme.background,
          ),
          content: FButtonContentStyle.inherit(
              foreground: colorScheme.secondaryForeground,
              disabledForeground: colorScheme.secondaryForeground.withOpacity(0.5)),
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
