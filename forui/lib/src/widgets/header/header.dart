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
  final String title;

  /// The actions displayed on the right side of the [FHeader].
  final List<Widget> actions;

  /// The style.
  final FHeaderStyle? style;

  /// Creates a [FHeader].
  const FHeader({
    required this.title,
    this.actions = const [],
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle;
    final font = context.theme.font;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: style.title.withFont(font),
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

  /// Creates a [FHeaderStyle] that inherits its properties from the given [FColorScheme] and [FFont].
  FHeaderStyle.inherit({required FColorScheme colorScheme, required FFont font})
      : title = TextStyle(
          fontSize: font.xl3,
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
