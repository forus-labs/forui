import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheet.dart';
import 'package:meta/meta.dart';

/// Shows a sheet that appears above the current widget. It should have a [FSheets] or [FScaffold] ancestor.
///
/// A closely related widget is a modal sheet which prevents the user from interacting with the rest of the app.
///
/// [context] is used to look up the [Navigator] and [FSheetStyle] for the sheet. It is only used when the method is
/// called. Its corresponding widget can be safely removed from the tree before the sheet is closed.
///
/// [style] defaults to [FSheetStyle] from the closest [FTheme] ancestor.
///
/// [mainAxisMaxRatio] represents the main axis's max constraint ratio for the sheet, depending on [side].
/// Defaults to 9 / 16. The main axis is the width if [side] is [Layout.ltr] or [Layout.rtl], and the height if [side]
/// is [Layout.ttb] or [Layout.btt]. Consider setting [mainAxisMaxRatio] to null if this sheet has a scrollable child,
/// i.e. [ListView], along the main axis, to have the sheet be draggable.
///
/// ## Contract
/// Throws [FlutterError] if the [context] does not contain a [FSheets] or [FScaffold] ancestor.
///
/// See:
/// * https://forui.dev/docs/overlay/sheets for working examples.
/// * [showFModalSheet] for showing a sheet in a modal that prevents the user from interacting with the rest of the app.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [DraggableScrollableSheet], creates a bottom sheet that grows and then becomes scrollable once it reaches its
///   maximum size.
@useResult
FSheetController showFSheet({
  required BuildContext context,
  required Layout side,
  required WidgetBuilder builder,
  FSheetStyle? style,
  double? mainAxisMaxRatio = 9 / 16,
  BoxConstraints constraints = const BoxConstraints(),
  bool draggable = true,
  Offset? anchorPoint,
  bool useSafeArea = false,
  bool keepAliveOffstage = false,
  Key? key,
}) {
  final state = context.findAncestorStateOfType<FSheetsState>();
  if (state == null) {
    throw FlutterError.fromParts([
      ErrorSummary(
        'showFSheet(...) called with a context that does not contain a FSheets/FScaffold.',
      ),
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

  key ??= ValueKey(Random.secure().nextInt(2147483647));
  style ??= context.theme.sheetStyle;

  final controller = FSheetController._(
    vsync: state,
    style: style,
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

  state._add(
    controller,
    Sheet(
      controller: controller._controller,
      style: style,
      side: side,
      mainAxisMaxRatio: mainAxisMaxRatio,
      constraints: constraints,
      draggable: draggable,
      anchorPoint: anchorPoint,
      useSafeArea: useSafeArea,
      builder: builder,
    ),
  );

  controller.show();

  return controller;
}

/// A sheet controller.
class FSheetController {
  /// The sheet's key.
  final Key key;

  /// True if the sheet to which this controller is attached should be kept alive even when it is offstage. Defaults to
  /// false. Keeping multiple sheets alive even when offstage can negatively impact performance.
  final bool keepAliveOffstage;

  /// Marks the sheet as needing to be rebuilt.
  final StateSetter setState;

  final AnimationController _controller;
  final VoidCallback _onDispose;

  FSheetController._({
    required TickerProvider vsync,
    required FSheetStyle style,
    required VoidCallback onDispose,
    required this.key,
    required this.keepAliveOffstage,
    required this.setState,
  })  : _controller = Sheet.createAnimationController(vsync, style),
        _onDispose = onDispose {
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectCreated(
        library: 'package:flutter/forui.dart',
        className: '$FSheetController',
        object: this,
      );
    }

    _controller.addStatusListener((status) => setState.call(() {}));
  }

  /// Shows the sheet if it is hidden.
  TickerFuture show() => _controller.forward();

  /// Shows the sheet if it is hidden and hides it if it is shown.
  TickerFuture toggle() => _controller.toggle();

  /// Hides the sheet if it is shown.
  TickerFuture hide() => _controller.reverse();

  /// True if the sheet is shown.
  bool get shown => _controller.value != 0;

  /// Disposes of the controller.
  void dispose() {
    _controller.dispose();
    _onDispose();
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
/// * https://forui.dev/docs/overlay/sheets for working examples.
/// * [FSheetStyle] for customizing a switch's appearance.
/// * [showFSheet] for for displaying a sheet above the current widget.
/// * [showFModalSheet] for displaying a modal sheet.
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
  final Map<Key, (FSheetController, Sheet)> sheets = {};

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          widget.child,
          for (final (controller, sheet) in sheets.values)
            if (controller.shown || controller.keepAliveOffstage || controller._controller.status.isAnimating) sheet,
        ],
      );

  void _add(FSheetController controller, Sheet sheet) {
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

  void _remove(Key key) {
    if (mounted) {
      setState(() => sheets.remove(key));
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Map<Key, (FSheetController, Sheet)>>('sheets', sheets));
  }
}
