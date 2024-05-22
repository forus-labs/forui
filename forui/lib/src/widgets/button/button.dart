import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button_content.dart';

/// A [FButtonType] represents the possible states that a [FButton] can be in.
enum FButtonType {
  /// a primary button
  primary,

  /// a secondary button
  secondary,

  /// a destructive button
  destructive,

  /// a outlined button
  outlined,
}

/// Represents a button widget.
class FButton extends StatelessWidget {
  /// The type of button.
  final FButtonType type;

  /// Called when the FButton is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// This FButton's child.
  final Widget child;

  /// The style.
  final FButtonStyle? style;

  /// Creates a [FButton] widget.
  FButton({
    required this.type,
    required this.onPressed,
    String? text,
    String? icon,
    this.style,
    super.key,
  }) : child = FButtonContent(text: text, icon: icon, style: style?.content);

  /// Creates a [FButton].
  const FButton.raw({required this.type, required this.onPressed, required this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgets.button;

    switch (type) {
      case FButtonType.primary:
        return _Button(onPressed: onPressed, style: style, type: style.primary, child: child);
      case FButtonType.secondary:
        return _Button(onPressed: onPressed, style: style, type: style.secondary, child: child);
      case FButtonType.destructive:
        return _Button(onPressed: onPressed, style: style, type: style.destructive, child: child);
      case FButtonType.outlined:
        return _Button(onPressed: onPressed, style: style, type: style.outlined, child: child);
    }
  }
}

class _Button extends StatelessWidget {
  final FButtonStyle style;
  final FButtonTypeStyle type;
  final Widget child;
  final VoidCallback? onPressed;

  const _Button({
    required this.style,
    required this.type,
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FTappable(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: type.border),
          borderRadius: style.borderRadius,
          color: type.background,
        ),
        padding: style.padding,
        child: child,
      ),
    );
}
