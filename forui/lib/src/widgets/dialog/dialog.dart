import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/dialog/dialog_content.dart';

part 'dialog.style.dart';

/// A modal dialog.
///
/// A dialog interrupts the user with important content and expects a response. It is typically used with
/// [showAdaptiveDialog] and [showDialog].
///
/// See:
/// * https://forui.dev/docs/overlay/dialog for working examples.
/// * [FDialogStyle] for customizing a dialog's appearance.
class FDialog extends StatelessWidget {
  /// The dialog's style. Defaults to [FThemeData.dialogStyle].
  final FDialogStyle? style;

  /// The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the dialog
  /// is opened and closed.
  ///
  /// See also:
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this value is used.
  final String? semanticsLabel;

  /// The dialog's box constraints. Defaults to `BoxConstraints(minWidth: 280, maxWidth: 560)`.
  final BoxConstraints constraints;

  /// The builder for the dialog's content.
  final Widget Function(BuildContext, FDialogStyle) builder;

  /// Creates a [FDialog] with a title, subtitle, and possible actions.
  ///
  /// The [semanticsLabel] defaults to [title] if it is not provided.
  ///
  /// The [direction] determines the layout of the actions. It is recommended to use [Axis.vertical] on smaller devices,
  /// such as mobile phones, and [Axis.horizontal] on larger devices, such as tablets and desktops.
  ///
  /// The [Axis.vertical] layout with two possibles actions is:
  /// ```diagram
  /// |--------------------|
  /// | [title]            |
  /// |                    |
  /// | [body]             |
  /// |                    |
  /// | [first action]     |
  /// | [second action]    |
  /// |--------------------|
  /// ```
  ///
  /// The [Axis.horizontal] layout with two possibles actions is:
  /// ```diagram
  /// |--------------------------------------------|
  /// | [title]                                    |
  /// |                                            |
  /// | [body]                                     |
  /// |                                            |
  /// |             [first action] [second action] |
  /// |--------------------------------------------|
  FDialog({
    required List<Widget> actions,
    this.style,
    this.semanticsLabel,
    this.constraints = const BoxConstraints(minWidth: 280, maxWidth: 560),
    Widget? title,
    Widget? body,
    Axis direction = Axis.vertical,
    super.key,
  }) : builder = switch (direction) {
         Axis.horizontal =>
           (_, style) => HorizontalContent(style: style.horizontalStyle, title: title, body: body, actions: actions),
         Axis.vertical =>
           (_, style) => VerticalContent(style: style.verticalStyle, title: title, body: body, actions: actions),
       };

  /// Creates a adaptive [FDialog] that lays out the [actions] vertically on [FBreakpoints.sm] devices and
  /// horizontally on larger devices.
  FDialog.adaptive({
    required List<Widget> actions,
    this.style,
    this.semanticsLabel,
    this.constraints = const BoxConstraints(minWidth: 280, maxWidth: 560),
    Widget? title,
    Widget? body,
    super.key,
  }) : builder =
           ((context, style) => switch (MediaQuery.sizeOf(context).width) {
             final width when width < context.theme.breakpoints.sm => VerticalContent(
               style: style.verticalStyle,
               title: title,
               body: body,
               actions: actions,
             ),
             _ => HorizontalContent(style: style.horizontalStyle, title: title, body: body, actions: actions),
           });

  /// Creates a [FDialog] with a custom builder.
  const FDialog.raw({
    required this.builder,
    this.style,
    this.semanticsLabel,
    this.constraints = const BoxConstraints(minWidth: 280, maxWidth: 560),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = this.style ?? theme.dialogStyle;

    return AnimatedPadding(
      padding:
          MediaQuery.viewInsetsOf(context) +
          style.insetPadding.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr),
      duration: style.insetAnimationDuration,
      curve: style.insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          child: DefaultTextStyle(
            style: context.theme.typography.base.copyWith(color: theme.colors.foreground),
            child: Semantics(
              scopesRoute: true,
              explicitChildNodes: true,
              namesRoute: true,
              label: semanticsLabel,
              child: ConstrainedBox(
                constraints: constraints,
                child: DecoratedBox(decoration: style.decoration, child: builder(context, style)),
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
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// [FDialog]'s style.
final class FDialogStyle with Diagnosticable, _$FDialogStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  @override
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in.
  ///
  /// Defaults to [Curves.decelerate].
  @override
  final Curve insetAnimationCurve;

  /// The inset padding. Defaults to `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
  @override
  final EdgeInsetsGeometry insetPadding;

  /// The horizontal dialog content's style.
  @override
  final FDialogContentStyle horizontalStyle;

  /// The vertical dialog content's style.
  @override
  final FDialogContentStyle verticalStyle;

  /// Creates a [FDialogStyle].
  const FDialogStyle({
    required this.decoration,
    required this.horizontalStyle,
    required this.verticalStyle,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
  });

  /// Creates a [FDialogStyle] that inherits its properties.
  factory FDialogStyle.inherit({required FStyle style, required FColors colors, required FTypography typography}) {
    final title = typography.lg.copyWith(fontWeight: FontWeight.w600, color: colors.foreground);
    final body = typography.sm.copyWith(color: colors.mutedForeground);
    return FDialogStyle(
      decoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.background),
      horizontalStyle: FDialogContentStyle(
        titleTextStyle: title,
        bodyTextStyle: body,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        actionSpacing: 7,
      ),
      verticalStyle: FDialogContentStyle(
        titleTextStyle: title,
        bodyTextStyle: body,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        actionSpacing: 8,
      ),
    );
  }
}
