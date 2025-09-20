import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/dialog/dialog_content.dart';

part 'dialog.design.dart';

/// Shows a dialog.
///
/// [context] is used to look up the [Navigator] and [FDialogStyle] for the dialog. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [useRootNavigator] ensures that the root navigator displays the sheet when `true`. This is useful in the case that a
/// modal sheet needs to be displayed above all other content but the caller is inside another [Navigator].
///
/// [routeStyle] defaults to [FDialogStyle] from the closest [FTheme] ancestor.
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
  required Widget Function(BuildContext context, FDialogStyle style, Animation<double> animation) builder,
  bool useRootNavigator = false,
  FDialogRouteStyle Function(FDialogRouteStyle style)? routeStyle,
  FDialogStyle Function(FDialogStyle style)? style,
  String? barrierLabel,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  bool useSafeArea = false,
}) {
  assert(debugCheckHasMediaQuery(context));

  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
  final dialogRouteStyle = routeStyle?.call(context.theme.dialogRouteStyle) ?? context.theme.dialogRouteStyle;
  final dialogStyle = style?.call(context.theme.dialogStyle) ?? context.theme.dialogStyle;

  return navigator.push(
    FDialogRoute<T>(
      style: dialogRouteStyle,
      builder: (context, animation) => builder(context, dialogStyle, animation),
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
  /// The dialog route's style.
  final FDialogRouteStyle style;

  @override
  final bool barrierDismissible;

  @override
  final String? barrierLabel;

  /// The semantic hint text that informs users what will happen if they tap on the widget. Announced in the format of
  /// 'Double tap to ...'.
  final String? barrierOnTapHint;

  /// Creates a [FDialogRoute].
  FDialogRoute({
    required this.style,
    required Widget Function(BuildContext context, Animation<double> animation) builder,
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
         pageBuilder: (context, animation, secondaryAnimation) {
           final child = Builder(builder: (context) => builder(context, animation));
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
  ) => child;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  Curve get barrierCurve => style.motion.barrierCurve;

  @override
  Duration get transitionDuration => style.motion.entranceDuration;

  @override
  Duration get reverseTransitionDuration => style.motion.exitDuration;
}

/// [FDialogRoute]'s style.
class FDialogRouteStyle with Diagnosticable, _$FDialogRouteStyleFunctions {
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  @override
  final ImageFilter Function(double animation)? barrierFilter;

  /// Motion-related properties.
  @override
  final FDialogRouteMotion motion;

  /// Creates a [FDialogRouteStyle].
  const FDialogRouteStyle({this.barrierFilter, this.motion = const FDialogRouteMotion()});

  /// Creates a [FDialogRouteStyle] that inherits its properties.
  FDialogRouteStyle.inherit({required FColors colors})
    : this(
        barrierFilter: (v) => ColorFilter.mode(Color.lerp(Colors.transparent, colors.barrier, v)!, BlendMode.srcOver),
      );
}

/// Motion-related properties for [FDialogRoute].
class FDialogRouteMotion with Diagnosticable, _$FDialogRouteMotionFunctions {
  /// The amount of time the entrance animation takes. Defaults to 150ms.
  ///
  /// The dialog's animation and curve is managed by [FDialogMotion].
  @override
  final Duration entranceDuration;

  /// The amount of time the exit animation takes. Defaults to 150ms.
  ///
  /// The dialog's animation and curve is managed by [FDialogMotion].
  @override
  final Duration exitDuration;

  /// The curve used for the barrier's entrance and exit. Defaults to [Curves.ease].
  @override
  final Curve barrierCurve;

  /// Creates a [FDialogRouteMotion].
  const FDialogRouteMotion({
    this.entranceDuration = const Duration(milliseconds: 150),
    this.exitDuration = const Duration(milliseconds: 150),
    this.barrierCurve = Curves.ease,
  });
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
class FDialog extends StatefulWidget {
  /// The dialog's style. Defaults to [FThemeData.dialogStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dialog
  /// ```
  final FDialogStyle Function(FDialogStyle style)? style;

  /// The animation used to animate the dialog's entrance and exit. Settings this to null will disable the animation.
  ///
  /// It is the responsibility of the caller to manage & dispose the given [animation].
  ///
  /// Defaults to null.
  final Animation<double>? animation;

  /// The semantic label of the dialog used by accessibility frameworks to announce screen transitions when the dialog
  /// is opened and closed.
  ///
  /// See also:
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this value is used.
  final String? semanticsLabel;

  /// The dialog's box constraints. Defaults to `BoxConstraints(minWidth: 280, maxWidth: 560)`.
  final BoxConstraints constraints;

  /// The builder for the dialog's content.
  final Widget Function(BuildContext context, FDialogStyle style) builder;

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
    this.animation,
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
    this.animation,
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
    this.animation,
    this.semanticsLabel,
    this.constraints = const BoxConstraints(minWidth: 280, maxWidth: 560),
    super.key,
  });

  @override
  State<FDialog> createState() => _FDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('animation', animation))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _FDialogState extends State<FDialog> {
  CurvedAnimation? _curvedScale;
  CurvedAnimation? _curvedFade;
  Animation<double>? _scale;
  Animation<double>? _fade;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final style = widget.style?.call(context.theme.dialogStyle) ?? context.theme.dialogStyle;

    if (_curvedScale?.parent != widget.animation || _curvedFade?.parent != widget.animation) {
      _curvedScale?.dispose();
      _curvedFade?.dispose();

      if (widget.animation case final animation?) {
        _curvedScale = CurvedAnimation(
          parent: animation,
          curve: style.motion.expandCurve,
          reverseCurve: style.motion.collapseCurve,
        );
        _curvedFade = CurvedAnimation(
          parent: animation,
          curve: style.motion.fadeInCurve,
          reverseCurve: style.motion.fadeOutCurve,
        );
        _scale = style.motion.scaleTween.animate(_curvedScale!);
        _fade = style.motion.fadeTween.animate(_curvedFade!);
      } else {
        _curvedScale = null;
        _curvedFade = null;
        _scale = null;
        _fade = null;
      }
    }
  }

  @override
  void dispose() {
    _curvedFade?.dispose();
    _curvedScale?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = widget.style?.call(context.theme.dialogStyle) ?? context.theme.dialogStyle;
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;

    Widget dialog = DecoratedBox(decoration: style.decoration, child: widget.builder(context, style));

    // We cannot handle the transition in [FDialogRoute] because of https://github.com/flutter/flutter/issues/31706.
    if (_fade case final fade?) {
      dialog = FadeTransition(opacity: fade, child: dialog);
    }

    if (style.backgroundFilter case final filter?) {
      dialog = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: _fade == null
                  ? BackdropFilter(filter: filter(1), child: Container())
                  : AnimatedBuilder(
                      animation: _fade!,
                      builder: (_, _) => BackdropFilter(filter: filter(_fade!.value), child: Container()),
                    ),
            ),
          ),
          dialog,
        ],
      );
    }

    // We want to scale the dialog, including the background filter.
    if (_scale case final scale?) {
      dialog = ScaleTransition(scale: scale, child: dialog);
    }

    return AnimatedPadding(
      padding: MediaQuery.viewInsetsOf(context) + style.insetPadding.resolve(direction),
      duration: style.motion.insetDuration,
      curve: style.motion.insetCurve,
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
              label: widget.semanticsLabel,
              child: ConstrainedBox(constraints: widget.constraints, child: dialog),
            ),
          ),
        ),
      ),
    );
  }
}

