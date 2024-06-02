part of 'button.dart';

/// Represents a content for [FButton].
@internal
final class FButtonContent extends StatelessWidget {
  /// The style.
  final FButtonStyle style;

  /// Whether the button should be enabled.
  final bool enabled;

  /// The label on the button.
  final String? text;

  /// The icon;
  final SvgAsset? icon;

  /// The child.
  final Widget? child;

  /// Creates a [FButtonContent].
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
            icon!(height: 20, colorFilter: enabled ? style.enabledIcon : style.disabledIcon),
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
      ..add(FlagProperty('enabled', value: enabled))
      ..add(DiagnosticsProperty<SvgAsset?>('icon', icon))
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty<FButtonDesign>('style', style));
  }
}
