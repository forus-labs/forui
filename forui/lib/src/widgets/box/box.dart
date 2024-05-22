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
    final style = this.style ?? FTheme.of(context).boxStyle;

    return ColoredBox(
      color: style.color,
      child: Text(
        text,
        style: style.text,
      ),
    );
  }
}
