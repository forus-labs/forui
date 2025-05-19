import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/toast/toaster.dart';
import 'package:meta/meta.dart';

@internal
enum ToastLocation {
  topLeft(alignment: Alignment.topLeft, collapsedAlignment: Alignment.bottomCenter),
  topCenter(alignment: Alignment.topCenter, collapsedAlignment: Alignment.bottomCenter),
  topRight(alignment: Alignment.topRight, collapsedAlignment: Alignment.bottomCenter),
  bottomLeft(alignment: Alignment.bottomLeft, collapsedAlignment: Alignment.topCenter),
  bottomCenter(alignment: Alignment.bottomCenter, collapsedAlignment: Alignment.topCenter),
  bottomRight(alignment: Alignment.bottomRight, collapsedAlignment: Alignment.topCenter);

  final Alignment alignment;
  final Alignment collapsedAlignment;

  const ToastLocation({required this.alignment, required this.collapsedAlignment});
}

/// A Toast's data.
class FToastData extends InheritedWidget {
  /// Returns the [FToastData] of the [FToast] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FToast] in the given [context].
  static FToastData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FToastData>();
    assert(data != null, 'No FToastData found in context');
    return data!;
  }

  /// The toast's style.
  final FToastStyle style;

  /// The [FToastLayer] where the toast entry will be added to.
  final FToastLayerState? data;

  /// Creates a [FToastData].
  const FToastData({required this.style, required this.data, required super.child, super.key});

  @override
  bool updateShouldNotify(FToastData oldWidget) => style != oldWidget.style || data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('data', data));
  }
}

/// Displays the toast with the given configurations.
ToastEntry showToast({
  required BuildContext context,
  required Widget Function(BuildContext context, ToastEntry overlay) builder,
  FToastStyle? style,
  ToastLocation location = ToastLocation.bottomRight,
  bool dismissible = true,
  VoidCallback? onClose,
  Duration showDuration = const Duration(seconds: 5),
}) {
  final data = FToastData.of(context);
  final layer = data.data;
  if (layer == null) {
    throw FlutterError.fromParts([
      ErrorSummary('showFSonner(...) called with a context that does not contain a FSonner/FScaffold.'),
      ErrorDescription(
        'No FSonner/FScaffold ancestor could be found starting from the context that was passed to FSonner/FScaffold.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that whose build function '
        'actually creates the FSonner/FScaffold widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the FSonner/FScaffold.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  final entry = ToastEntry(
    builder: builder,
    location: location,
    dismissible: dismissible,
    style: style ?? data.style,
    showDuration: showDuration,
    attached: layer,
  );
  entry.onClose = () {
    layer.removeEntry(entry);
    onClose?.call();
  };

  return layer.addEntry(entry);
}

@internal
class ToastEntry {
  /// The key of the toast entry.
  final GlobalKey key = GlobalKey();
  FToastLayerState? attached;
  final ValueNotifier<bool> closing = ValueNotifier(false);

  /// True if the toast is attached to the overlay.
  bool get isShowing => attached != null;

  final Widget Function(BuildContext context, ToastEntry overlay) builder;
  final ToastLocation location;
  final bool dismissible;
  final FToastStyle? style;
  late VoidCallback onClose;
  final Duration showDuration;

  ToastEntry({
    required this.builder,
    required this.location,
    required this.style,
    required this.showDuration,
    required this.dismissible,
    required this.attached,
  });

  /// Removes the toast entry from the overlay.
  void close() {
    if (attached == null) {
      return;
    }
    closing.value = true;
    attached!._triggerEntryClosing();
    attached = null;
  }
}

/// How the toast should be expanded.
@internal
enum ExpandMode { alwaysExpanded, expandOnHover, expandOnTap, disabled }

class _ToastLocationData {
  final List<ToastEntry> entries = [];
  bool expanding = false;
  int hoverCount = 0;
}

/// The Toast provider widget that manages and displays toast notifications.
///
/// This widget creates a stack where toast entries can be added, positioned,
/// and animated. It acts as the central point for handling the layout and
/// lifecycle of all toasts in the application.
///
/// Should be placed near the top of the widget tree to ensure global access
/// and proper overlay behavior.
class FToastLayer extends StatefulWidget {
  /// The style.
  final FToastStyle style;

  /// The child.
  final Widget child;

  /// Creates a [FToastLayer].
  const FToastLayer({required this.child, required this.style, super.key});

  @override
  State<FToastLayer> createState() => FToastLayerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// The state of the [FToastLayer].
class FToastLayerState extends State<FToastLayer> {
  final Map<ToastLocation, _ToastLocationData> _entries = {
    ToastLocation.topLeft: _ToastLocationData(),
    ToastLocation.topCenter: _ToastLocationData(),
    ToastLocation.topRight: _ToastLocationData(),
    ToastLocation.bottomLeft: _ToastLocationData(),
    ToastLocation.bottomCenter: _ToastLocationData(),
    ToastLocation.bottomRight: _ToastLocationData(),
  };

  void _triggerEntryClosing() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  /// Adds a toast entry to the overlay.
  ToastEntry addEntry(ToastEntry entry) {
    setState(() {
      final entries = _entries[entry.location];
      entries!.entries.add(entry);
    });
    return entry;
  }

  /// Removes a toast entry from the overlay.
  void removeEntry(ToastEntry entry) {
    final last = _entries[entry.location]!.entries.where((e) => e == entry).lastOrNull;
    if (last != null) {
      setState(() {
        _entries[entry.location]!.entries.remove(last);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final children = [widget.child];

    for (final MapEntry(value: data) in _entries.entries) {
      final positioned = <ToastEntry>[];
      int toastIndex = 0;
      final padding = style.padding;

      for (var i = data.entries.length - 1; i >= 0; i--) {
        final entry = data.entries[i];
        if (toastIndex < style.maxStackedEntries) {
          positioned.insert(0, entry);
        }

        if (!entry.closing.value) {
          toastIndex++;
        }
      }

      if (positioned.isEmpty) {
        continue;
      }

      children.add(
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: padding,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Toaster(
                  alignTransform: Offset(Alignment.topCenter.x, Alignment.topCenter.y),
                  style: style,
                  entries: positioned,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return FToastData(
      style: style,
      data: this,
      child: Stack(clipBehavior: Clip.none, fit: StackFit.passthrough, children: children),
    );
  }
}
