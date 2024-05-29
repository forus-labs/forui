part of 'button.dart';

/// Represents a content for [FButton].
final class FButtonContent extends StatelessWidget {
  /// The label on the button.
  final String? text;

  /// The icon;
  final String? icon;

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
    final style = FTheme.of(context).widgets.button.variant(this.style);

    return Padding(
      padding: style.content.padding,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // [SvgTheme] provides a default color that overrides material's ButtonStyle foregroundColor
        // This is a workaround, the color of the icon is set here instead of the ButtonStyle.

        //if (icon != null) ...[icon(height: 20, color: style.color), const SizedBox(width: 10)],

        if (text != null)
          Flexible(
            child: Text(
              text!,
              style: style.content.text.copyWith(
                color: disabled ? style.content.text.color!.withOpacity(0.5) : style.content.text.color,
              ),
            ),
          ),
        if (child != null) child!
      ]),
    );
  }
}
