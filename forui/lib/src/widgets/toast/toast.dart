import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A toast.
///
/// See:
/// * https://forui.dev/docs/overlay/toast for working examples.
/// * [showFToast] for displaying a toast.
/// * [FToasterStyle] for customizing a toaster's appearance.
/// * [FToastStyle] for customizing a toast's appearance.
class FToast extends StatelessWidget {
  /// The toast's style.
  final FToastStyle? style;

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

  /// Creates a [FToast].
  const FToast({required this.title, this.style, this.icon, this.description, this.suffix, this.onDismiss, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.toasterStyle.toastStyle;
    Widget toast = DecoratedBox(
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
    );

    if (style.backgroundFilter case final background?) {
      toast = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(filter: background, child: Container()),
            ),
          ),
          toast,
        ],
      );
    }

    return toast;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss));
  }
}
