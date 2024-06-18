part of 'button.dart';

@internal final class FButtonContent extends StatelessWidget {
  final FButtonStyle style;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? label;
  final String? labelText;

  const FButtonContent({
    required this.style,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style.content;
    return Padding(
      padding: style.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: separate([
          if (prefixIcon != null)
            prefixIcon!,

          switch ((label, labelText)) {
            (final Widget label, _) => label,
            (_, final String label) => Text(label),
            _ => const Placeholder(),
          },

          if (suffixIcon != null)
            suffixIcon!,
        ], by: [
          const SizedBox(width: 10),
        ]),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, defaultValue: true))
      ..add(StringProperty('labelText', labelText));
  }
}

/// [FButtonContent]'s style.
class FButtonContentStyle with Diagnosticable {
  /// The [TextStyle] when this button is enabled.
  final TextStyle enabledText;

  /// The [TextStyle] when this button is disabled.
  final TextStyle disabledText;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledText,
    required this.disabledText,
    required this.padding,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [foreground] and [disabledForeground].
  FButtonContentStyle.inherit({required FTypography typography, required Color foreground, required Color disabledForeground})
      : padding = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12.5,
  ),
        enabledText = TextStyle(
          fontSize: typography.base,
          fontWeight: FontWeight.w500,
          color: foreground,
        ),
        disabledText = TextStyle(
          fontSize: typography.base,
          fontWeight: FontWeight.w500,
          color: disabledForeground,
        );
        // enabledIcon = foreground,
        // disabledIcon = disabledForeground;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledText', enabledText))
      ..add(DiagnosticsProperty('disabledText', disabledText))
      ..add(DiagnosticsProperty('padding', padding));
  }
}
