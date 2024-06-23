import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'card_content.dart';

/// A card widget.
final class FCard extends StatelessWidget {
  /// The style. Defaults to [FThemeData.cardStyle].
  final FCardStyle? style;

  /// The child.
  final Widget child;

  /// Creates a [FCard] with a tile and subtitle.
  FCard({
    String? title,
    Widget? rawTitle,
    String? subtitle,
    Widget? rawSubtitle,
    Widget? child,
    this.style,
    super.key,
  }) :
    assert(title == null || rawTitle == null, 'Cannot provide both a title and a rawTitle.'),
    assert(subtitle == null || rawSubtitle == null, 'Cannot provide both a subtitle and a rawSubtitle.'),
    child = FCardContent(
    title: title,
    rawTitle: rawTitle,
    subtitle: subtitle,
    rawSubtitle: rawSubtitle,
    style: style?.content,
    child: child,
  );

  /// Creates a [FCard].
  const FCard.raw({required this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: (style ?? context.theme.cardStyle).decoration,
    child: child,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
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

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme], [typography] and [style].
  FCardStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style}):
    decoration = BoxDecoration(
      border: Border.all(color: colorScheme.border),
      borderRadius: style.borderRadius,
      color: colorScheme.background,
    ),
    content = FCardContentStyle.inherit(colorScheme: colorScheme, typography: typography);

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  FCardStyle copyWith({BoxDecoration? decoration, FCardContentStyle? content}) => FCardStyle(
    decoration: decoration ?? this.decoration,
    content: content ?? this.content,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('decoration', decoration));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FCardStyle &&
      runtimeType == other.runtimeType &&
      decoration == other.decoration &&
      content == other.content;

  @override
  int get hashCode => decoration.hashCode ^ content.hashCode;
}
