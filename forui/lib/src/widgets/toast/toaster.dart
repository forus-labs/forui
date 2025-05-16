import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/toaster.dart';
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
ToastOverlay showToast({
  required BuildContext context,
  required Widget Function(BuildContext context, ToastOverlay overlay) builder,
  FToastStyle? style,
  ToastLocation location = ToastLocation.bottomRight,
  bool dismissible = true,
  VoidCallback? onClosed,
  Duration showDuration = const Duration(seconds: 5),
}) {
  final data = FToastData.of(context);
  final layer = data.data;
  assert(layer != null, 'No ToastLayer found in context');
  final entry = ToastEntry(
    builder: builder,
    location: location,
    dismissible: dismissible,
    style: style ?? data.style,
    onClosed: onClosed,
    showDuration: showDuration,
  );
  return layer!.addEntry(entry);
}

@internal
class ToastEntry {
  final Widget Function(BuildContext context, ToastOverlay overlay) builder;
  final ToastLocation location;
  final bool dismissible;
  final FToastStyle? style;
  final VoidCallback? onClosed;
  final Duration showDuration;

  ToastEntry({
    required this.builder,
    required this.location,
    required this.style,
    required this.showDuration,
    required this.dismissible,
    this.onClosed,
  });
}

@internal
class ToastOverlay {
  /// The key of the toast entry.
  final GlobalKey key = GlobalKey();

  /// The toast entry.
  final ToastEntry entry;

  FToastLayerState? _attached;
  final ValueNotifier<bool> _isClosing = ValueNotifier(false);

  ToastOverlay(this.entry, this._attached);

  /// True if the toast is attached to the overlay.
  bool get isShowing => _attached != null;

  /// Removes the toast entry from the overlay.
  void close() {
    if (_attached == null) {
      return;
    }
    _isClosing.value = true;
    _attached!._triggerEntryClosing();
    _attached = null;
  }
}

/// How the toast should be expanded.
@internal
enum ExpandMode { alwaysExpanded, expandOnHover, expandOnTap, disabled }

class _ToastLocationData {
  final List<ToastOverlay> entries = [];
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
  /// The style. Defaults to [FThemeData.toastStyle].
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
  ToastOverlay addEntry(ToastEntry entry) {
    final attachedToastEntry = ToastOverlay(entry, this);
    setState(() {
      final entries = _entries[entry.location];
      entries!.entries.add(attachedToastEntry);
    });
    return attachedToastEntry;
  }

  /// Removes a toast entry from the overlay.
  void removeEntry(ToastEntry entry) {
    final last = _entries[entry.location]!.entries.where((e) => e.entry == entry).lastOrNull;
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

    for (final MapEntry(key: location, value: data) in _entries.entries) {
      final positioned = <(Key, Widget)>[];
      int toastIndex = 0;
      final padding = style.padding;

      for (var i = data.entries.length - 1; i >= 0; i--) {
        final entry = data.entries[i];
        if (toastIndex < style.maxStackedEntries) {
          positioned.add((entry.key, entry.entry.builder(context, entry)));
        }

        if (!entry._isClosing.value) {
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
                alignment: location.alignment,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Toaster(
                      shiftTransform: Offset(Alignment.topCenter.x, Alignment.topCenter.y),
                      style: style,
                      children: positioned,
                    ),
                  ],
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
