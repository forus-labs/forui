import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:nitrogen_types/nitrogen_types.dart';
import 'package:forui/src/svg_extension.nitrogen.dart';

part 'button_content.dart';

part 'button_style.dart';

part 'button_styles.dart';

part 'button_content_style.dart';

/// The button design.
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
    SvgAsset? icon,
    super.key,
  }) : child = FButtonContent(
          text: text,
          icon: icon,
          style: style,
          disabled: onPressed == null,
        );

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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
    ..add(DiagnosticsProperty<FButtonDesign>('style', style));
  }
}
