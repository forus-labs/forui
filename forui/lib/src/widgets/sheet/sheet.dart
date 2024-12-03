import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/sheet/shifted_sheet.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/gesture_detector.dart';

@internal
class Sheet extends StatefulWidget {
  static AnimationController createAnimationController(TickerProvider vsync, FSheetStyle style) => AnimationController(
        duration: style.enterDuration,
        reverseDuration: style.exitDuration,
        vsync: vsync,
      );

  static void _onClosing() {}

  final AnimationController? controller;
  final Animation<double>? animation;
  final FSheetStyle style;
  final Layout side;
  final double? mainAxisMaxRatio;
  final BoxConstraints constraints;
  final bool draggable;
  final WidgetBuilder builder;
  final ValueChanged<Size>? onChange;
  final VoidCallback onClosing;

  const Sheet({
    required this.controller,
    required this.style,
    required this.side,
    required this.mainAxisMaxRatio,
    required this.builder,
    this.animation,
    this.constraints = const BoxConstraints(),
    this.draggable = true,
    this.onChange,
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
      ..add(DiagnosticsProperty('animation', animation))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('mainAxisMaxRatio', mainAxisMaxRatio))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(FlagProperty('draggable', value: draggable, ifTrue: 'draggable'))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onClosing', onClosing));
  }
}

class _SheetState extends State<Sheet> with SingleTickerProviderStateMixin {
  static const _cubic = Cubic(0.0, 0.0, 0.2, 1.0);

  final GlobalKey _key = GlobalKey(debugLabel: 'Sheet child');
  late AnimationController _controller;
  late Animation<double> _animation;
  ParametricCurve<double> _curve = _cubic;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? Sheet.createAnimationController(this, widget.style);
    _animation = widget.animation ?? _controller.view;
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
    assert(debugCheckHasMediaQuery(context), '');

    Widget sheet = Align(
      alignment: switch (widget.side) {
        Layout.ttb => Alignment.topCenter,
        Layout.btt => Alignment.bottomCenter,
        Layout.ltr => Alignment.centerLeft,
        Layout.rtl => Alignment.centerRight,
      },
      heightFactor: widget.side.vertical ? 1 : null,
      widthFactor: widget.side.vertical ? null : 1,
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
        layout: widget.side,
        // Allow the sheet to track the user's finger accurately.
        onStart: (details) => _curve = Curves.linear,
        onUpdate: _dragUpdate,
        // Allow the sheet to animate smoothly from its current position.
        onEnd: _dragEnd,
        child: sheet,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Semantics(
        scopesRoute: true,
        namesRoute: true,
        label: switch (defaultTargetPlatform) {
          TargetPlatform.iOS || TargetPlatform.macOS => null,
          _ => FLocalizations.of(context).dialogLabel,
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
    final double Function(DragEndDetails) velocity = switch (widget.side) {
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

      // Allow the sheet to animate smoothly from its current position.
      _curve = Split(_animation.value, endCurve: _cubic);
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
