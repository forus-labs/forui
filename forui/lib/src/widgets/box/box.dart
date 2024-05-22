import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

part 'box_style.dart';

/// A sample widget that demonstrates Forui's architecture.
class FBox extends StatelessWidget {
  /// The text.
  final String text;

  /// The style.
  final FBoxStyle? style;

  /// Creates a [FBox].
  const FBox({required this.text, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final FBoxStyle(:color, :text) = style ?? context.theme.boxStyle;
    return ColoredBox(
      color: color,
      child: Text(
        this.text,
        style: text.withFont(context.theme.font),
      ),
    );
  }
}
