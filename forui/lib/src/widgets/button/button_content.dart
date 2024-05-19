import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Represents a content for [FButton].
final class FButtonContent extends StatelessWidget {
  /// The label on the button.
  final String? text;

  /// The icon;
  final String? icon;

  /// The child.
  final Widget? child;

  /// The style.
  final FButtonContentStyle? style;

  /// Creates a [FButtonContent].
  const FButtonContent({
    this.text,
    this.icon,
    this.child,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgets.button.content;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      // [SvgTheme] provides a default color that overrides material's ButtonStyle foregroundColor
      // This is a workaround, the color of the icon is set here instead of the ButtonStyle.
      if (icon != null) //...[icon(height: 20, color: style.color), const SizedBox(width: 10)],
        if (text != null) Flexible(child: Text(text!, style: style.text)),
      if (child != null) child!
    ]);
  }
}
