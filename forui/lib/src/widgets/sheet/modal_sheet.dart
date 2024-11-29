import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';
import 'package:forui/src/widgets/sheet/shifted_sheet.dart';

/// Shows a modal sheet that appears from the given [side].
///
/// A modal sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the
/// app.
///
/// [context] is used to look up the [Navigator] and [FSheetStyle] for the sheet. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [useRootNavigator] ensures that the root navigator displays the sheet when`true`. This is useful in the case that a
/// modal sheet needs to be displayed above all other content but the caller is inside another [Navigator].
///
/// [style] defaults to [FSheetStyle] from the closest [FTheme] ancestor.
///
/// [mainAxisMaxRatio] represents the main axis's max constraint ratio for the sheet, depending on [side].
/// Defaults to 9 / 16. The main axis is the width if [side] is [Layout.ltr] or [Layout.rtl], and the height if [side]
/// is [Layout.ttb] or [Layout.btt]. Consider setting [mainAxisMaxRatio] to null if this sheet has a scrollable child,
/// i.e. [ListView], along the main axis, to have the sheet be draggable.
///
/// [barrierLabel] defaults to [FLocalizations.barrierLabel].
///
/// [barrierColor] defaults to the default Cupertino modal barrier color on iOS & macOS, and [Colors.black54] on other
/// platforms.
///
/// Returns a `Future` that resolves to the value (if any) that was passed to [Navigator.pop] when the modal sheet was
/// closed.
///
/// See:
/// * https://forui.dev/docs/overlay/modal-sheet for working examples.
/// * [FModalSheetRoute] for more information about the various arguments.
/// * [FSheetStyle] for customizing a switch's appearance.
// TODO: reference persistent bottom sheet when implemented.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
Future<T?> showFModalSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required Layout side,
  bool useRootNavigator = false,
  FSheetStyle? style,
  double? mainAxisMaxRatio = 9 / 16,
  String? barrierLabel,
  bool barrierDismissible = true,
  Color? barrierColor,
  BoxConstraints constraints = const BoxConstraints(),
  bool draggable = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  bool useSafeArea = false,
}) {
  assert(debugCheckHasMediaQuery(context), '');

  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final localizations = FLocalizations.of(context);

  final platformBarrierColor = switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => CupertinoDynamicColor.resolve(kCupertinoModalBarrierColor, context),
    _ => Colors.black54,
  };

  return navigator.push(
    FModalSheetRoute<T>(
      style: style ?? context.theme.sheetStyle,
      side: side,
      builder: builder,
      mainAxisMaxRatio: mainAxisMaxRatio,
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      barrierOnTapHint: localizations.barrierOnTapHint(localizations.sheetLabel),
      barrierLabel: barrierLabel ?? localizations.barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? platformBarrierColor,
      constraints: constraints,
      draggable: draggable,
      settings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
    ),
  );
}

/// A route that represents a modal sheet. [showFModalSheet] should be preferred in most cases.
///
/// A modal sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the
/// app.
///
/// A closely related widget is a persistent sheet, which shows information that supplements the primary content of the
/// app without preventing the user from interacting with the app.
// TODO: reference persistent bottom sheet when implemented.
///
/// See:
/// * https://forui.dev/docs/overlay/modal-sheet for working examples.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [showFModalSheet] for displaying a FModalSheetRoute.
// TODO: reference persistent bottom sheet when implemented.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
///
/// This is based on Material's `ModalBottomSheetRoute`.
class FModalSheetRoute<T> extends PopupRoute<T> {
  /// The style.
  final FSheetStyle style;

  /// The side.
  final Layout side;

  /// Stores a list of captured [InheritedTheme]s that are wrapped around the sheet.
  ///
  /// Consider setting this attribute when the [FModalSheetRoute] is created through [Navigator.push] and its friends.
  final CapturedThemes? capturedThemes;

  /// The main axis's max constraint ratio for the sheet, depending on [side]. Defaults to 9 / 16.
  ///
  /// The main axis is the width if [side] is [Layout.ltr] or [Layout.rtl], and the height if [side] is [Layout.ttb] or
  /// [Layout.btt].
  ///
  /// Consider setting this to null if this sheet has a scrollable child, i.e. [ListView], along the main axis, to have
  /// the sheet be draggable.
  final double? mainAxisMaxRatio;

