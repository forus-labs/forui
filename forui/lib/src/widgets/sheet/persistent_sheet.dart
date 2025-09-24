import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';

part 'persistent_sheet.design.dart';

/// Shows a persistent sheet that appears above the current widget. It should have a [FSheets] or [FScaffold] ancestor.
///
/// The returned [FPersistentSheetController] should always be disposed after use. Not doing so can lead to the sheets
/// accumulating over time, which can negatively impact performance.
///
/// A closely related widget is a modal sheet which prevents the user from interacting with the rest of the app.
///
/// [context] is used to look up the [Navigator] and [FSheetStyle] for the sheet. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [style] defaults to [FSheetStyle] from the closest [FTheme] ancestor.
///
/// [mainAxisMaxRatio] represents the main axis's max constraint ratio for the sheet, depending on [side].
/// Defaults to 9 / 16. The main axis is the width if [side] is [FLayout.ltr] or [FLayout.rtl], and the height if [side]
/// is [FLayout.ttb] or [FLayout.btt]. Consider setting [mainAxisMaxRatio] to null if this sheet has a scrollable child,
/// i.e. [ListView], along the main axis, to have the sheet be draggable.
///
/// [anchorPoint] is used to pick the closest sub-screen.
///
/// [keepAliveOffstage] determines whether the sheet should be kept alive even when it is offstage. Setting it to true
/// retains the sheet's state even when it is not visible. Defaults to false. Keeping multiple sheets alive even when
/// offstage can negatively impact performance.
///
/// [onClosing] is called when the sheet begins to close.
///
/// [key] is used to identify the sheet. If a key is not provided, a random key will be generated. All sheets in a
/// [FScaffold]/[FSheets] must have unique keys.
///
/// ## Contract
/// Throws [FlutterError] if:
///   * the [context] does not contain a [FSheets] or [FScaffold] ancestor.
///   * a sheet with the same [key] already exists.
///
/// ## CLI
/// To generate and customize this widget's style:
///
/// ```shell
/// dart run forui style create sheet
/// ```
///
/// See:
/// * https://forui.dev/docs/overlay/persistent-sheet for working examples.
/// * [showFSheet] for showing a sheet in a modal that prevents the user from interacting with the rest of the app.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
@useResult
FPersistentSheetController showFPersistentSheet({
  required BuildContext context,
  required FLayout side,
  required Widget Function(BuildContext context, FPersistentSheetController controller) builder,
  FPersistentSheetStyle Function(FPersistentSheetStyle)? style,
  double? mainAxisMaxRatio = 9 / 16,
  BoxConstraints constraints = const BoxConstraints(),
  bool draggable = true,
  Offset? anchorPoint,
  bool useSafeArea = false,
  bool keepAliveOffstage = false,
  VoidCallback? onClosing,
  Key? key,
}) {
  final state = context.findAncestorStateOfType<FSheetsState>();
  if (state == null) {
    throw FlutterError.fromParts([
      ErrorSummary('showFSheet(...) called with a context that does not contain a FSheets/FScaffold.'),
      ErrorDescription(
        'No FSheets/FScaffold ancestor could be found starting from the context that was passed to FSheets/FScaffold.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that whose build function '
        'actually creates the FSheets/FScaffold widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the FSheets/FScaffold.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  key ??= ValueKey(Random().nextInt(2147483647));
  final sheetStyle = style?.call(context.theme.persistentSheetStyle) ?? context.theme.persistentSheetStyle;

  final controller = FPersistentSheetController._(
    vsync: state,
    style: sheetStyle,
    key: key,
    keepAliveOffstage: keepAliveOffstage,
    setState: (function) {
      if (state.mounted) {
        // ignore: invalid_use_of_protected_member
        state.setState(function);
      }
    },
    onDispose: () => state._remove(key!),
  );

  try {
    state._add(
      controller,
      Sheet(
        controller: controller._controller,
        animation: null,
        style: sheetStyle,
        side: side,
        mainAxisMaxRatio: mainAxisMaxRatio,
        constraints: constraints,
        draggable: draggable,
        anchorPoint: anchorPoint,
        useSafeArea: useSafeArea,
        builder: (context) => builder(context, controller),
        onChange: null,
        onClosing: onClosing,
      ),
    );
  } catch (_) {
    controller.dispose();
    rethrow;
  }

  controller.show();

  return controller;
}

/// A sheet controller.
class FPersistentSheetController {
  /// The sheet's key.
  final Key key;

  /// True if the sheet to which this controller is attached should be kept alive even when it is offstage. Setting it
  /// to true retains the sheet's state even when it is not visible. Defaults to false. Keeping multiple sheets alive
  /// even when offstage can negatively impact performance.
  final bool keepAliveOffstage;

  /// Marks the sheet as needing to be rebuilt.
  final StateSetter setState;

  final AnimationController _controller;
  final VoidCallback _onDispose;

  FPersistentSheetController._({
    required TickerProvider vsync,
    required FSheetStyle style,
    required VoidCallback onDispose,
    required this.key,
    required this.keepAliveOffstage,
    required this.setState,
  }) : _controller = Sheet.createAnimationController(vsync, style),
       _onDispose = onDispose {
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectCreated(
        library: 'package:flutter/forui.dart',
        className: '$FPersistentSheetController',
        object: this,
      );
    }
    _controller.addStatusListener((status) => setState(() {}));
  }

  /// Shows the sheet if it is hidden.
  TickerFuture show() => _controller.forward();

  /// Shows the sheet if it is hidden and hides it if it is shown.
  TickerFuture toggle() => _controller.toggle();

  /// Hides the sheet if it is shown.
  TickerFuture hide() => _controller.reverse();

  /// The current status.
  ///
  /// [AnimationStatus.dismissed] - The sheet is hidden.
  /// [AnimationStatus.forward] - The sheet is transitioning from hidden to shown.
  /// [AnimationStatus.completed] - The sheet is shown.
  /// [AnimationStatus.reverse] - The sheet is transitioning from shown to hidden.
  AnimationStatus get status => _controller.status;

  /// Disposes of the controller.
  void dispose() {
    _controller.dispose();
    _onDispose();
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectDisposed(object: this);
    }
  }
}

/// Sheets that are displayed above its [child]. It is part of [FScaffold], which should be preferred in most cases.
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
/// * [showFPersistentSheet] for for displaying a sheet above the current widget.
/// * [showFSheet] for displaying a modal sheet.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
class FSheets extends StatefulWidget {
  /// The child.
  final Widget child;

  /// Creates a [FSheets].
  const FSheets({required this.child, super.key});

  @override
  State<FSheets> createState() => FSheetsState();
}

@visibleForTesting
@internal
class FSheetsState extends State<FSheets> with TickerProviderStateMixin {
  final Map<Key, (FPersistentSheetController, Sheet)> sheets = {};

  @override
  Widget build(BuildContext _) => Stack(
    children: [
      widget.child,
      for (final (controller, sheet) in sheets.values)
        if (controller.keepAliveOffstage || controller.status.isAnimating || controller.status.isCompleted)
          CallbackShortcuts(
            bindings: {const SingleActivator(LogicalKeyboardKey.escape): controller._controller.reverse},
            child: FocusTraversalGroup(
              descendantsAreFocusable: controller.status.isCompleted,
              descendantsAreTraversable: controller.status.isCompleted,
              child: sheet,
            ),
          ),
    ],
  );

  void _add(FPersistentSheetController controller, Sheet sheet) {
    if (!mounted) {
      return;
    }

    if (sheets.containsKey(controller.key)) {
      throw FlutterError.fromParts([
        ErrorSummary('showFSheet(...) called with a key that already exists.'),
        ErrorDescription(
          'A sheet with the key, "${controller.key}", already exists. Each sheet must have a unique key.',
        ),
        ErrorHint(
          'To solve this problem, pass a different key to `showFSheet(...)` or dispose of the other sheet with the same '
          'key first',
        ),
      ]);
    }

    setState(() => sheets[controller.key] = (controller, sheet));
  }

  Future<void> _remove(Key key) async {
    // This checks if the method was called during the build phase, and schedules the removal for the next frame.
    // This done as _remove is called in FSheetController.dispose, and subsequently StatefulWidget.dispose, which is
    // part of the build phase.
    if (mounted && SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      setState(() => sheets.remove(key));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => sheets.remove(key));
        }
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('sheets', sheets));
  }
}

/// A persistent sheet's style.
class FPersistentSheetStyle extends FSheetStyle with Diagnosticable, _$FPersistentSheetStyleFunctions {
  /// The motion-related properties for a persistent sheet.
  @override
  final FPersistentSheetMotion motion;

  /// Creates a [FSheetStyle].
  const FPersistentSheetStyle({
    this.motion = const FPersistentSheetMotion(),
    super.flingVelocity,
    super.closeProgressThreshold,
  });
}

/// The motion-related properties for a persistent sheet.
class FPersistentSheetMotion extends FSheetMotion with Diagnosticable, _$FPersistentSheetMotionFunctions {
  /// Creates a [FPersistentSheetMotion].
  const FPersistentSheetMotion({super.expandDuration, super.collapseDuration, super.curve});
}
