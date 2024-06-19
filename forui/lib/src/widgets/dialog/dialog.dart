import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:meta/meta.dart';
import 'package:sugar/collection.dart';

import 'package:forui/forui.dart';

part 'dialog_content.dart';

/// The alignment of the actions in a dialog.
enum FDialogAlignment {
  /// Aligns the actions horizontally. This should be preferred on devices with wider screens, i.e. desktops.
  horizontal,
  /// Aligns the actions vertically. This should be preferred on devices with small screens, i.e. mobile devices.
  vertical,
}

/// A modal dialog that interrupts the user with important content and expects a response.
class FDialog extends StatelessWidget {
  /// The dialog's style.
  final FDialogStyle? style;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.decelerate].
  final Curve insetAnimationCurve;

  /// The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the dialog
  /// is opened and closed.
  ///
  /// See also:
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  /// The builder.
  final Widget Function(BuildContext, FDialogStyle) builder;

  /// Creates a [FDialog] with a title, subtitle, and possible actions.
  FDialog({
    required List<Widget> actions,
    this.style,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    String? semanticLabel,
    String? title,
    Widget? rawTitle,
    String? body,
    Widget? rawBody,
    FDialogAlignment alignment = FDialogAlignment.vertical,
    super.key,
  }):
    assert(title == null || rawTitle == null, 'Cannot provide both a title and a rawTitle.'),
    assert(body == null || rawBody == null, 'Cannot provide both a body and a rawBody.'),
    semanticLabel = semanticLabel ?? title,
    builder = switch (alignment) {
      FDialogAlignment.horizontal => (context, style) => FHorizontalDialogContent(
        style: style.horizontal,
        title: title,
        rawTitle: rawTitle,
        body: body,
        rawBody: rawBody,
        actions: actions,
      ),
      FDialogAlignment.vertical => (context, style) => FVerticalDialogContent(
        style: style.vertical,
        title: title,
        rawTitle: rawTitle,
        body: body,
        rawBody: rawBody,
        actions: actions,
      ),
    };

  /// Creates a [FDialog] with a custom builder.
  const FDialog.raw({
    required this.builder,
    this.style,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.semanticLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = this.style ?? theme.dialogStyle;
    final typography = theme.typography;

    return AnimatedPadding(
      padding: MediaQuery.viewInsetsOf(context) + style.insetPadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          child: DefaultTextStyle(
            style: context.theme.typography.toTextStyle(
              fontSize: typography.base,
              color: context.theme.colorScheme.foreground,
            ),
            child: Semantics(
              scopesRoute: true,
              explicitChildNodes: true,
              namesRoute: true,
              label: semanticLabel,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: style.minWidth,
                  maxWidth: style.maxWidth,
                ),
                child: DecoratedBox(
                  decoration: style.decoration,
                  child: builder(context, style),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('insetAnimationDuration', insetAnimationDuration))
      ..add(DiagnosticsProperty('insetAnimationCurve', insetAnimationCurve))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty('builder', builder));
  }
}

/// The [FDialog]'s style.
final class FDialogStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The inset padding. Defaults to `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`.
  final EdgeInsets insetPadding;

  /// The horizontal dialog content's style.
  final FDialogContentStyle horizontal;

  /// The vertical dialog content's style.
  final FDialogContentStyle vertical;

  /// The minimum width of the dialog. Defaults to 280.0.
  final double minWidth;

  /// The maximum width of the dialog. Defaults to 560.0.
  final double maxWidth;

  /// Creates a [FDialogStyle].
  const FDialogStyle({
    required this.decoration,
    required this.horizontal,
    required this.vertical,
    this.minWidth = 280.0,
    this.maxWidth = 560.0,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  });

  /// Creates a [FDialogStyle] that inherits its properties from [colorScheme].
  FDialogStyle.inherit({required FStyle style, required FColorScheme colorScheme, required FTypography typography}):
    decoration = BoxDecoration(
      borderRadius: style.borderRadius,
      color: colorScheme.background,
    ),
    insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    horizontal = FDialogContentStyle.inherit(
      colorScheme: colorScheme,
      typography: typography,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      actionPadding: 7,
    ),
    vertical = FDialogContentStyle.inherit(
      colorScheme: colorScheme,
      typography: typography,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      actionPadding: 8,
    ),
    minWidth = 280.0,
    maxWidth = 560.0;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('insetPadding', insetPadding))
      ..add(DiagnosticsProperty('horizontal', horizontal))
      ..add(DiagnosticsProperty('vertical', vertical))
      ..add(DoubleProperty('minWidth', minWidth, defaultValue: 280.0))
      ..add(DoubleProperty('maxWidth', maxWidth, defaultValue: 560.0));
  }
}
