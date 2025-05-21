import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';

/// Shows a modal sheet that appears from the given [side].
///
/// A modal sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the
/// app.
///
/// [context] is used to look up the [Navigator] and [FSheetStyle] for the sheet. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [useRootNavigator] ensures that the root navigator displays the sheet when `true`. This is useful in the case that a
/// modal sheet needs to be displayed above all other content but the caller is inside another [Navigator].
///
/// [style] defaults to [FSheetStyle] from the closest [FTheme] ancestor.
///
/// [mainAxisMaxRatio] represents the main axis's max constraint ratio for the sheet, depending on [side].
/// Defaults to 9 / 16. The main axis is the width if [side] is [FLayout.ltr] or [FLayout.rtl], and the height if [side]
/// is [FLayout.ttb] or [FLayout.btt]. Consider setting [mainAxisMaxRatio] to null if this sheet has a scrollable child,
/// i.e. [ListView], along the main axis, to have the sheet be draggable.
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
/// dart run forui style create sheet
/// ```
///
/// See:
/// * https://forui.dev/docs/overlay/sheet for working examples.
/// * [showFPersistentSheet] for displaying a sheet above the current widget.
/// * [FModalSheetRoute] for more information about the various arguments.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
Future<T?> showFSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required FLayout side,
  bool useRootNavigator = false,
  FSheetStyle? style,
  double? mainAxisMaxRatio = 9 / 16,
  String? barrierLabel,
  bool barrierDismissible = true,
  BoxConstraints constraints = const BoxConstraints(),
  bool draggable = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  bool useSafeArea = false,
}) {
  assert(debugCheckHasMediaQuery(context), '');

  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

  return navigator.push(
    FModalSheetRoute<T>(
      style: style ?? context.theme.sheetStyle,
      side: side,
      builder: builder,
      mainAxisMaxRatio: mainAxisMaxRatio,
      capturedThemes: InheritedTheme.capture(
        from: context,
        to: navigator.context,
      ),
      barrierOnTapHint: localizations.barrierOnTapHint(
        localizations.sheetSemanticsLabel,
      ),
      barrierLabel: barrierLabel ?? localizations.barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: (style ?? context.theme.sheetStyle).barrierColor,
      constraints: constraints,
      draggable: draggable,
      settings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
    ),
  );
}

/// A route that represents a modal sheet. [showFSheet] should be preferred in most cases.
///
/// A modal sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the
/// app.
///
/// A closely related widget is a persistent sheet, which shows information that supplements the primary content of the
/// app without preventing the user from interacting with the app.
///
/// See:
/// * https://forui.dev/docs/overlay/sheet for working examples.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [showFSheet] for displaying a FModalSheetRoute.
/// * [showFPersistentSheet] for displaying a sheet above the current widget.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
///
/// This is based on Material's `ModalBottomSheetRoute`.
class FModalSheetRoute<T> extends PopupRoute<T> {
  /// The style.
  final FSheetStyle style;

  /// The side.
  final FLayout side;

  /// Stores a list of captured [InheritedTheme]s that are wrapped around the sheet.
  ///
  /// Consider setting this attribute when the [FModalSheetRoute] is created through [Navigator.push] and its friends.
  final CapturedThemes? capturedThemes;

  /// The main axis's max constraint ratio for the sheet, depending on [side]. Defaults to 9 / 16.
  ///
  /// The main axis is the width if [side] is [FLayout.ltr] or [FLayout.rtl], and the height if [side] is [FLayout.ttb] or
  /// [FLayout.btt].
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

  final ValueNotifier<EdgeInsets> _clipDetailsNotifier =
      ValueNotifier<EdgeInsets>(EdgeInsets.zero);

  AnimationController? _animationController;

  /// Creates a [FModalSheetRoute].
  FModalSheetRoute({
    required this.style,
    required this.side,
    required this.barrierColor,
    required this.builder,
    this.mainAxisMaxRatio = 9 / 16,
    this.capturedThemes,
    this.barrierOnTapHint,
    this.barrierLabel,
    this.barrierDismissible = true,
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
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final sheet = Sheet(
      controller: controller,
      animation: animation,
      side: side,
      style: style,
      constraints: constraints,
      mainAxisMaxRatio: mainAxisMaxRatio,
      anchorPoint: anchorPoint,
      draggable: draggable,
      useSafeArea: useSafeArea,
      builder: builder,
      onChange:
          (size) => _didChangeBarrierSemanticsClip(switch (side) {
            FLayout.ttb => EdgeInsets.fromLTRB(0, size.height, 0, 0),
            FLayout.btt => EdgeInsets.fromLTRB(0, 0, 0, size.height),
            FLayout.ltr => EdgeInsets.fromLTRB(size.width, 0, 0, 0),
            FLayout.rtl => EdgeInsets.fromLTRB(0, 0, size.width, 0),
          }),
      onClosing: () {
        if (isCurrent) {
          Navigator.pop(context);
        }
      },
    );

    return capturedThemes?.wrap(sheet) ?? sheet;
  }

  @override
  Widget buildModalBarrier() {
    if (barrierColor.a != 0 && !offstage) {
      return AnimatedModalBarrier(
        color: animation!.drive(
          ColorTween(
            begin: barrierColor.withValues(alpha: 0.0),
            end:
                barrierColor, // changedInternalState is called if barrierColor updates
          ).chain(
            CurveTween(curve: barrierCurve),
          ), // changedInternalState is called if barrierCurve updates
        ),
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    } else {
      return ModalBarrier(
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
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
