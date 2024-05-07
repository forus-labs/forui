import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/box/box_style.dart';

/// A sample widget demonstrating the architecture of ForUI.
class FBox extends StatelessWidget {
  /// The text.
  final String text;

  /// The style.
  final FBoxStyle? style;

  /// Creates a [FBox].
  const FBox({required this.text, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgetData.boxStyle;

    return ColoredBox(
      color: style.color,
      child: Text(
        text,
        style: style.text,
      ),
    );
  }
}
