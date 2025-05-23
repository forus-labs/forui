import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A toast in a sonner.
///
/// See:
/// * https://forui.dev/docs/overlay/sonner for working examples.
/// * [showFSonner] for displaying a toast in a sonner.
/// * [FSonnerStyle] for customizing a sonner's appearance.
/// * [FSonnerToastStyle] for customizing a sonner toast's appearance.
class FSonnerToast extends StatelessWidget {
  /// The toast's style.
  final FSonnerToastStyle? style;

  /// An optional icon displayed at the start.
  final Widget? icon;

  /// The toast's title. Defaults to a maximum of 100 lines. Set [Text.maxLines] to change this.
  final Widget title;

  /// The toast's description. Defaults to a maximum of 100 lines. Set [Text.maxLines] to change this.
  final Widget? description;

  /// An optional widget displayed at the end.
  final Widget? suffix;

  /// A callback that is called when the toast is dismissed. Displays an "X" button at the top right corner of the
  /// toast if provided.
  final VoidCallback? onDismiss;

  /// Creates a [FSonnerToast].
  const FSonnerToast({
    required this.title,
    this.style,
    this.icon,
    this.description,
    this.suffix,
    this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.sonnerStyle.toastStyle;
    return Stack(
      children: [
        DecoratedBox(
          decoration: style.decoration,
          child: Padding(
            padding: style.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon case final icon?) ...[
                  IconTheme(data: style.iconStyle, child: icon),
                  SizedBox(width: style.iconSpacing),
                ],
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: style.titleSpacing,
                    children: [
                      DefaultTextStyle(style: style.titleTextStyle, maxLines: 100, child: title),
                      if (description case final description?)
                        DefaultTextStyle(style: style.descriptionTextStyle, maxLines: 100, child: description),
                    ],
                  ),
                ),
                if (suffix case final suffix?) ...[SizedBox(width: style.suffixSpacing), suffix],
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss));
  }
}
