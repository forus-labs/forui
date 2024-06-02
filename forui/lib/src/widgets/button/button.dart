import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:nitrogen_types/nitrogen_types.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/svg_extension.nitrogen.dart';

part 'button_content.dart';
part 'button_style.dart';
part 'button_styles.dart';
part 'button_content_style.dart';

/// The button design. Either a pre-defined [FButtonVariant], or a custom [FButtonStyle].
sealed class FButtonDesign {}

/// A pre-defined button variant.
enum FButtonVariant implements FButtonDesign {
  /// A primary-styled button.
  primary,

  /// A secondary-styled button.
  secondary,

  /// An outlined button.
  outlined,

  /// A destructive button.
  destructive,
}

/// A button.
class FButton extends StatelessWidget {
  /// The style.
  final FButtonDesign design;

  /// Called when the FButton is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The builder.
  final Widget Function(BuildContext, FButtonStyle) builder;

  /// Creates a [FButton] widget.
  FButton({
    this.design = FButtonVariant.primary,
    this.onPressed,
    String? text,
    SvgAsset? icon,
    super.key,
  }) : builder = ((context, style) => FButtonContent(
              text: text,
              icon: icon,
              style: style,
              enabled: onPressed != null,
            ));

  /// Creates a [FButton].
  const FButton.raw(
      {required this.design,
      required this.builder,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = switch (design) {
      final FButtonStyle style => style,
      FButtonVariant.primary => context.theme.buttonStyles.primary,
      FButtonVariant.secondary => context.theme.buttonStyles.secondary,
      FButtonVariant.outlined => context.theme.buttonStyles.outlined,
      FButtonVariant.destructive => context.theme.buttonStyles.destructive,
    };
    return FTappable(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: onPressed == null
            ? style.disabledBoxDecoration
            : style.enabledBoxDecoration,
        child: builder(context, style),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<VoidCallback?>('onPressed', onPressed))
      ..add(DiagnosticsProperty<FButtonDesign>('style', design))
      ..add(ObjectFlagProperty<
          Widget Function(
              BuildContext p1, FButtonStyle p2)>.has('builder', builder));
  }
}
