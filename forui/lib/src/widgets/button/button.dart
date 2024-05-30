import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

part 'button_content.dart';

part 'button_style.dart';

part 'button_styles.dart';

part 'button_content_style.dart';

/// Matthias help!
sealed class FButtonDesign {}

/// A [FButtonVariant] represents the possible states that a [FButton] can be in.
enum FButtonVariant implements FButtonDesign {
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
  /// Called when the FButton is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// This FButton's child.
  final Widget child;

  /// The style.
  final FButtonDesign style;

  /// Creates a [FButton] widget.
  FButton({
    required this.style,
    required this.onPressed,
    String? text,
    String? icon,
    super.key,
  }) : child = FButtonContent(
            text: text, icon: icon, style: style, disabled: onPressed == null);

  /// Creates a [FButton].
  const FButton.raw(
      {required this.onPressed,
      required this.child,
      required this.style,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.theme.buttonStyles.variant(this.style);
    return FTappable(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: onPressed == null ? style.disabledBorder : style.border,
          ),
          borderRadius: style.borderRadius,
          color: onPressed == null ? style.disabled : style.background,
        ),
        child: child,
      ),
    );
  }
}
