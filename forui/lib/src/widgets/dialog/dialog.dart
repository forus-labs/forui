import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/dialog/dialog_content.dart';

part 'dialog.style.dart';

/// Shows a dialog.
///
/// [context] is used to look up the [Navigator] and [FDialogStyle] for the dialog. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [useRootNavigator] ensures that the root navigator displays the sheet when `true`. This is useful in the case that a
/// modal sheet needs to be displayed above all other content but the caller is inside another [Navigator].
///
/// [style] defaults to [FDialogStyle] from the closest [FTheme] ancestor.
///
/// [barrierLabel] defaults to [FLocalizations.barrierLabel].
///
/// Returns a `Future` that resolves to the value (if any) that was passed to [Navigator.pop] when the modal sheet was
/// closed.
///
/// ## CLI
/// To generate and customize this widget's style:
///
/// ```shell
/// dart run forui style create dialog
/// ```
///
/// See:
/// * https://forui.dev/docs/overlay/dialog for working examples.
/// * [showAdaptiveDialog] for displaying a dialog with adaptive transitions depending on the platform.
/// * [FDialogStyle] for customizing a switch's appearance.
Future<T?> showFDialog<T>({
  required BuildContext context,
  required Widget Function(BuildContext, FDialogStyle) builder,
  bool useRootNavigator = false,
  FDialogStyle? style,
  String? barrierLabel,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  bool useSafeArea = false,
}) {
  assert(debugCheckHasMediaQuery(context), '');

  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
  style ??= context.theme.dialogStyle;

  return navigator.push(
    FDialogRoute<T>(
      style: style,
      builder: (context) => builder(context, style!),
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel ?? localizations.barrierLabel,
      barrierOnTapHint: localizations.barrierOnTapHint(localizations.dialogSemanticsLabel),
      settings: routeSettings,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
    ),
  );
}

/// A route that shows a dialog popup.
///
/// [showFDialog] should be preferred in most cases.
class FDialogRoute<T> extends RawDialogRoute<T> {
  /// The dialog's style.
  final FDialogStyle style;

  @override
  final bool barrierDismissible;

  @override
  final String? barrierLabel;

  /// The semantic hint text that informs users what will happen if they tap on the widget. Announced in the format of
  /// 'Double tap to ...'.
  final String? barrierOnTapHint;

  CurvedAnimation? _fade;
  CurvedAnimation? _scale;

  /// Creates a [FDialogRoute].
  FDialogRoute({
    required this.style,
    required WidgetBuilder builder,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.barrierOnTapHint,
    CapturedThemes? capturedThemes,
    bool useSafeArea = true,
    super.settings,
    super.requestFocus,
    super.anchorPoint,
    super.traversalEdgeBehavior,
    super.directionalTraversalEdgeBehavior,
  }) : super(
         pageBuilder: (buildContext, animation, secondaryAnimation) {
           final child = Builder(builder: builder);
           Widget dialog = capturedThemes?.wrap(child) ?? child;
           if (useSafeArea) {
             dialog = SafeArea(child: dialog);
           }
           return dialog;
         },
       );

