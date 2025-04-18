import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/card/card_content.dart';

part 'card.style.dart';

/// A card.
///
/// Cards are typically used to group related information together.
///
/// See:
/// * https://forui.dev/docs/data/card for working examples.
/// * [FCardStyle] for customizing a card's appearance.
final class FCard extends StatelessWidget {
  /// The style. Defaults to [FThemeData.cardStyle].
  final FCardStyle? style;

  /// The child.
  final Widget child;

  /// Creates a [FCard] with a title, subtitle, and [child].
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

  /// Creates a [FCardStyle] that inherits its properties.
  FCardStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: style.borderRadius,
          color: colors.background,
        ),
        contentStyle: FCardContentStyle(
          titleTextStyle: typography.xl2.copyWith(fontWeight: FontWeight.w600, color: colors.foreground, height: 1.5),
          subtitleTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
        ),
      );
}
