import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/gesture_detector.dart';
import 'package:forui/src/widgets/sheet/shifted_sheet.dart';

@internal
class Sheet extends StatefulWidget {
  static AnimationController createAnimationController(TickerProvider vsync, FSheetStyle style) => AnimationController(
    duration: style.motion.expandDuration,
    reverseDuration: style.motion.collapseDuration,
    vsync: vsync,
  );

  final AnimationController? controller;
  final Animation<double>? animation;
  final FSheetStyle style;
  final FLayout side;
  final double? mainAxisMaxRatio;
  final BoxConstraints constraints;
  final Offset? anchorPoint;
  final bool draggable;
  final bool useSafeArea;
  final WidgetBuilder builder;
  final ValueChanged<Size>? onChange;
  final VoidCallback? onClosing;

  const Sheet({
    required this.controller,
    required this.animation,
    required this.style,
    required this.side,
    required this.mainAxisMaxRatio,
    required this.constraints,
    required this.anchorPoint,
    required this.draggable,
    required this.useSafeArea,
    required this.builder,
    required this.onChange,
    required this.onClosing,
    super.key,
  }) : assert(!draggable || controller != null, 'Draggable sheets must have a controller');

  @override
  State<Sheet> createState() => _SheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('animation', animation))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('mainAxisMaxRatio', mainAxisMaxRatio))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('anchorPoint', anchorPoint))
      ..add(FlagProperty('draggable', value: draggable, ifTrue: 'draggable'))
      ..add(FlagProperty('useSafeArea', value: useSafeArea, ifTrue: 'useSafeArea'))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onClosing', onClosing));
  }
}

