part of 'button.dart';

@internal final class FButtonContent extends StatelessWidget {
  final FButtonStyle style;
  final bool enabled;
  final String? text;
  final SvgAsset? icon; // TODO: We should allow for custom heading and trailing widgets.
  final Widget? child;

  const FButtonContent({
    required this.style,
    this.enabled = true,
    this.text,
    this.icon,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style.content;
    return Padding(
      padding: style.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!(
              height: 20, // TODO: Icon size should be configurable.
              colorFilter: ColorFilter.mode(enabled ? style.enabledIcon : style.disabledIcon, BlendMode.srcIn),
            ),
            const SizedBox(width: 10)
          ],
          if (text != null) Flexible(child: Text(text!, style: enabled ? style.enabledText : style.disabledText)),
          if (child != null) child!
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, defaultValue: true))
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

/// [FButtonContent]'s style.
class FButtonContentStyle with Diagnosticable {
  /// The [TextStyle] when this button is enabled.
  final TextStyle enabledText;

  /// The [TextStyle] when this button is disabled.
  final TextStyle disabledText;

  /// The icon's color when this button is enabled.
  final Color enabledIcon;

  /// The icon's color when this button is disabled.
  final Color disabledIcon;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledText,
    required this.disabledText,
    required this.enabledIcon,
    required this.disabledIcon,
    required this.padding,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [foreground] and [disabledForeground].
  FButtonContentStyle.inherit({ required FTypography typography,required Color foreground, required Color disabledForeground})
      : padding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 15,
  ),
        enabledText = TextStyle(
          fontSize: typography.base,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
        disabledText = TextStyle(
          fontSize: typography.base,
          fontWeight: FontWeight.w600,
          color: disabledForeground,
        ),
        enabledIcon = foreground,
        disabledIcon = disabledForeground;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledText', enabledText))
      ..add(DiagnosticsProperty('disabledText', disabledText))
      ..add(DiagnosticsProperty('enabledIcon', enabledIcon))
      ..add(DiagnosticsProperty('disabledIcon', disabledIcon))
      ..add(DiagnosticsProperty('padding', padding));
  }
}
