import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/gesture_detector.dart';
import 'package:meta/meta.dart';

@internal
class Sheet extends StatefulWidget {
  static void _onClosing() {}

  /// The animation controller that controls the bottom sheet's entrance and exit animations.
  ///
  /// This widget will manipulate the position of this animation, it is not just a passive observer.
  final AnimationController? controller;

  /// The sheet's layout.
  final Layout layout;

  /// The sheet's style.
  final FSheetStyle style;

  /// The minimum and maximum size.
  final BoxConstraints constraints;

  /// True if the sheet can be dragged up and down/left and right, and dismissed by swiping in the opposite direction.
  ///
  /// If this is true, the [controller] must not be null.
  final bool draggable;

  /// A builder for the sheet's contents.
  final WidgetBuilder builder;

  /// Called when the user begins dragging the bottom sheet vertically, if [draggable] is true.
  ///
  /// Would typically be used to change the bottom sheet animation curve so that it tracks the user's finger accurately.
  final GestureDragStartCallback? onDragStart;

  /// Called when the user stops dragging the sheet, if [draggable] is true.
  ///
  /// Would typically be used to reset the bottom sheet animation curve, so that it animates non-linearly. Called before
  /// [onClosing] if the sheet is closing.
  final void Function(DragEndDetails details, {required bool closing})? onDragEnd;

  /// Called when the sheet begins to close.
  ///
  /// A sheet might be prevented from closing (e.g., by user interaction) even after this callback is called. For this
  /// reason, this callback might be call multiple times for a given sheet.
  final VoidCallback onClosing;

  const Sheet({
    required this.style,
    required this.layout,
    required this.builder,
    this.controller,
    this.constraints = const BoxConstraints(),
    this.onClosing = _onClosing,
    super.key,
  })  : draggable = false,
        onDragStart = null,
        onDragEnd = null;

  const Sheet.draggable({
    required AnimationController this.controller,
    required this.style,
    required this.layout,
    required this.builder,
    this.constraints = const BoxConstraints(),
    this.onDragStart,
    this.onDragEnd,
    this.onClosing = _onClosing,
    super.key,
  }) : draggable = true;

  @override
  State<Sheet> createState() => _SheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(FlagProperty('draggable', value: draggable, ifTrue: 'draggable'))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('onDragStart', onDragStart))
      ..add(ObjectFlagProperty.has('onDragEnd', onDragEnd))
      ..add(ObjectFlagProperty.has('onClosing', onClosing));
  }
}

