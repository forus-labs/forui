import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

@internal
enum ToastLocation {
  topLeft(childrenAlignment: Alignment.bottomCenter, alignment: Alignment.topLeft),
  topCenter(childrenAlignment: Alignment.bottomCenter, alignment: Alignment.topCenter),
  topRight(childrenAlignment: Alignment.bottomCenter, alignment: Alignment.topRight),
  bottomLeft(childrenAlignment: Alignment.topCenter, alignment: Alignment.bottomLeft),
  bottomCenter(childrenAlignment: Alignment.topCenter, alignment: Alignment.bottomCenter),
  bottomRight(childrenAlignment: Alignment.topCenter, alignment: Alignment.bottomRight);

  final Alignment alignment;
  final Alignment childrenAlignment;

  const ToastLocation({required this.alignment, required this.childrenAlignment});
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
  Curve curve = Curves.easeOutCubic,
  Duration entryDuration = const Duration(milliseconds: 500),
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
    curve: curve,
    duration: entryDuration,
    style: style ?? data.style,
    onClosed: onClosed,
    showDuration: showDuration,
  );
  return layer!.addEntry(entry);
}

/// How the toast should be expanded.
@internal
enum ExpandMode { alwaysExpanded, expandOnHover, expandOnTap, disabled }

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

class _ToastLocationData {
  final List<ToastOverlay> entries = [];
  bool _expanding = false;
  int _hoverCount = 0;
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
    for (final locationEntry in _entries.entries) {
      final location = locationEntry.key;
      final entries = locationEntry.value.entries;
      final expanding = locationEntry.value._expanding;
      final startVisible = max(entries.length - (style.maxStackedEntries * 2),0);
      final entryAlignment = location.childrenAlignment * -1;
      final positionedChildren = <Widget>[];
      int toastIndex = 0;
      final padding = style.padding;
      for (var i = entries.length - 1; i >= startVisible; i--) {
        final entry = entries[i];
        positionedChildren.insert(
          0,
          ToastEntryLayout(
            key: entry.key,
            entry: entry.entry,
            expanded: expanding || style.expandMode == ExpandMode.alwaysExpanded,
            visible: toastIndex < style.maxStackedEntries,
            dismissible: entry.entry.dismissible,
            previousAlignment: location.childrenAlignment,
            curve: entry.entry.curve,
            duration: entry.entry.duration,
            closing: entry._isClosing,
            style: style,
            collapsedOffset: style.collapsedOffset,
            collapsedScale: style.collapsedScale,
            expandingCurve: style.expandingCurve,
            expandingDuration: style.expandingDuration,
            collapsedOpacity: style.collapsedOpacity,
            entryOpacity: style.entryOpacity,
            onClosed: () {
              removeEntry(entry.entry);
              entry.entry.onClosed?.call();
            },
            entryOffset: Offset(
              padding.left * entryAlignment.x.clamp(0, 1) + padding.right * entryAlignment.x.clamp(-1, 0),
              padding.top * entryAlignment.y.clamp(0, 1) + padding.bottom * entryAlignment.y.clamp(-1, 0),
            ),
            entryAlignment: entryAlignment,
            spacing: style.spacing,
            index: toastIndex,
            actualIndex: entries.length - i - 1,
            onClosing: entry.close,
            child: ConstrainedBox(constraints: style.toastConstraints, child: entry.entry.builder(context, entry)),
          ),
        );
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
                    locationEntry.value._hoverCount++;
                    if (style.expandMode == ExpandMode.expandOnHover) {
                      setState(() {
                        locationEntry.value._expanding = true;
                      });
                    }
                  },
                  onExit: (event) {
                    final currentCount = ++locationEntry.value._hoverCount;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (currentCount == locationEntry.value._hoverCount) {
                        if (mounted) {
                          setState(() {
                            locationEntry.value._expanding = false;
                          });
                        } else {
                          locationEntry.value._expanding = false;
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

@internal
class ToastEntry {
  final Widget Function(BuildContext context, ToastOverlay overlay) builder;
  final ToastLocation location;
  final bool dismissible;
  final Curve curve;
  final Duration duration;
  final FToastStyle? style;
  final VoidCallback? onClosed;
  final Duration? showDuration;

  ToastEntry({
    required this.builder,
    required this.location,
    required this.style,
    required this.duration,
    required this.showDuration,
    this.dismissible = true,
    this.curve = Curves.easeInOut,
    this.onClosed,
  });
}

@internal
class ToastEntryLayout extends StatefulWidget {
  final ToastEntry entry;
  final bool expanded;
  final bool visible;
  final bool dismissible;
  final Alignment previousAlignment;
  final Curve curve;
  final Duration duration;
  final FToastStyle? style;
  final ValueListenable<bool> closing;
  final Offset collapsedOffset;
  final double collapsedScale;
  final Curve expandingCurve;
  final Duration expandingDuration;
  final double collapsedOpacity;
  final double entryOpacity;
  final Widget child;
  final Offset entryOffset;
  final Alignment entryAlignment;
  final double spacing;
  final int index;
  final int actualIndex;
  final VoidCallback onClosing;
  final VoidCallback onClosed;

  const ToastEntryLayout({
    required this.entry,
    required this.expanded,

    required this.closing,
    required this.onClosed,
    required this.collapsedOffset,
    required this.collapsedScale,
    required this.entryOffset,
    required this.child,
    required this.entryAlignment,
    required this.spacing,
    required this.index,
    required this.actualIndex,
    required this.onClosing,
    required this.duration,
    required this.expandingDuration,
    this.style,
    this.expandingCurve = Curves.easeInOut,
    this.collapsedOpacity = 0.8,
    this.entryOpacity = 0.0,
    this.visible = true,
    this.dismissible = true,
    this.previousAlignment = Alignment.center,
    this.curve = Curves.easeInOut,

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
      ..add(FlagProperty('visible', value: visible, ifTrue: 'visible'))
      ..add(FlagProperty('dismissible', value: dismissible, ifTrue: 'dismissible'))
      ..add(DiagnosticsProperty('previousAlignment', previousAlignment))
      ..add(DiagnosticsProperty('curve', curve))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('closing', closing))
      ..add(DiagnosticsProperty('collapsedOffset', collapsedOffset))
      ..add(DiagnosticsProperty('collapsedScale', collapsedScale))
      ..add(DiagnosticsProperty('expandingCurve', expandingCurve))
      ..add(DiagnosticsProperty('expandingDuration', expandingDuration))
      ..add(DiagnosticsProperty('collapsedOpacity', collapsedOpacity))
      ..add(DiagnosticsProperty('entryOpacity', entryOpacity))
      ..add(DiagnosticsProperty('child', child))
      ..add(DiagnosticsProperty('entryOffset', entryOffset))
      ..add(DiagnosticsProperty('entryAlignment', entryAlignment))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('actualIndex', actualIndex))
      ..add(DiagnosticsProperty('onClosing', onClosing))
      ..add(DiagnosticsProperty('onClosed', onClosed));
  }
}

class _ToastEntryLayoutState extends State<ToastEntryLayout> {
  bool _dismissing = false;
  double _dismissOffset = 0;
  double? _closeDismissing;
  Timer? _closingTimer;

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startClosingTimer();
  }

  void _startClosingTimer() {
    if (widget.entry.showDuration != null) {
      _closingTimer?.cancel();
      _closingTimer = Timer(widget.entry.showDuration!, () {
        widget.onClosing.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? FToastData.of(context).style;
    return MouseRegion(
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
              _dismissOffset += details.primaryDelta! / context.size!.width;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          if (widget.dismissible) {
            setState(() {
              _dismissing = false;
            });
            // if its < -0.5 or > 0.5 dismiss it
            if (_dismissOffset < -0.5) {
              _closeDismissing = -1.0;
            } else if (_dismissOffset > 0.5) {
              _closeDismissing = 1.0;
            } else {
              _dismissOffset = 0;
              _startClosingTimer();
            }
          }
        },
        child: AnimatedBuilder(
          animation: widget.closing,
          builder:
              (context, child) => AnimatedValueBuilder(
            value: widget.closing.value ? 0.0 : _dismissOffset,
            duration: _dismissing && !widget.closing.value ? Duration.zero : style.animationDuration,
            builder:
                (context, dismissProgress, child) => AnimatedValueBuilder(
              value: widget.closing.value ? 0.0 : _closeDismissing ?? 0.0,
              duration: style.animationDuration,
              onEnd: (value) {
                if (value == -1.0 || value == 1.0) {
                  widget.onClosed();
                }
              },
              builder:
                  (context, closeDismissingProgress, child) => AnimatedValueBuilder(
                value: widget.index.toDouble(),
                curve: widget.curve,
                duration: widget.duration,
                builder:
                    (context, indexProgress, child) => AnimatedValueBuilder(
                  initialValue: widget.index > 0 ? 1.0 : 0.0,
                  value: widget.closing.value && !_dismissing ? 0.0 : 1.0,
                  curve: widget.curve,
                  duration: widget.duration,
                  onEnd: (value) {
                    if (value == 0.0 && widget.closing.value) {
                      widget.onClosed();
                    }
                  },
                  builder:
                      (context, showingProgress, child) => AnimatedValueBuilder(
                    value: widget.visible ? 1.0 : 0.0,
                    curve: widget.curve,
                    duration: widget.duration,
                    builder:
                        (context, visibleProgress, child) => AnimatedValueBuilder(
                      value: widget.expanded ? 1.0 : 0.0,
                      curve: widget.expandingCurve,
                      duration: widget.expandingDuration,
                      builder:
                          (context, expandProgress, child) => _buildToast(
                        style,
                        expandProgress,
                        showingProgress,
                        visibleProgress,
                        indexProgress,
                        dismissProgress,
                        closeDismissingProgress,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToast(
      FToastStyle style,
      double expandProgress,
      double showingProgress,
      double visibleProgress,
      double indexProgress,
      double dismissProgress,
      double closeDismissingProgress,
      ) {
    final nonCollapsingProgress = (1.0 - expandProgress) * showingProgress;
    var offset = widget.entryOffset * (1.0 - showingProgress);

    // when its behind another toast, shift it up based on index
    final previousAlignment = widget.previousAlignment;
    offset +=
        Offset(
          (widget.collapsedOffset.dx * previousAlignment.x) * nonCollapsingProgress,
          (widget.collapsedOffset.dy * previousAlignment.y) * nonCollapsingProgress,
        ) *
            indexProgress;

    final expandingShift = Offset(
      previousAlignment.x * (16 * style.scaling) * expandProgress,
      previousAlignment.y * (16 * style.scaling) * expandProgress,
    );

    offset += expandingShift;

    // and then add the spacing when its in expanded mode
    offset +=
        Offset(
          (widget.spacing * previousAlignment.x) * expandProgress,
          (widget.spacing * previousAlignment.y) * expandProgress,
        ) *
            indexProgress;

    final entryAlignment = widget.entryAlignment;
    var fractionalOffset = Offset(
      entryAlignment.x * (1.0 - showingProgress),
      entryAlignment.y * (1.0 - showingProgress),
    );

    fractionalOffset += Offset(closeDismissingProgress + dismissProgress, 0);

    // when its behind another toast AND is expanded, shift it up based on index and the size of self
    fractionalOffset +=
        Offset(expandProgress * previousAlignment.x, expandProgress * previousAlignment.y) * indexProgress;

    double opacity = widget.entryOpacity + (1.0 - widget.entryOpacity) * (showingProgress * visibleProgress);

    // fade out the toast behind
    opacity *= pow(widget.collapsedOpacity, indexProgress * nonCollapsingProgress);

    opacity *= 1 - (closeDismissingProgress + dismissProgress).abs();

    final scale = 1.0 * pow(widget.collapsedScale, indexProgress * (1 - expandProgress));

    return Align(
      alignment: entryAlignment,
      child: Transform.translate(
        offset: offset,
        child: FractionalTranslation(
          translation: fractionalOffset,
          child: Opacity(opacity: opacity.clamp(0, 1), child: Transform.scale(scale: scale, child: widget.child)),
        ),
      ),
    );
  }
}