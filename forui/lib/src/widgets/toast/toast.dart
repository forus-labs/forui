import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
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
      final startVisible = max(data.entries.length - (style.maxStackedEntries * 2), 0);
      final entryAlignment = location.collapsedAlignment * -1;
      final positionedChildren = <Widget>[];
      int toastIndex = 0;
      final padding = style.padding;

      for (var i = data.entries.length - 1; i >= startVisible; i--) {
        final entry = data.entries[i];
        if (toastIndex < style.maxStackedEntries) {
          positionedChildren.insert(
            0,
            ToastEntryLayout(
              key: entry.key,
              entry: entry.entry,
              expanded: data.expanding || style.expandMode == ExpandMode.alwaysExpanded,
              dismissible: entry.entry.dismissible,
              behindAlignment: location.collapsedAlignment,
              closing: entry._isClosing,
              style: style,
              onClosed: () {
                removeEntry(entry.entry);
                entry.entry.onClosed?.call();
              },
              alignment: entryAlignment,
              index: toastIndex,
              onClosing: entry.close,
              child: ConstrainedBox(constraints: style.toastConstraints, child: entry.entry.builder(context, entry)),
            ),
          );
        }

        if (!entry._isClosing.value) {
          toastIndex++;
        }
      }

      if (positionedChildren.isEmpty) {
        continue;
      }

      children.add(
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: padding,
              child: Align(
                alignment: location.alignment,
                child: MouseRegion(
                  hitTestBehavior: HitTestBehavior.deferToChild,
                  onEnter: (event) {
                    data.hoverCount++;
                    if (style.expandMode == ExpandMode.expandOnHover) {
                      setState(() {
                        data.expanding = true;
                      });
                    }
                  },
                  onExit: (event) {
                    final currentCount = ++data.hoverCount;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (currentCount == data.hoverCount) {
                        if (mounted) {
                          setState(() {
                            data.expanding = false;
                          });
                        } else {
                          data.expanding = false;
                        }
                      }
                    });
                  },
                  child: ConstrainedBox(
                    constraints: style.toastConstraints,
                    child: Column(
                      // This is a workaround to ensure that the children occupy the minimum required height in the layout.
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: location.alignment,
                          clipBehavior: Clip.none,
                          fit: StackFit.passthrough,
                          children: positionedChildren,
                        ),
                      ],
                    ),
                  ),
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

@internal
class ToastEntryLayout extends StatefulWidget {
  final ToastEntry entry;
  final bool expanded;
  final bool dismissible;
  final Alignment behindAlignment;
  final FToastStyle style;
  final ValueListenable<bool> closing;
  final Widget child;
  final Alignment alignment;
  final int index;
  final VoidCallback onClosing;
  final VoidCallback onClosed;

  const ToastEntryLayout({
    required this.entry,
    required this.expanded,
    required this.closing,
    required this.onClosed,
    required this.child,
    required this.alignment,
    required this.index,
    required this.onClosing,
    required this.style,
    required this.behindAlignment,
    this.dismissible = true,
    super.key,
  });

  @override
  State<ToastEntryLayout> createState() => _ToastEntryLayoutState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entry', entry))
      ..add(FlagProperty('expanded', value: expanded, ifTrue: 'expanded'))
      ..add(FlagProperty('dismissible', value: dismissible, ifTrue: 'dismissible'))
      ..add(DiagnosticsProperty('behindAlignment', behindAlignment))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('closing', closing))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('onClosing', onClosing))
      ..add(DiagnosticsProperty('onClosed', onClosed));
  }
}

