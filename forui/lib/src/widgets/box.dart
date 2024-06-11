import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A simple box that demonstrates Forui's architecture.
final class FBox extends StatelessWidget {
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
        style: text.scale(context.theme.typography),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty<FBoxStyle?>('style', style));
  }
}

/// [FBox]'s style.
final class FBoxStyle with Diagnosticable {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text;

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits its properties from [colorScheme].
  FBoxStyle.inherit({required FColorScheme colorScheme}):
        color = colorScheme.muted,
        text = const TextStyle(fontSize: 20);

  /// Creates a copy of this [FBoxStyle] with the given properties replaced.
  FBoxStyle copyWith({Color? color, TextStyle? text}) => FBoxStyle(
      color: color ?? this.color,
      text: text ?? this.text,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBoxStyle && runtimeType == other.runtimeType && color == other.color && text == other.text;

  @override
  int get hashCode => color.hashCode ^ text.hashCode;
}