/// [FDialog]'s style.
class FDialogStyle with Diagnosticable, _$FDialogStyleFunctions {
  /// {@macro forui.widgets.FPopoverStyle.backgroundFilter}
  ///
  /// This requires [FDialog.animation] to be non-null.
  @override
  final ImageFilter Function(double animation)? backgroundFilter;

  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The inset padding. Defaults to `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
  @override
  final EdgeInsetsGeometry insetPadding;

  /// The horizontal dialog content's style.
  @override
  final FDialogContentStyle horizontalStyle;

  /// The vertical dialog content's style.
  @override
  final FDialogContentStyle verticalStyle;

  /// Motion-related properties.
  @override
  final FDialogMotion motion;

  /// Creates a [FDialogStyle].
  FDialogStyle({
    required this.decoration,
    required this.horizontalStyle,
    required this.verticalStyle,
    this.backgroundFilter,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    this.motion = const FDialogMotion(),
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

/// Motion-related properties for [FDialog].
///
/// These fields are only used when [FDialog.animation] is non-null.
///
/// The actual animation duration is controlled by the route used to display the dialog, such as [FDialogRoute]. When
/// using [showFDialog], the duration can be customized via [FDialogRouteStyle.motion].
class FDialogMotion with Diagnosticable, _$FDialogMotionFunctions {
  /// The curve used for the dialog's expansion animation when entering. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The curve used for the dialog's collapse animation when exiting. Defaults to [Curves.easeInCubic].
  @override
  final Curve collapseCurve;

  /// The curve used for the dialog's fade-in animation when entering. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve used for the dialog's fade-out animation when exiting. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// The tween used to animate the dialog's scale in and out. Defaults to `[0.95, 1]`.
  @override
  final Animatable<double> scaleTween;

  /// The tween used to animate the dialog's fade in and out. Defaults to `[0, 1]`.
  @override
  final Animatable<double> fadeTween;

  /// The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  /// Defaults to 100ms.
  @override
  final Duration insetDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in. Defaults to [Curves.decelerate].
  @override
  final Curve insetCurve;

  /// Creates a [FDialogMotion].
  const FDialogMotion({
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeInCubic,
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
    this.scaleTween = const FImmutableTween(begin: 0.95, end: 1.0),
    this.fadeTween = const FImmutableTween(begin: 0.0, end: 1.0),
    this.insetDuration = const Duration(milliseconds: 100),
    this.insetCurve = Curves.decelerate,
  });
}