class _SheetState extends State<Sheet> with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey(debugLabel: 'Sheet child');
  late AnimationController _controller;
  late Animation<double> _animation;
  late ParametricCurve<double> _curve;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? Sheet.createAnimationController(this, widget.style);
    _animation = widget.animation ?? _controller.view;
    _curve = widget.style.motion.curve;
  }

  @override
  void didUpdateWidget(covariant Sheet old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? Sheet.createAnimationController(this, widget.style);
      _animation = widget.animation ?? _controller.view;
      _curve = widget.style.motion.curve;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));

    Widget sheet = DisplayFeatureSubScreen(
      anchorPoint: widget.anchorPoint,
      child: Align(
        alignment: switch (widget.side) {
          FLayout.ttb => Alignment.topCenter,
          FLayout.btt => Alignment.bottomCenter,
          FLayout.ltr => Alignment.centerLeft,
          FLayout.rtl => Alignment.centerRight,
        },
        heightFactor: widget.side.vertical ? 1 : null,
        widthFactor: widget.side.vertical ? null : 1,
        child: ConstrainedBox(
          constraints: widget.constraints,
          child: NotificationListener<DraggableScrollableNotification>(
            key: _key,
            onNotification: (notification) {
              if (notification.extent == notification.minExtent && notification.shouldCloseOnMinExtent) {
                widget.onClosing?.call();
              }
              return false;
            },
            child: widget.builder(context),
          ),
        ),
      ),
    );

    if (widget.draggable) {
      sheet = SheetGestureDetector(
        layout: widget.side,
        // Allow the sheet to track the user's finger accurately.
        // This cannot be done inside the Sheet widget itself since doing that will interfere with the expansion and
        // collapse animations when initially entering the screen and when dismissing the sheet without dragging.
        onStart: (_) => _curve = Curves.linear,
        onUpdate: _dragUpdate,
        onEnd: _dragEnd,
        child: sheet,
      );
    }

    sheet = switch ((widget.side, widget.useSafeArea)) {
      (FLayout.ttb, true) => SafeArea(top: false, child: sheet),
      (FLayout.btt, true) => SafeArea(bottom: false, child: sheet),
      (FLayout.ltr, true) => SafeArea(left: false, child: sheet),
      (FLayout.rtl, true) => SafeArea(right: false, child: sheet),
      (FLayout.ttb, false) => MediaQuery.removePadding(context: context, removeBottom: true, child: sheet),
      (FLayout.btt, false) => MediaQuery.removePadding(context: context, removeTop: true, child: sheet),
      (FLayout.ltr, false) => MediaQuery.removePadding(context: context, removeRight: true, child: sheet),
      (FLayout.rtl, false) => MediaQuery.removePadding(context: context, removeLeft: true, child: sheet),
    };

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Semantics(
        scopesRoute: true,
        namesRoute: true,
        label: switch (defaultTargetPlatform) {
          TargetPlatform.iOS || TargetPlatform.macOS => null,
          _ => (FLocalizations.of(context) ?? FDefaultLocalizations()).sheetSemanticsLabel,
        },
        explicitChildNodes: true,
        child: ClipRect(
          child: ShiftedSheet(
            side: widget.side,
            onChange: widget.onChange,
            value: _curve.transform(_animation.value),
            mainAxisMaxRatio: widget.mainAxisMaxRatio,
            child: child,
          ),
        ),
      ),
      child: sheet,
    );
  }

  GestureDragUpdateCallback get _dragUpdate => switch (widget.side) {
    FLayout.ttb => (details) {
      if (!_dismissing) {
        _controller.value += details.primaryDelta! / _key.currentChildHeight;
      }
    },
    FLayout.btt => (details) {
      if (!_dismissing) {
        _controller.value -= details.primaryDelta! / _key.currentChildHeight;
      }
    },
    FLayout.ltr => (details) {
      if (!_dismissing) {
        _controller.value += details.primaryDelta! / _key.currentChildWidth;
      }
    },
    FLayout.rtl => (details) {
      if (!_dismissing) {
        _controller.value -= details.primaryDelta! / _key.currentChildWidth;
      }
    },
  };

  GestureDragEndCallback get _dragEnd {
    final double Function(DragEndDetails) velocity = switch (widget.side) {
      FLayout.ttb => (details) => details.primaryVelocity! / _key.currentChildHeight,
      FLayout.btt => (details) => -details.primaryVelocity! / _key.currentChildHeight,
      FLayout.ltr => (details) => details.primaryVelocity! / _key.currentChildWidth,
      FLayout.rtl => (details) => -details.primaryVelocity! / _key.currentChildWidth,
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

      // Allow the sheet to animate smoothly from its current position.
      _curve = Split(_animation.value, endCurve: widget.style.motion.curve);
      if (closing) {
        widget.onClosing?.call();
      }
    };
  }

  bool get _dismissing => _controller.status == AnimationStatus.reverse;

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

extension on GlobalKey {
  double get currentChildWidth => (currentContext!.findRenderObject()! as RenderBox).size.width;

  double get currentChildHeight => (currentContext!.findRenderObject()! as RenderBox).size.height;
}

/// A sheet's style.
abstract class FSheetStyle {
  /// The minimum velocity to initiate a fling. Defaults to 700.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the value is not positive.
  final double flingVelocity;

  /// The threshold for determining whether the sheet is closing. Defaults to 0.5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the value is not in the range `[0, 1]`.
  final double closeProgressThreshold;

  /// Creates a [FSheetStyle].
  const FSheetStyle({this.flingVelocity = 700, this.closeProgressThreshold = 0.5});

  /// The motion-related properties for a sheet.
  FSheetMotion get motion;
}

/// The motion-related properties for a sheet.
abstract class FSheetMotion {
  /// The duration of the sheet's expansion animation. Defaults to 200ms.
  final Duration expandDuration;

  /// The duration of the sheet's collapsing animation. Defaults to 200ms.
  final Duration collapseDuration;

  /// The curve of the sheet's expansion and collapse. Defaults to [Curves.easeOutCubic].
  final Curve curve;

  /// Creates a [FSheetMotion].
  const FSheetMotion({
    this.expandDuration = const Duration(milliseconds: 200),
    this.collapseDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  });
}