  @override
  Widget buildModalBarrier() {
    if (style.barrierFilter != null && !offstage) {
      return Builder(
        builder: (context) => FAnimatedModalBarrier(
          animation: animation!.drive(CurveTween(curve: barrierCurve)),
          filter: style.barrierFilter,
          onDismiss: barrierDismissible ? () => Navigator.pop(context) : null,
          semanticsLabel: barrierLabel,
          // changedInternalState is called if barrierLabel updates
          barrierSemanticsDismissible: semanticsDismissible,
          semanticsOnTapHint: barrierOnTapHint,
        ),
      );
    } else {
      return Builder(
        builder: (context) => FModalBarrier(
          filter: null,
          onDismiss: barrierDismissible ? () => Navigator.pop(context) : null,
          semanticsLabel: barrierLabel,
          // changedInternalState is called if barrierLabel updates
          barrierSemanticsDismissible: semanticsDismissible,
          semanticsOnTapHint: barrierOnTapHint,
        ),
      );
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (_fade?.parent != animation || _scale?.parent != animation) {
      _fade?.dispose();
      _scale?.dispose();
      _fade = CurvedAnimation(parent: animation, curve: style.entranceCurve, reverseCurve: style.exitCurve);
      _scale = CurvedAnimation(parent: animation, curve: style.entranceCurve, reverseCurve: style.exitCurve);
    }

    final fade = _fade!.drive(style.fadeTween);
    final scale = _scale!.drive(style.scaleTween);

    return FadeTransition(
      opacity: fade,
      child: ScaleTransition(
        scale: scale,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _fade?.dispose();
    _scale?.dispose();
    super.dispose();
  }

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  Duration get transitionDuration => style.entranceExitDuration;
}

/// A modal dialog.
///
/// A dialog interrupts the user with important content and expects a response.
///
/// Consider using with
/// * [showFDialog] if you want to show a dialog with consistent Shadcn/ui-like transitions across platforms.
/// * [showAdaptiveDialog] if you want to show a dialog with transitions.
///
/// See:
/// * https://forui.dev/docs/overlay/dialog for working examples.
/// * [FDialogStyle] for customizing a dialog's appearance.
class FDialog extends StatelessWidget {
  /// The dialog's style. Defaults to [FThemeData.dialogStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dialog
  /// ```
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
         Axis.horizontal => (_, style) => HorizontalContent(
           style: style.horizontalStyle,
           title: title,
           body: body,
           actions: actions,
         ),
         Axis.vertical => (_, style) => VerticalContent(
           style: style.verticalStyle,
           title: title,
           body: body,
           actions: actions,
         ),
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
  }) : builder = ((context, style) => switch (MediaQuery.sizeOf(context).width) {
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
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;

    Widget dialog = DecoratedBox(decoration: style.decoration, child: builder(context, style));
    if (style.backgroundFilter case final filter?) {
      dialog = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(child: BackdropFilter(filter: filter, child: Container())),
          ),
          dialog,
        ],
      );
    }

    return AnimatedPadding(
      padding: MediaQuery.viewInsetsOf(context) + style.insetPadding.resolve(direction),
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
              child: ConstrainedBox(constraints: constraints, child: dialog),
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
class FDialogStyle with Diagnosticable, _$FDialogStyleFunctions {
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  ///
  /// This is only supported by [showFDialog].
  ///
  /// ## Why isn't the [barrierFilter] being applied?
  /// Make sure you are passing the [FDialogStyle] to the [showFDialog] method instead of the [FDialog].
  @override
  final ImageFilter Function(double animation)? barrierFilter;

  /// The dialog's background filter.
  @override
  final ImageFilter? backgroundFilter;

  /// The dialog's entrance/exit animation duration. Defaults to 200ms.
  ///
  /// This is only supported by [showFDialog].
  @override
  final Duration entranceExitDuration;

  /// The dialog's entrance animation curve. Defaults to [Curves.easeOutQuad].
  ///
  /// This is only supported by [showFDialog].
  @override
  final Curve entranceCurve;

  /// The dialog's entrance animation curve. Defaults to [Curves.easeInQuad].
  ///
  /// This is only supported by [showFDialog].
  @override
  final Curve exitCurve;

  /// The tween used to animate the dialog's fade in and out. Defaults to `[0, 1]`.
  ///
  /// This is only supported by [showFDialog].
  @override
  final Tween<double> fadeTween;

  /// The tween used to animate the dialog's scale in and out. Defaults to `[0.95, 1]`.
  ///
  /// This is only supported by [showFDialog].
  @override
  final Tween<double> scaleTween;

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
  FDialogStyle({
    required this.decoration,
    required this.horizontalStyle,
    required this.verticalStyle,
    this.barrierFilter,
    this.entranceExitDuration = const Duration(milliseconds: 200),
    this.entranceCurve = Curves.easeOutQuad,
    this.exitCurve = Curves.easeInQuad,
    this.backgroundFilter,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    Tween<double>? fadeTween,
    Tween<double>? scaleTween,
  }) : fadeTween = fadeTween ?? Tween<double>(begin: 0, end: 1),
       scaleTween = scaleTween ?? Tween<double>(begin: 0.95, end: 1);

  /// Creates a [FDialogStyle] that inherits its properties.
  factory FDialogStyle.inherit({required FStyle style, required FColors colors, required FTypography typography}) {
    final title = typography.lg.copyWith(fontWeight: FontWeight.w600, color: colors.foreground);
    final body = typography.sm.copyWith(color: colors.mutedForeground);
    return FDialogStyle(
      barrierFilter: (v) => ColorFilter.mode(Color.lerp(Colors.transparent, colors.barrier, v)!, BlendMode.srcOver),
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
