import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button_content.dart';

enum FButtonType {
  primary,
  secondary,
  destructive,
  outlined,
}

class Fbutton extends StatelessWidget {
  /// The type of button.
  final FButtonType type;

  /// Called when the FButton is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// This FButton's child.
  final Widget child;

  /// The style.
  final FButtonStyle? style;

  /// Creates a [FButton] widget.
  Fbutton({
    required this.type,
    required this.onPressed,
    String? text,
    String? icon,
    this.style,
    super.key,
  }) : child = FButtonContent(text: text, icon: icon, style: style?.content);

  /// Creates a [Fbutton].
  const Fbutton.raw({required this.type, required this.onPressed, required this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgets.button;

    switch (type) {
      case FButtonType.primary:
        return _FlatButton(content: child, onPressed: onPressed, style: style.primary);
      case FButtonType.secondary:
        return _FlatButton(content: child, onPressed: onPressed, style: style.secondary);
      case FButtonType.destructive:
        return _FlatButton(content: child, onPressed: onPressed, style: style.destructive);
      case FButtonType.outlined:
        return _OutlinedButton(content: child, onPressed: onPressed, style: style.outlined);
    }
  }
}

class _FlatButton extends StatelessWidget {
  final ButtonStyle style;
  final Widget content;
  final VoidCallback? onPressed;

  const _FlatButton({
    required this.content,
    required this.onPressed,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FTappable(
        onPressed: onPressed,
        builder: (context, onPressed) => ElevatedButton(
          style: style,
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 17,
            ),
            child: content,
          ),
        ),
      );
}

class _OutlinedButton extends StatelessWidget {
  final ButtonStyle style;
  final Widget content;
  final VoidCallback? onPressed;

  const _OutlinedButton({
    required this.content,
    required this.onPressed,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FTappable(
        onPressed: onPressed,
        builder: (context, onPressed) => OutlinedButton(
          style: style,
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 17,
            ),
            child: content,
          ),
        ),
      );
}
