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
  final bool? disabled;

  /// Creates a [FButtonContent].
  const FButtonContent({
    required this.style,
    this.text,
    this.icon,
    this.child,
    this.disabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyles = FTheme.of(context).widgets.button;

    // TODO: Move into a method in the Style
    final style = switch (this.style) {
      final FButtonStyle style => style,
      FButtonVariant.primary => buttonStyles.primary,
      FButtonVariant.secondary => buttonStyles.secondary,
      FButtonVariant.destructive => buttonStyles.destructive,
      FButtonVariant.outlined => buttonStyles.outlined,
    };
    final content = style.content;

    return Padding(
      padding: content.padding,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // [SvgTheme] provides a default color that overrides material's ButtonStyle foregroundColor
        // This is a workaround, the color of the icon is set here instead of the ButtonStyle.
        //if (icon != null) ...[icon(height: 20, color: style.color), const SizedBox(width: 10)],
        if (text != null) Flexible(child: Text(text!, style: content.text)),
        if (child != null) child!
      ]),
    );
  }
}
