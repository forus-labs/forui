import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';

/// A controller for a [FSheet].
class FSheetController {
  final AnimationController _controller;

  /// Creates a [FSheetController].
  FSheetController({required TickerProvider vsync, required FSheetStyle style})
      : _controller = Sheet.createAnimationController(vsync, style);

  /// Shows the sheet if it is hidden.
  TickerFuture show() => _controller.forward();

  /// Shows the sheet if it is hidden and hides it if it is shown.
  TickerFuture toggle() => _controller.toggle();

  /// Hides the sheet if it is shown.
  TickerFuture hide() => _controller.reverse();

  /// True if the sheet is shown.
  bool get shown => _controller.value != 0;

  /// Disposes of the controller.
  void dispose() => _controller.dispose();
}

/// A sheet that is displayed above its [child]. It is part of [FScaffold], which provides a higher-level interface and
/// should be preferred in most cases.
///
/// A sheet shows information that supplements the primary content of the app without preventing the user from
/// interacting with the app.
///
/// A closely related widget is a modal sheet, which is an alternative to a menu or a dialog and prevents the user from
/// interacting with the rest of the app.
///
/// See:
/// * https://forui.dev/docs/overlay/sheet for working examples.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [showFModalSheet] for displaying a FModalSheetRoute.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
class FSheet extends StatelessWidget {
  /// The style.
  final FSheetStyle? style;

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

  /// The controller that controls the sheet.
  final FSheetController? controller;

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

  /// The child.
  final Widget child;

  /// Creates a [FSheet].
  const FSheet({
    required this.side,
    required this.sheetBuilder,
    required this.child,
    this.style,
    this.mainAxisMaxRatio = 9 / 16,
    this.constraints = const BoxConstraints(),
    this.draggable = true,
    this.controller,
    this.anchorPoint,
    this.useSafeArea = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          Sheet(
            style: style ?? context.theme.sheetStyle,
            controller: controller?._controller,
            side: side,
            constraints: constraints,
            mainAxisMaxRatio: mainAxisMaxRatio,
            anchorPoint: anchorPoint,
            draggable: draggable,
            useSafeArea: useSafeArea,
            builder: sheetBuilder,
          ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('mainAxisMaxRatio', mainAxisMaxRatio))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('anchorPoint', anchorPoint))
      ..add(FlagProperty('draggable', value: draggable, ifTrue: 'draggable'))
      ..add(FlagProperty('useSafeArea', value: useSafeArea, ifTrue: 'useSafeArea'))
      ..add(ObjectFlagProperty.has('sheetBuilder', sheetBuilder));
  }
}
