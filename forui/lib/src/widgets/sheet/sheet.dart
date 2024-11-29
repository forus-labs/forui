import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/gesture_detector.dart';
import 'package:meta/meta.dart';

@internal
class Sheet extends StatefulWidget {
  static AnimationController createAnimationController(TickerProvider vsync, FSheetStyle style) => AnimationController(
        duration: style.enterDuration,
        reverseDuration: style.exitDuration,
        vsync: vsync,
      );

  static void _onClosing() {}

  final AnimationController? controller;
  final FSheetStyle style;
  final Layout layout;
  final BoxConstraints constraints;
  final bool draggable;
  final WidgetBuilder builder;
  final GestureDragStartCallback? onDragStart;
  final void Function(DragEndDetails details, {required bool closing})? onDragEnd;
  final VoidCallback onClosing;

  const Sheet({
    required this.controller,
    required this.style,
    required this.layout,
    required this.builder,
    this.constraints = const BoxConstraints(),
    this.draggable = true,
    this.onDragStart,
    this.onDragEnd,
    this.onClosing = _onClosing,
    super.key,
  }) : assert(!draggable || controller != null, 'Draggable sheets must have a controller.');

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
    _controller = widget.controller ?? Sheet.createAnimationController(this, widget.style);
  }

  @override
  void didUpdateWidget(covariant Sheet old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? Sheet.createAnimationController(this, widget.style);
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
          child: widget.builder(context),
        ),
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
    this.enterDuration = const Duration(milliseconds: 200),
    this.exitDuration = const Duration(milliseconds: 200),
    this.flingVelocity = 700,
    this.closeProgressThreshold = 0.5,
  });

  /// Creates a [FSheetStyle] that inherits its colors from the given [FColorScheme].
  FSheetStyle.inherit({required FColorScheme colorScheme}) : this(backgroundColor: colorScheme.background);

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
