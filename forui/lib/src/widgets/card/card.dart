import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/card/card_content.dart';

part 'card.style.dart';

/// A card.
///
/// Card are typically used to group related information together.
///
/// See:
/// * https://forui.dev/docs/data/card for working examples.
/// * [FCardStyle] for customizing a card's appearance.
final class FCard extends StatelessWidget {
  /// The style. Defaults to [FThemeData.cardStyle].
  final FCardStyle? style;

  /// The child.
  final Widget child;

  /// Creates a [FCard] with a tile, subtitle, and [child].
  ///
  /// The card's layout is as follows:
  /// ```diagram
  /// |---------------------------|
  /// |  [image]                  |
  /// |                           |
  /// |  [title]                  |
  /// |  [subtitle]               |
  /// |                           |
  /// |  [child]                  |
  /// |---------------------------|
  /// ```
  FCard({Widget? image, Widget? title, Widget? subtitle, Widget? child, this.style, super.key})
    : child = Content(image: image, title: title, subtitle: subtitle, style: style?.contentStyle, child: child);

  /// Creates a [FCard] with custom content.
  const FCard.raw({required this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) =>
      DecoratedBox(decoration: (style ?? context.theme.cardStyle).decoration, child: child);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// [FCard]'s style.
final class FCardStyle with Diagnosticable, _$FCardStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The card content's style.
  @override
  final FCardContentStyle contentStyle;

  /// Creates a [FCardStyle].
  FCardStyle({required this.decoration, required this.contentStyle});

  /// Creates a [FCardStyle] that inherits its properties from [color], [text] and [style].
  FCardStyle.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        decoration: BoxDecoration(
          border: Border.all(color: color.border),
          borderRadius: style.borderRadius,
          color: color.background,
        ),
        contentStyle: FCardContentStyle(
          titleTextStyle: text.xl2.copyWith(fontWeight: FontWeight.w600, color: color.foreground, height: 1.5),
          subtitleTextStyle: text.sm.copyWith(color: color.mutedForeground),
        ),
      );
}