  /// The minimum and maximum sizes for a sheet. Default to being unconstrained.
  final BoxConstraints constraints;

  /// True if the sheet can be dragged up and down/left and right. Defaults is true.
  final bool draggable;

  /// The animation controller that controls the sheet's entrance and exit animations.
  ///
  /// The sheet widget will manipulate the position of this animation, it is not just a passive observer.
  final AnimationController? transitionAnimationController;

  /// The anchor point used to pick the closest sub-screen.
  ///
  /// If the anchor point sits inside one of these sub-screens, then that sub-screen is picked. If not, then the
  /// sub-screen with the closest edge to the point is used.
  ///
  /// [Offset.zero] is the top-left corner of the available screen space. For a vertically split dual-screen device,
  /// this is the top-left corner of the left screen.
  ///
  /// When this is null, [Directionality] is used:
  /// * for [TextDirection.ltr], [anchorPoint] is [Offset.zero], which will cause the top-left sub-screen to be picked.
  /// * for [TextDirection.rtl], [anchorPoint] is `Offset(double.maxFinite, 0)`, which will cause the top-right
  ///   sub-screen to be picked.
  final Offset? anchorPoint;

  /// True if a [SafeArea] should be inserted o keep the sheet away from system intrusions on the sides other than
  /// [side]. Defaults to false.
  ///
  /// If false, the sheet will extend through any system intrusions other than [side]. In addition,
  /// [MediaQuery.removePadding] is used to remove opposite [side]'s padding so that a [SafeArea] widget inside the
  /// sheet will not have any effect on the opposite side. If this is undesired, consider setting [useSafeArea] to true.
  /// Alternatively, wrap the [SafeArea] in a [MediaQuery] that restates an ambient [MediaQueryData] from outside
  /// [builder].
  ///
  /// In either case, the sheet extends all the way to the [side] of the screen, including any system intrusions.
  final bool useSafeArea;

  /// The semantic hint text that informs users what will happen if they tap on the widget. Announced in the format of
  /// 'Double tap to ...'.
  ///
  /// If the field is null, the default hint will be used, which results in an announcement of 'Double tap to activate'.
  ///
  /// See:
  ///  * [barrierDismissible], which controls the behavior of the barrier when tapped.
  ///  * [ModalBarrier], which uses this field as onTapHint when it has an onTap action.
  final String? barrierOnTapHint;

  /// A builder for the contents of the sheet.
  final WidgetBuilder builder;

  @override
  final String? barrierLabel;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  final ValueNotifier<EdgeInsets> _clipDetailsNotifier = ValueNotifier<EdgeInsets>(EdgeInsets.zero);

  AnimationController? _animationController;

  /// Creates a [FModalSheetRoute].
  FModalSheetRoute({
    required this.style,
    required this.side,
    required this.builder,
    required this.mainAxisMaxRatio,
    this.capturedThemes,
    this.barrierOnTapHint,
    this.barrierLabel,
    this.barrierDismissible = true,
    this.barrierColor = Colors.black54,
    this.constraints = const BoxConstraints(),
    this.draggable = true,
    this.transitionAnimationController,
    this.anchorPoint,
    this.useSafeArea = false,
    super.settings,
  });

  @override
  AnimationController createAnimationController() {
    if (transitionAnimationController != null) {
      _animationController = transitionAnimationController;
      willDisposeAnimationController = false;
    } else {
      _animationController = Sheet.createAnimationController(navigator!, style);
    }

    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final content = DisplayFeatureSubScreen(
      anchorPoint: anchorPoint,
      child: Builder(
        builder: (context) => _ModalSheet<T>(
          route: this,
          side: side,
          style: style,
          constraints: constraints,
          mainAxisMaxRatio: mainAxisMaxRatio,
          draggable: draggable,
        ),
      ),
    );

    final sheet = switch ((side, useSafeArea)) {
      (Layout.ttb, true) => SafeArea(top: false, child: content),
      (Layout.btt, true) => SafeArea(bottom: false, child: content),
      (Layout.ltr, true) => SafeArea(left: false, child: content),
      (Layout.rtl, true) => SafeArea(right: false, child: content),
      (Layout.ttb, false) => MediaQuery.removePadding(context: context, removeBottom: true, child: content),
      (Layout.btt, false) => MediaQuery.removePadding(context: context, removeTop: true, child: content),
      (Layout.ltr, false) => MediaQuery.removePadding(context: context, removeRight: true, child: content),
      (Layout.rtl, false) => MediaQuery.removePadding(context: context, removeLeft: true, child: content),
    };

    return capturedThemes?.wrap(sheet) ?? sheet;
  }

