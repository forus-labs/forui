import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

part 'header_action.dart';

/// A header.
///
/// A header contains the page's title and navigation actions. It is typically used on pages at the root of the
/// navigation stack.
///
/// See:
/// * https://forui.dev/docs/header for working examples.
/// * [FHeaderStyle] for customizing a header's appearance.
class FHeader extends StatelessWidget {
  /// The header's style. Defaults to [FThemeData.headerStyle].
  final FHeaderStyle? style;

  /// The title, aligned to the left.
  ///
  /// ## Contract:
  /// Throws [AssertionError]:
  /// * if [title] and [rawTitle] are both not null
  /// * if [title] and [rawTitle] are both null
  final String? title;

  /// The title, aligned to the left.
  ///
  /// ## Contract:
  /// Throws [AssertionError]:
  /// * if [title] and [rawTitle] are both not null
  /// * if [title] and [rawTitle] are both null
  final Widget? rawTitle;

  /// The actions, aligned to the right. Defaults to an empty list.
  final List<Widget> actions;

  /// Creates a [FHeader].
  ///
  /// ## Contract:
  /// Throws [AssertionError]:
  /// * if [title] and [rawTitle] are both not null
  /// * if [title] and [rawTitle] are both null
  const FHeader({
    this.style,
    this.title,
    this.rawTitle,
    this.actions = const [],
    super.key,
  }):
    assert((title != null) ^ (rawTitle != null), 'title or rawTitle must be provided, but not both.');

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle;
    final typography = context.theme.typography;

    final title = switch ((this.title, rawTitle)) {
      (final String title, _) => Text(title),
      (_, final Widget title) => title,
      _ => const Placeholder(),
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DefaultTextStyle.merge(
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: style.titleTextStyle,
            child: title,
          ),
        ),
        Row(children: actions),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('title', title))
      ..add(IterableProperty('actions', actions));
  }
}

/// [FHeader]'s style.
final class FHeaderStyle with Diagnosticable {
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The [FHeaderAction]'s style.
  final FHeaderActionStyle action;

  /// Creates a [FHeaderStyle].
  FHeaderStyle({required this.titleTextStyle, required this.action});

  /// Creates a [FHeaderStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FHeaderStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : titleTextStyle = typography.xl3.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.foreground,
        ),
        action = FHeaderActionStyle.inherit(colorScheme: colorScheme);

  /// Returns a copy of this [FHeaderStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FHeaderStyle(
  ///   titleTextStyle: ...,
  ///   action: ...,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   action: ...,
  /// );
  ///
  /// print(style.titleTextStyle == copy.titleTextStyle); // true
  /// print(style.action == copy.action); // false
  /// ```
  @useResult FHeaderStyle copyWith({
    TextStyle? titleTextStyle,
    FHeaderActionStyle? action,
  }) => FHeaderStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      action: action ?? this.action,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('action', action));
  }
}
