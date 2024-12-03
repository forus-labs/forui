import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';
import 'package:forui/src/widgets/sheet/shifted_sheet.dart';

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
class FSheet extends StatelessWidget {
  /// The style.
  final FSheetStyle style;

  /// The side.
  final Layout side;

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
  final AnimationController? controller;

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
  /// [sheetBuilder].
  ///
  /// In either case, the sheet extends all the way to the [side] of the screen, including any system intrusions.
  final bool useSafeArea;

  /// A builder for the contents of the sheet.
  final WidgetBuilder sheetBuilder;

  final Widget child;

  /// Creates a [FSheet].
  const FSheet({
    required this.style,
    required this.side,
    required this.sheetBuilder,
    required this.mainAxisMaxRatio,
    required this.child,
    this.constraints = const BoxConstraints(),
    this.draggable = true,
    this.controller,
    this.anchorPoint,
    this.useSafeArea = false,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final content = DisplayFeatureSubScreen(
      anchorPoint: anchorPoint,
      child: Builder(
        builder: (context) => Sheet(
          style: style,
          controller: controller,
          side: side,
          constraints: constraints,
          mainAxisMaxRatio: mainAxisMaxRatio,
          draggable: draggable,
          builder: sheetBuilder,
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

    return Stack(
      children: [
        child,
        sheet,
      ],
    );
  }
}
