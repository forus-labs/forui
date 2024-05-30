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
    required this.disabled,
    this.text,
    this.icon,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = theme.buttonStyles.variant(this.style);

    return Padding(
      padding: style.content.padding,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (icon != null) ...[
          icon!(
            height: 20,
            colorFilter: ColorFilter.mode(style.foreground, BlendMode.srcIn),
          ),
          const SizedBox(width: 10)
        ],

        if (text != null)
          Flexible(
            child: Text(
              text!,
              style: style.content.text
                  .copyWith(
                    color: disabled
                        ? style.content.text.color!.withOpacity(0.5)
                        : style.content.text.color,
                  )
                  .withFont(theme.font),
            ),
          ),
        if (child != null) child!
      ]),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<bool>('disabled', disabled))
    ..add(DiagnosticsProperty<SvgAsset?>('icon', icon))
    ..add(StringProperty('text', text))
    ..add(DiagnosticsProperty<FButtonDesign>('style', style));
  }
}
