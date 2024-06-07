part of 'button.dart';

/// [FButtonStyle]'s style.
class FButtonStyles with Diagnosticable{
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
  FButtonStyles.inherit({required FColorScheme colorScheme, required FTypography font, required FStyle style})
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
            font: font,
            foreground: colorScheme.primaryForeground,
            disabledForeground: colorScheme.primaryForeground.withOpacity(0.5),
          ),
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
            font: font,
            foreground: colorScheme.secondaryForeground,
            disabledForeground: colorScheme.secondaryForeground.withOpacity(0.5),
          ),
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
            font: font,
            foreground: colorScheme.destructiveForeground,
            disabledForeground: colorScheme.destructiveForeground.withOpacity(0.5),
          ),
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
            font: font,
            foreground: colorScheme.secondaryForeground,
            disabledForeground: colorScheme.secondaryForeground.withOpacity(0.5),
          ),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('destructive', destructive))
      ..add(DiagnosticsProperty('outlined', outlined));
  }
}
