import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:meta/meta.dart';

part 'nested_header_action.dart';

/// A nested header.
///
/// A nested header contains the page's title and actions (including pop navigation).
/// It is typically used on pages that are not at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/nested-header for working examples.
/// * [FNestedHeaderStyle] for customizing a header's appearance.
final class FNestedHeader extends StatelessWidget {
  /// The style. Defaults to [FThemeData.nestedHeaderStyle].
  final FNestedHeaderStyle? style;

  /// The title, aligned to the center.
  ///
  /// ## Contract:
  /// Throws [AssertionError]:
  /// * if [title] and [rawTitle] are both not null
  /// * if [title] and [rawTitle] are both null
  final String? title;

  /// The title, aligned to the center.
  ///
  /// ## Contract:
  /// Throws [AssertionError]:
  /// * if [title] and [rawTitle] are both not null
  /// * if [title] and [rawTitle] are both null
  final Widget? rawTitle;

  /// The actions, aligned to the left. Defaults to an empty list.
  final List<Widget> leftActions;

  /// The actions, aligned to the right. Defaults to an empty list.
  final List<Widget> rightActions;

  /// Creates a [FNestedHeader].
  ///
  /// ## Contract:
  /// Throws [AssertionError] if:
  /// * [title] and [rawTitle] are both not null.
  const FNestedHeader({
    this.style,
    this.title,
    this.rawTitle,
    this.leftActions = const [],
    this.rightActions = const [],
    super.key,
  }) : assert((title != null) ^ (rawTitle != null), 'title or rawTitle must be provided, but not both.');

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.nestedHeaderStyle;

    final title = switch ((this.title, rawTitle)) {
      (final String title, _) => Text(title),
      (_, final Widget title) => title,
      _ => const Placeholder(),
    };

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: style.padding,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: leftActions.expand((action) => [action, const SizedBox(width: 10)]).toList()),
                Row(children: rightActions.expand((action) => [const SizedBox(width: 10), action]).toList()),
              ],
            ),
            Positioned.fill(
              child: Align(
                child: DefaultTextStyle.merge(
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: style.titleTextStyle,
                  child: title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty('rawTitle', rawTitle));
  }
}

/// [FNestedHeader]'s style.
final class FNestedHeaderStyle with Diagnosticable {
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]'s style for [FNestedHeader.leftActions] and [FNestedHeader.rightActions].
  final FNestedHeaderActionStyle actionStyle;

  /// The spacing between [FHeaderAction]s.
  final double actionSpacing;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FNestedHeaderStyle].
  const FNestedHeaderStyle({
    required this.titleTextStyle,
    required this.actionStyle,
    required this.actionSpacing,
    required this.padding,
  });

  /// Creates a [FNestedHeaderStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FNestedHeaderStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  })  : titleTextStyle = typography.xl.copyWith(
          color: colorScheme.foreground,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
        actionStyle = FNestedHeaderActionStyle.inherit(colorScheme: colorScheme),
        actionSpacing = 10,
        padding = style.pagePadding.copyWith(bottom: 15);

  /// Returns a copy of this [FNestedHeaderStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FNestedHeaderStyle(
  ///   titleTextStyle: ...,
  ///   leftAction: ...,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   leftAction: ...,
  /// );
  ///
  /// print(style.titleTextStyle == copy.titleTextStyle); // true
  /// print(style.leftAction == copy.leftAction); // false
  /// ```
  FNestedHeaderStyle copyWith({
    TextStyle? titleTextStyle,
    FNestedHeaderActionStyle? actionStyle,
    double? actionSpacing,
    EdgeInsets? padding,
  }) =>
      FNestedHeaderStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        actionStyle: actionStyle ?? this.actionStyle,
        actionSpacing: actionSpacing ?? this.actionSpacing,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('actionStyle', actionStyle))
      ..add(DiagnosticsProperty('actionSpacing', actionSpacing))
      ..add(DiagnosticsProperty('padding', padding));
  }
}