  @override
  Widget buildModalBarrier() {
    if (barrierColor.alpha != 0 && !offstage) {
      // changedInternalState is called if barrierColor or offstage updates
      final color = animation!.drive(
        ColorTween(
          begin: barrierColor.withOpacity(0.0),
          end: barrierColor, // changedInternalState is called if barrierColor updates
        ).chain(CurveTween(curve: barrierCurve)), // changedInternalState is called if barrierCurve updates
      );
      return AnimatedModalBarrier(
        color: color,
        dismissible: barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel: barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    } else {
      return ModalBarrier(
        dismissible: barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel: barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    }
  }

  /// Updates the details regarding how the [SemanticsNode.rect] (focus) of the barrier for this [FModalSheetRoute]
  /// should be clipped.
  ///
  /// Returns true if the clipDetails did change and false otherwise.
  bool _didChangeBarrierSemanticsClip(EdgeInsets details) {
    if (_clipDetailsNotifier.value == details) {
      return false;
    }

    _clipDetailsNotifier.value = details;
    return true;
  }

  @override
  void dispose() {
    _clipDetailsNotifier.dispose();
    super.dispose();
  }

  @override
  Duration get transitionDuration => style.enterDuration;

  @override
  Duration get reverseTransitionDuration => style.exitDuration;
}

class _ModalSheet<T> extends StatefulWidget {
  final FModalSheetRoute<T> route;
  final Layout side;
  final FSheetStyle style;
  final double? mainAxisMaxRatio;
  final BoxConstraints constraints;
  final bool draggable;

  const _ModalSheet({
    required this.route,
    required this.side,
    required this.style,
    required this.mainAxisMaxRatio,
    required this.constraints,
    required this.draggable,
    super.key,
  });

  @override
  _ModalSheetState<T> createState() => _ModalSheetState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('route', route))
      ..add(EnumProperty('side', side))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('mainAxisMaxRatio', mainAxisMaxRatio))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(FlagProperty('draggable', value: draggable, ifTrue: 'draggable'));
  }
}

class _ModalSheetState<T> extends State<_ModalSheet<T>> {
  static const _cubic = Cubic(0.0, 0.0, 0.2, 1.0);

  ParametricCurve<double> _curve = _cubic;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context), '');

    return AnimatedBuilder(
      animation: widget.route.animation!,
      builder: (context, child) => Semantics(
        scopesRoute: true,
        namesRoute: true,
        label: switch (defaultTargetPlatform) {
          TargetPlatform.iOS || TargetPlatform.macOS => null,
          _ => FLocalizations.of(context).dialogLabel,
        },
        explicitChildNodes: true,
        child: ClipRect(
          child: ShiftedSheet(
            side: widget.side,
            onChange: (size) => widget.route._didChangeBarrierSemanticsClip(
              switch (widget.side) {
                Layout.ttb => EdgeInsets.fromLTRB(0, size.height, 0, 0),
                Layout.btt => EdgeInsets.fromLTRB(0, 0, 0, size.height),
                Layout.ltr => EdgeInsets.fromLTRB(size.width, 0, 0, 0),
                Layout.rtl => EdgeInsets.fromLTRB(0, 0, size.width, 0),
              },
            ),
            value: _curve.transform(widget.route.animation!.value),
            mainAxisMaxRatio: widget.mainAxisMaxRatio,
            child: child,
          ),
        ),
      ),
      child: Sheet(
        controller: widget.route._animationController,
        layout: widget.side,
        style: widget.style,
        constraints: widget.constraints,
        draggable: widget.draggable,
        builder: widget.route.builder,
        // Allow the bottom sheet to track the user's finger accurately.
        onDragStart: (details) => _curve = Curves.linear,
        // Allow the sheet to animate smoothly from its current position.
        onDragEnd: (details, {required closing}) => _curve = Split(widget.route.animation!.value, endCurve: _cubic),
        onClosing: () {
          if (widget.route.isCurrent) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}