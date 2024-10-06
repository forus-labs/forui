import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/dialog/dialog_content.dart';

/// A modal dialog.
///
/// A dialog interrupts the user with important content and expects a response. It is typically used with
/// [showAdaptiveDialog] and [showDialog].
///
/// See:
/// * https://forui.dev/docs/dialog for working examples.
/// * [FDialogStyle] for customizing a dialog's appearance.
class FDialog extends StatelessWidget {
  static const _defaultDuration = Duration(milliseconds: 100);

  /// The dialog's style. Defaults to [FThemeData.dialogStyle].
  final FDialogStyle? style;

  /// The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in.
  ///
  /// Defaults to [Curves.decelerate].
  final Curve insetAnimationCurve;

  /// The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the dialog
  /// is opened and closed.
  ///
  /// See also:
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this value is used.
  final String? semanticLabel;

  /// The builder for the dialog's content.
  final Widget Function(BuildContext, FDialogStyle) builder;

  /// Creates a [FDialog] with a title, subtitle, and possible actions.
  ///
  /// The [semanticLabel] defaults to [title] if it is not provided.
  ///
  /// The [direction] determines the layout of the actions. It is recommended to use [Axis.vertical] on smaller devices,
  /// such as mobile phones, and [Axis.horizontal] on larger devices, such as tablets and desktops.
  ///
  /// The [Axis.vertical] layout with two possibles actions is:
  /// ```
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
  /// ```
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
    this.insetAnimationDuration = _defaultDuration,
    this.insetAnimationCurve = Curves.decelerate,
    this.semanticLabel,
    Widget? title,
    Widget? body,
    Axis direction = Axis.vertical,
    super.key,
  }) : builder = switch (direction) {
          Axis.horizontal => (context, style) => HorizontalContent(
                style: style.horizontal,
                title: title,
                body: body,
                actions: actions,
              ),
          Axis.vertical => (context, style) => VerticalContent(
                style: style.vertical,
                title: title,
                body: body,
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
    final typography = theme.typography;
    final style = this.style ?? theme.dialogStyle;

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
            style: typography.base.copyWith(color: theme.colorScheme.foreground),
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
      ..add(DiagnosticsProperty('insetAnimationDuration', insetAnimationDuration, defaultValue: _defaultDuration))
      ..add(DiagnosticsProperty('insetAnimationCurve', insetAnimationCurve, defaultValue: Curves.decelerate))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty('builder', builder));
  }
}

/// [FDialog]'s style.
final class FDialogStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The inset padding. Defaults to `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
  final EdgeInsets insetPadding;

  /// The horizontal dialog content's style.
  final FDialogContentStyle horizontal;

  /// The vertical dialog content's style.
  final FDialogContentStyle vertical;

  /// The minimum width of the dialog. Defaults to 280.
  final double minWidth;

  /// The maximum width of the dialog. Defaults to 560.
  final double maxWidth;

  /// Creates a [FDialogStyle].
  const FDialogStyle({
    required this.decoration,
    required this.horizontal,
    required this.vertical,
    this.minWidth = 280.0,
    this.maxWidth = 560.0,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
  });

  /// Creates a [FDialogStyle] that inherits its properties from the given [style], [colorScheme], and [typography].
  FDialogStyle.inherit({required FStyle style, required FStateColorScheme colorScheme, required FTypography typography})
      : decoration = BoxDecoration(
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
        minWidth = 280,
        maxWidth = 560;

  /// Returns a copy of this [FButtonCustomStyle] with the given properties replaced.
  @useResult
  FDialogStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsets? insetPadding,
    FDialogContentStyle? horizontal,
    FDialogContentStyle? vertical,
    double? minWidth,
    double? maxWidth,
  }) =>
      FDialogStyle(
        decoration: decoration ?? this.decoration,
        insetPadding: insetPadding ?? this.insetPadding,
        horizontal: horizontal ?? this.horizontal,
        vertical: vertical ?? this.vertical,
        minWidth: minWidth ?? this.minWidth,
        maxWidth: maxWidth ?? this.maxWidth,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('insetPadding', insetPadding))
      ..add(DiagnosticsProperty('horizontal', horizontal))
      ..add(DiagnosticsProperty('vertical', vertical))
      ..add(DoubleProperty('minWidth', minWidth, defaultValue: 280))
      ..add(DoubleProperty('maxWidth', maxWidth, defaultValue: 560));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDialogStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          insetPadding == other.insetPadding &&
          horizontal == other.horizontal &&
          vertical == other.vertical &&
          minWidth == other.minWidth &&
          maxWidth == other.maxWidth;

  @override
  int get hashCode =>
      decoration.hashCode ^
      insetPadding.hashCode ^
      horizontal.hashCode ^
      vertical.hashCode ^
      minWidth.hashCode ^
      maxWidth.hashCode;
}
