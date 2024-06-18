import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

part 'header_action.dart';

/// A header widget.
///
/// Typically used on pages at the root of the navigation stack.
final class FHeader extends StatelessWidget {
  /// The title displayed on the left side of the [FHeader].
  final String? title;

  /// The title displayed on the left side of the [FHeader].
  final Widget? rawTitle;

  /// The actions displayed on the right side of the [FHeader].
  final List<Widget> actions;

  /// The style.
  final FHeaderStyle? style;

  /// Creates a [FHeader].
  const FHeader({
    this.title,
    this.rawTitle,
    this.actions = const [],
    this.style,
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
            style: style.title.scale(typography),
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
      ..add(StringProperty('title', title))
      ..add(IterableProperty('actions', actions))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// [FHeader]'s style.
final class FHeaderStyle with Diagnosticable {
  /// The title's style.
  final TextStyle title;

  /// The [FHeaderAction]'s style.
  final FHeaderActionStyle action;

  /// Creates a [FHeaderStyle].
  FHeaderStyle({required this.title, required this.action});

  /// Creates a [FHeaderStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FHeaderStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : title = TextStyle(
          fontSize: typography.xl3,
          fontWeight: FontWeight.w700,
          color: colorScheme.foreground,
        ),
        action = FHeaderActionStyle.inherit(colorScheme: colorScheme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('actionStyle', action));
  }
}
