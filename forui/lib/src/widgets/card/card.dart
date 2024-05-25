import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'card_content.dart';

/// A card widget.
final class FCard extends StatelessWidget {
  /// The child.
  final Widget child;

  /// The style.
  final FCardStyle? style;

  /// Creates a [FCard] with a tile and subtitle.
  FCard({
    String? title,
    String? subtitle,
    Widget? child,
    this.style,
    super.key,
  }) : child = FCardContent(title: title, subtitle: subtitle, child: child);

  /// Creates a [FCard].
  const FCard.raw({required this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = this.style ?? theme.cardStyle;
    return DecoratedBox(
      decoration: style.decoration,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FCardStyle?>('style', style));
  }
}

/// [FCard]'s style.
final class FCardStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The [FCardContent] style.
  final FCardContentStyle content;

  /// Creates a [FCardStyle].
  FCardStyle({required this.decoration, required this.content});

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [style].
  FCardStyle.inherit({required FColorScheme colorScheme, required FStyle style}):
    decoration = BoxDecoration(
      border: Border.all(color: colorScheme.border),
      borderRadius: style.borderRadius,
      color: colorScheme.background,
    ),
    content = FCardContentStyle.inherit(colorScheme: colorScheme);

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  FCardStyle copyWith({BoxDecoration? decoration, FCardContentStyle? content}) => FCardStyle(
    decoration: decoration ?? this.decoration,
    content: content ?? this.content,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FCardContentStyle>('content', content))
      ..add(DiagnosticsProperty<BoxDecoration>('decoration', decoration));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FCardStyle &&
      runtimeType == other.runtimeType &&
      decoration == other.decoration &&
      content == other.content;

  @override
  int get hashCode => decoration.hashCode ^ content.hashCode;
}
