part of 'button.dart';

@internal
final class FButtonContent extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final Widget? rawLabel;

  const FButtonContent({
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.rawLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final (:style, :enabled) = FButton._of(context);

    return Padding(
        padding: style.content.padding,
        child: DefaultTextStyle.merge(
          style: enabled ? style.content.enabledText.scale(typography) : style.content.disabledText.scale(typography),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: separate([
              if (prefixIcon != null) prefixIcon!,
              switch ((label, rawLabel, )) {
                (final String label, _) => Text(label),
                (_, final Widget label) => label,
                _ => const Placeholder(),
              },
              if (suffixIcon != null) suffixIcon!,
            ], by: [
              const SizedBox(width: 10),
            ]),
          ),
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
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
  FButtonContentStyle.inherit({
    required FTypography typography,
    required Color foreground,
    required Color disabledForeground,
  })  : padding = const EdgeInsets.symmetric(
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledText', enabledText))
      ..add(DiagnosticsProperty('disabledText', disabledText))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonContentStyle &&
          runtimeType == other.runtimeType &&
          enabledText == other.enabledText &&
          disabledText == other.disabledText &&
          padding == other.padding;

  @override
  int get hashCode => enabledText.hashCode ^ disabledText.hashCode ^ padding.hashCode;
}