class _ToastEntryLayoutState extends State<ToastEntryLayout> {
  bool _dismissing = false;
  double _dismissProgress = 0;
  double? _targetDismissProgress;
  Timer? _closingTimer;

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startClosingTimer();
  }

  void _startClosingTimer() {
    _closingTimer?.cancel();
    _closingTimer = Timer(widget.entry.showDuration, () {
      widget.onClosing.call();
    });
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    key: _key,
    hitTestBehavior: HitTestBehavior.deferToChild,
    onEnter: (event) {
      _closingTimer?.cancel();
    },
    onExit: (event) {
      _startClosingTimer();
    },
    child: GestureDetector(
      onHorizontalDragStart: (details) {
        if (widget.dismissible) {
          setState(() {
            _closingTimer?.cancel();
            _dismissing = true;
          });
        }
      },
      onHorizontalDragUpdate: (details) {
        if (widget.dismissible) {
          setState(() {
            _dismissProgress += details.primaryDelta! / context.size!.width;
          });
        }
      },
      onHorizontalDragEnd: (_) {
        if (widget.dismissible) {
          setState(() {
            _dismissing = false;
          });
          // if its < -0.5 or > 0.5 dismiss it
          if (_dismissProgress < -0.5) {
            _targetDismissProgress = -1.0;
          } else if (_dismissProgress > 0.5) {
            _targetDismissProgress = 1.0;
          } else {
            _dismissProgress = 0;
            _startClosingTimer();
          }
        }
      },
      child: AnimatedBuilder(
        animation: widget.closing,
        builder:
            (_, _) => TweenAnimationBuilder(
              tween: Tween(end: widget.closing.value ? 0.0 : (_targetDismissProgress ?? _dismissProgress)),
              curve: widget.style.dismissCurve,
              duration: _dismissing ? Duration.zero : widget.style.dismissDuration,
              onEnd: _targetDismissProgress == null ? null : widget.onClosed,
              builder:
                  (_, dismissProgress, _) => TweenAnimationBuilder(
                    tween: Tween(end: widget.index.toDouble()),
                    curve: widget.style.animationCurve,
                    duration: widget.style.animationDuration,
                    builder:
                        (_, indexProgress, _) => TweenAnimationBuilder(
                          tween: Tween(
                            begin: widget.index > 0 ? 1.0 : 0.0,
                            end: widget.closing.value && !_dismissing ? 0.0 : 1.0,
                          ),
                          curve: widget.style.animationCurve,
                          duration: widget.style.animationDuration,
                          onEnd: widget.closing.value ? widget.onClosed : null,
                          builder:
                              (_, entranceExitProgress, _) => TweenAnimationBuilder(
                                tween: Tween(end: widget.expanded ? 1.0 : 0.0),
                                curve: widget.style.expandCurve,
                                duration: widget.style.expandDuration,
                                builder:
                                    (_, expandingProgress, _) =>
                                        _toast(expandingProgress, entranceExitProgress, indexProgress, dismissProgress),
                              ),
                        ),
                  ),
            ),
      ),
    ),
  );

  Widget _toast(double expand, double transition, double index, double dismiss) {
    final collapsedProgress = (1.0 - expand) * transition;
    final alignment = widget.alignment;
    final behindTransform = Offset(widget.behindAlignment.x, widget.behindAlignment.y);

    // Shift up/down when behind another toast
    var offset = widget.style.collapsedOffset.scale(behindTransform.dx, behindTransform.dy) * collapsedProgress * index;
    // Shift up/down when expanding/collapsing
    offset += behindTransform * 16 * expand;
    // Add spacing when expanded
    offset += behindTransform * widget.style.spacing * expand * index;

    var fractional = Offset(alignment.x, alignment.y) * (1.0 - transition);
    // Add dismiss offset
    fractional += Offset(dismiss, 0);
    // Shift up/down when behind another toast & expanded
    fractional += behindTransform * expand * index;

    var opacity = widget.style.entryOpacity + (1.0 - widget.style.entryOpacity) * transition;
    // Fade out the toast behind
    opacity *= pow(widget.style.collapsedOpacity, index * collapsedProgress);
    // Fade out the toast when dismissing
    opacity *= 1 - dismiss.abs();

    final scale = 1.0 * pow(widget.style.collapsedScale, index * (1 - expand));

    return Transform.translate(
      offset: offset,
      child: FractionalTranslation(
        translation: fractional,
        child: Opacity(opacity: opacity.clamp(0, 1), child: Transform.scale(scale: scale, child: widget.child)),
      ),
    );
  }
}