class _SheetState extends State<Sheet> with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey(debugLabel: 'Sheet child');
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: widget.style.enterDuration,
          reverseDuration: widget.style.exitDuration,
        );
  }

  @override
  void didUpdateWidget(covariant Sheet old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ??
          AnimationController(
            vsync: this,
            duration: widget.style.enterDuration,
            reverseDuration: widget.style.exitDuration,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget sheet = Align(
      alignment: switch (widget.layout) {
        Layout.ttb => Alignment.topCenter,
        Layout.btt => Alignment.bottomCenter,
        Layout.ltr => Alignment.centerLeft,
        Layout.rtl => Alignment.centerRight,
      },
      heightFactor: widget.layout.vertical ? 1 : null,
      widthFactor: widget.layout.vertical ? null : 1,
      child: ConstrainedBox(
        constraints: widget.constraints,
        child: NotificationListener<DraggableScrollableNotification>(
            key: _key,
            onNotification: (notification) {
              if (notification.extent == notification.minExtent && notification.shouldCloseOnMinExtent) {
                widget.onClosing();
              }
              return false;
            },
            child: widget.builder(context)),
      ),
    );

    if (widget.draggable) {
      sheet = SheetGestureDetector(
        layout: widget.layout,
        onStart: widget.onDragStart,
        onUpdate: _dragUpdate,
        onEnd: _dragEnd,
        child: sheet,
      );
    }

    return sheet;
  }

  GestureDragUpdateCallback get _dragUpdate => switch (widget.layout) {
        Layout.ttb => (details) {
            if (!_dismissing) {
              _controller.value += details.primaryDelta! / _key.currentChildHeight;
            }
          },
        Layout.btt => (details) {
            if (!_dismissing) {
              _controller.value -= details.primaryDelta! / _key.currentChildHeight;
            }
          },
        Layout.ltr => (details) {
            if (!_dismissing) {
              _controller.value += details.primaryDelta! / _key.currentChildWidth;
            }
          },
        Layout.rtl => (details) {
            if (!_dismissing) {
              _controller.value -= details.primaryDelta! / _key.currentChildWidth;
            }
          },
      };

  GestureDragEndCallback get _dragEnd {
    final double Function(DragEndDetails) velocity = switch (widget.layout) {
      Layout.ttb => (details) => details.primaryVelocity! / _key.currentChildHeight,
      Layout.btt => (details) => -details.primaryVelocity! / _key.currentChildHeight,
      Layout.ltr => (details) => details.primaryVelocity! / _key.currentChildWidth,
      Layout.rtl => (details) => -details.primaryVelocity! / _key.currentChildWidth,
    };

    return (details) {
      if (_dismissing) {
        return;
      }

      var closing = false;
      if (widget.style.flingVelocity < details.primaryVelocity!) {
        final flingVelocity = velocity(details);
        if (0 < _controller.value) {
          _controller.fling(velocity: flingVelocity);
        }

        if (flingVelocity < 0) {
          closing = true;
        }
      } else if (_controller.value < widget.style.closeProgressThreshold) {
        if (0 < _controller.value) {
          _controller.fling(velocity: -1);
        }
        closing = true;
      } else {
        _controller.forward();
      }

      widget.onDragEnd?.call(details, closing: closing);
      if (closing) {
        widget.onClosing();
      }
    };
  }

  bool get _dismissing => _controller.status == AnimationStatus.reverse;

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
  }
}

extension on GlobalKey {
  double get currentChildWidth => (currentContext!.findRenderObject()! as RenderBox).size.width;

  double get currentChildHeight => (currentContext!.findRenderObject()! as RenderBox).size.height;
}

// TODO: make abstract

/// A sheet's style.
class FSheetStyle with Diagnosticable {
  /// The sheet's background color.
  final Color backgroundColor;

  /// The entrance duration. Defaults to 200ms.
  final Duration enterDuration;

  /// The exit duration. Defaults to 200ms.
  final Duration exitDuration;

  /// The minimum velocity to initiate a fling. Defaults to 700.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the value is not positive.
  final double flingVelocity;

  /// The threshold for determining whether the sheet is closing. Defaults to 0.5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the value is not in the range [0, 1].
  final double closeProgressThreshold;

  /// Creates a [FSheetStyle].
  const FSheetStyle({
    required this.backgroundColor,
    this.enterDuration = const Duration(milliseconds: 250),
    this.exitDuration = const Duration(milliseconds: 200),
    this.flingVelocity = 700,
    this.closeProgressThreshold = 0.5,
  });

  /// Creates a [FSheetStyle] that inherits its colors from the given [FColorScheme] and [FStyle].
  FSheetStyle.inherit({
    required FColorScheme colorScheme,
  }) : this(
          backgroundColor: colorScheme.background,
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('enterDuration', enterDuration))
      ..add(DiagnosticsProperty('exitDuration', exitDuration))
      ..add(DoubleProperty('flingVelocity', flingVelocity))
      ..add(DoubleProperty('closeProgressThreshold', closeProgressThreshold));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSheetStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          enterDuration == other.enterDuration &&
          exitDuration == other.exitDuration &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      enterDuration.hashCode ^
      exitDuration.hashCode ^
      flingVelocity.hashCode ^
      closeProgressThreshold.hashCode;
}
