import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/gesture_detector.dart';
import 'package:meta/meta.dart';

@internal
class Sheet extends StatefulWidget {
  /// Creates an [AnimationController] suitable for a [Sheet.controller].
  // TODO: move animation to style.
  static AnimationController createAnimationController(TickerProvider vsync, {AnimationStyle? sheetAnimationStyle}) =>
      AnimationController(
        duration: sheetAnimationStyle?.duration ?? const Duration(milliseconds: 250),
        reverseDuration: sheetAnimationStyle?.reverseDuration ?? const Duration(milliseconds: 200),
        debugLabel: 'Sheet',
        vsync: vsync,
      );

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
  /// If [handle] is true, this only applies to the content excluding the drag handle, because the drag handle is
  /// always draggable.
  ///
  /// If this is true, the [controller] must not be null.
  final bool draggableContents;

  /// True if the sheet can be dragged by the drag handle. Defaults to false.
  ///
  /// If this is true, the [controller] must not be null.
  final bool handle;

  /// A builder for the sheet's contents.
  final WidgetBuilder builder;

  /// Called when the user begins dragging the bottom sheet vertically, if [draggableContents] is true.
  ///
  /// Would typically be used to change the bottom sheet animation curve so that it tracks the user's finger accurately.
  final GestureDragStartCallback? onDragStart;

  /// Called when the user stops dragging the sheet, if [draggableContents] is true.
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
    required this.constraints,
    required this.builder,
    this.controller,
    this.onClosing = _onClosing,
    super.key,
  })  : draggableContents = false,
        handle = false,
        onDragStart = null,
        onDragEnd = null;

  const Sheet.draggable({
    required AnimationController this.controller,
    required this.style,
    required this.layout,
    required this.constraints,
    required this.builder,
    this.handle = false,
    this.draggableContents = true,
    this.onDragStart,
    this.onDragEnd,
    this.onClosing = _onClosing,
    super.key,
  }) : assert(handle || draggableContents, 'Sheet must be draggable or have a handle.');

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
      ..add(FlagProperty('draggableContents', value: draggableContents, ifTrue: 'draggableContents'))
      ..add(FlagProperty('handle', value: handle, ifTrue: 'handle'))
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
    _controller = widget.controller ?? Sheet.createAnimationController(this);
  }

  @override
  void didUpdateWidget(covariant Sheet old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? Sheet.createAnimationController(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FSheetStyle(:handlePadding, :handleSize) = widget.style;

    // Only add [SheetGestureDetector] to the drag handle when the rest of the bottom sheet is not draggable. If the
    // whole sheet is draggable, no need to add it.
    final handle = switch (widget.handle) {
      true when widget.draggableContents => SheetGestureDetector(
          layout: widget.layout,
          onStart: widget.onDragStart,
          onUpdate: _dragUpdate,
          onEnd: _dragEnd,
          child: Handle(style: widget.style),
        ),
      true => Handle(style: widget.style),
      false => null,
    };

    final sheet = Align(
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
          child: handle == null
              ? widget.builder(context)
              : switch (widget.layout) {
                  Layout.ttb => Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        handle,
                        Padding(
                          padding: EdgeInsets.only(bottom: handlePadding.vertical + handleSize.height),
                          child: widget.builder(context),
                        ),
                      ],
                    ),
                  Layout.btt => Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        handle,
                        Padding(
                          padding: EdgeInsets.only(top: handlePadding.vertical + handleSize.height),
                          child: widget.builder(context),
                        ),
                      ],
                    ),
                  Layout.ltr => Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        handle,
                        Padding(
                          padding: EdgeInsets.only(right: handlePadding.horizontal + handleSize.width),
                          child: widget.builder(context),
                        ),
                      ],
                    ),
                  Layout.rtl => Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        handle,
                        Padding(
                          padding: EdgeInsets.only(left: handlePadding.horizontal + handleSize.width),
                          child: widget.builder(context),
                        ),
                      ],
                    ),
                },
        ),
      ),
    );

    return widget.draggableContents
        ? SheetGestureDetector(
            layout: widget.layout,
            onStart: widget.onDragStart,
            onUpdate: _dragUpdate,
            onEnd: _dragEnd,
            child: sheet,
          )
        : sheet;
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

// Handle size: Size(32, 4).
// Minimum accessibility target 44x44.

// TODO: make abstract

/// A sheet's style.
class FSheetStyle with Diagnosticable {
  /// The sheet's background color.
  final Color backgroundColor;

  /// The drag handle's color.
  final Color handleColor;

  /// The drag handle's border radius.
  final BorderRadius handleBorderRadius;

  /// The drag handle's size.
  final Size handleSize;

  /// The padding surrounding the handle.
  final EdgeInsets handlePadding;

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
    required this.handleColor,
    required this.handleBorderRadius,
    required this.handleSize,
    required this.handlePadding,
    this.flingVelocity = 700,
    this.closeProgressThreshold = 0.5,
  });

  /// Creates a [FSheetStyle] that inherits its colors from the given [FColorScheme] and [FStyle].
  FSheetStyle.inherit({
    required FColorScheme colorScheme,
    required FStyle style,
    required Size size,
    required EdgeInsets handlePadding,
  }) : this(
          backgroundColor: colorScheme.background,
          handleColor: colorScheme.secondary,
          handleBorderRadius: style.borderRadius,
          handleSize: size,
          handlePadding: handlePadding,
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('handleColor', handleColor))
      ..add(DiagnosticsProperty('handleBorderRadius', handleBorderRadius))
      ..add(DiagnosticsProperty('handleSize', handleSize))
      ..add(DiagnosticsProperty('handlePadding', handlePadding))
      ..add(DoubleProperty('flingVelocity', flingVelocity))
      ..add(DoubleProperty('closeProgressThreshold', closeProgressThreshold));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSheetStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          handleColor == other.handleColor &&
          handleBorderRadius == other.handleBorderRadius &&
          handleSize == other.handleSize &&
          handlePadding == other.handlePadding &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      handleColor.hashCode ^
      handleBorderRadius.hashCode ^
      handleSize.hashCode ^
      handlePadding.hashCode ^
      flingVelocity.hashCode ^
      closeProgressThreshold.hashCode;
}
