import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'card_content.dart';
part 'card_style.dart';
part 'card_content_style.dart';

/// Represents a card widget.
class FCard extends StatelessWidget {
  /// The child.
  final Widget child;

  /// The style.
  final FCardStyle? style;

  /// Creates a [FCard].
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
}
