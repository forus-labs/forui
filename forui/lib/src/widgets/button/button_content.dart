part of 'button.dart';

/// Represents a content for [FButton].
final class FButtonContent extends StatelessWidget {
  /// The label on the button.
  final String? text;

  /// The icon;
  final SvgAsset? icon;

  /// The child.
  final Widget? child;

  /// The style.
  final FButtonDesign style;

  /// Whether the button should be disabled.
  final bool disabled;

  /// Creates a [FButtonContent].
  const FButtonContent({
    required this.style,
    this.disabled = false,
    this.text,
    this.icon,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = theme.buttonStyles.variant(this.style).content;

    return Padding(
      padding: style.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!(height: 20, colorFilter: disabled ? style.disabledIcon : style.enabledIcon),
            const SizedBox(width: 10)
          ],
          if (text != null) Flexible(child: Text(text!, style: disabled ? style.disabledText : style.enabledText)),
          if (child != null) child!
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<SvgAsset?>('icon', icon))
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty<FButtonDesign>('style', style));
  }
}
