import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/animated_toaster_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class AnimatedToast extends StatefulWidget {
  /// The style.
  final FSonnerToastStyle style;

  /// A unit vector indicating how a toast's protrusion should be aligned to the toast in front of it.
  ///
  /// For example, `Offset(0, -1)` indicates that the top-center of this toast's protrusion should be aligned to the
  /// top-center of the toast in front of it.
  final Offset alignTransform;

  /// The toast's index starting from the back.
  final int index;

  /// The total number of toasts.
  final int length;

  /// The toast's show duration.
  final Duration? duration;

  /// The expansion animation, between `[0, 1]`.
  final double expand;

  /// True if the toast is visible.
  final bool visible;

  /// True if the toast should be auto dismissed.
  final bool autoDismiss;

  /// A value that indicates whether the toast is dismissing.
  final ValueListenable<bool> dismissing;

  /// A callback that is called when the toast is closed.
  final VoidCallback onDismiss;

  /// The content.
  final Widget child;

  const AnimatedToast({
    required this.style,
    required this.alignTransform,
    required this.index,
    required this.length,
    required this.duration,
    required this.expand,
    required this.visible,
    required this.autoDismiss,
    required this.dismissing,
    required this.onDismiss,
    required this.child,
    super.key,
  });

  @override
  State<AnimatedToast> createState() => _AnimatedToastState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignTransform', alignTransform))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(PercentProperty('expand', expand))
      ..add(FlagProperty('visible', value: visible, ifTrue: 'visible'))
      ..add(FlagProperty('autoDismiss', value: autoDismiss, ifTrue: 'autoDismiss'))
      ..add(DiagnosticsProperty('dismissing', dismissing))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss));
  }
}

class _AnimatedToastState extends State<AnimatedToast> with TickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _entranceExitController;
  late CurvedAnimation _entranceExit;
  late final AnimationController _transitionController;
  late CurvedAnimation _transition;
  late final AnimationController _visibleController;
  late CurvedAnimation _visible;

  int _signal = 0; // Used to signal to [RenderAnimatedToaster] that a toast has been updated.

  @override
  void initState() {
    super.initState();
    widget.dismissing.addListener(_dismissing);
    if (widget.dismissing.value) {
      _entranceExitController.value = 1;
    }

    if (widget.duration case final duration?) {
      _timer = Timer(duration, _dismissing);
    }

    _entranceExitController =
        AnimationController(vsync: this, duration: widget.style.enterExitDuration)
          ..forward()
          ..addListener(() => setState(() {}))
          ..addStatusListener(_dismiss);
    _entranceExit = CurvedAnimation(
      parent: _entranceExitController,
      curve: widget.style.enterCurve,
      reverseCurve: widget.style.exitCurve,
    );

    _transitionController =
        AnimationController(vsync: this, duration: widget.style.transitionDuration)
          ..forward()
          ..addListener(() => setState(() {}));
    _transition = CurvedAnimation(parent: _transitionController, curve: widget.style.transitionCurve);
    _transitionController.forward();

    _visibleController =
        AnimationController(vsync: this, duration: widget.style.transitionDuration)
          ..value = widget.visible ? 1 : 0
          ..addListener(() => setState(() {}));
    _visible = CurvedAnimation(parent: _visibleController, curve: widget.style.transitionCurve);
  }

  @override
  void didUpdateWidget(AnimatedToast old) {
    super.didUpdateWidget(old);
    if (widget.dismissing != old.dismissing) {
      old.dismissing.removeListener(_dismissing);
      widget.dismissing.addListener(_dismissing);
    }

    if (widget.style != old.style) {
      _entranceExitController.duration = widget.style.enterExitDuration;
      _entranceExit = CurvedAnimation(
        parent: _entranceExitController,
        curve: widget.style.enterCurve,
        reverseCurve: widget.style.exitCurve,
      );

      _transitionController.duration = widget.style.transitionDuration;
      _transition = CurvedAnimation(parent: _transitionController, curve: widget.style.transitionCurve);

      _signal++;
    }

    if (widget.index != old.index) {
      _transitionController
        ..reset()
        ..forward();
      _signal++;
    }

    if (widget.autoDismiss != old.autoDismiss) {
      if (widget.autoDismiss) {
        _resume(Duration(milliseconds: (widget.length - widget.index - 1) * 300));
      } else {
        _timer?.cancel();
      }
    }

    if (widget.visible != old.visible) {
      widget.visible ? _visibleController.forward() : _visibleController.reverse();
    }
  }

  void _dismissing() => _entranceExitController.reverse();

  void _dismiss(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.onDismiss();
    }
  }

  void _resume([Duration stagger = Duration.zero]) {
    if (widget.duration case final duration?) {
      _timer?.cancel();
      _timer = Timer(duration + stagger, _dismissing);
    }
  }

  @override
  void dispose() {
    widget.dismissing.removeListener(_dismissing);
    _visible.dispose();
    _visibleController.dispose();
    _transition.dispose();
    _transitionController.dispose();
    _entranceExit.dispose();
    _entranceExitController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slide in & out during entrance & exit.
    final entranceExit = -widget.alignTransform * (1.0 - _entranceExit.value);

    // Gradually increase & decrease opacity during entrance & exit.
    final opacity = lerpDouble(widget.style.entranceExitOpacity, 1.0, _entranceExit.value)! * _visible.value;

    return AnimatedToastData(
      index: widget.index,
      transition: _transition.value,
      visible: widget.visible,
      signal: _signal,
      child: IgnorePointer(
        ignoring: !widget.visible,
        child: ConstrainedBox(
          constraints: widget.style.constraints,
          child: MouseRegion(
            onEnter: (_) => _timer?.cancel(),
            onExit: (_) => _resume(),
            child: FractionalTranslation(
              translation: entranceExit,
              child: Opacity(opacity: opacity, child: widget.child),
            ),
          ),
        ),
      ),
    );
  }
}
