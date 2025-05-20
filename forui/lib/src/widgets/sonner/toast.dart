import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/animated_toaster_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class Toast extends StatefulWidget {
  /// The style.
  final FToastStyle style;

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
  final Duration duration;

  /// The expansion animation, between `[0, 1]`.
  final double expand;

  /// A value that indicates whether the toast is dismissing.
  final ValueListenable<bool> dismissing;

  /// A callback that is called when the toast is closed.
  final VoidCallback onDismiss;

  /// The content.
  final Widget child;

  const Toast({
    required this.style,
    required this.alignTransform,
    required this.index,
    required this.length,
    required this.duration,
    required this.expand,
    required this.dismissing,
    required this.onDismiss,
    required this.child,
    super.key,
  });

  @override
  State<Toast> createState() => _ToastState();

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
      ..add(DiagnosticsProperty('dismissing', dismissing))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss));
  }
}

class _ToastState extends State<Toast> with TickerProviderStateMixin {
  late Timer _timer;
  late final AnimationController _entranceExitController;
  late Animation<double> _entranceExit;
  late final AnimationController _transitionController;
  late Animation<double> _transition;

  int _signal = 0; // Used to signal to [RenderAnimatedToaster] that a toast has been updated.

  @override
  void initState() {
    super.initState();
    widget.dismissing.addListener(_dismissing);
    _timer = Timer(widget.duration, _dismissing);

    _entranceExitController =
        AnimationController(vsync: this, duration: widget.style.entranceExitDuration)
          ..addListener(() => setState(() {}))
          ..addStatusListener(_dismiss)
          ..forward();
    _entranceExit = CurvedAnimation(
      parent: _entranceExitController,
      curve: widget.style.entranceCurve,
      reverseCurve: widget.style.exitCurve,
    );

    _transitionController =
        AnimationController(vsync: this, duration: widget.style.transitionDuration)
          ..addListener(() => setState(() {}))
          ..forward();
    _transition = CurvedAnimation(parent: _transitionController, curve: widget.style.transitionCurve);
    _transitionController.forward();
  }

  @override
  void didUpdateWidget(Toast old) {
    super.didUpdateWidget(old);
    if (widget.dismissing != old.dismissing) {
      old.dismissing.removeListener(_dismissing);
      widget.dismissing.addListener(_dismissing);
    }

    if (widget.style != old.style) {
      _entranceExitController.duration = widget.style.entranceExitDuration;
      _entranceExit = CurvedAnimation(
        parent: _entranceExitController,
        curve: widget.style.entranceCurve,
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

    if (widget.expand != old.expand) {
      if (0 < widget.expand) {
        _timer.cancel();
      } else {
        _resume(Duration(milliseconds: (widget.length - widget.index - 1) * 300));
      }
    }
  }

  void _dismissing() => _entranceExitController.reverse();

  void _dismiss(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.onDismiss();
    }
  }

  void _resume([Duration stagger = Duration.zero]) {
    _timer.cancel();
    _timer = Timer(widget.duration + stagger, _dismissing);
  }

  @override
  void dispose() {
    widget.dismissing.removeListener(_dismissing);
    _transitionController.dispose();
    _entranceExitController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slide in & out during entrance & exit.
    final entranceExit = -widget.alignTransform * (1.0 - _entranceExit.value);

    // Gradually increase & decrease opacity during entrance & exit.
    final opacity = lerpDouble(widget.style.entranceExitOpacity, 1.0, _entranceExit.value)!;

    return AnimatedToast(
      index: widget.index,
      transition: _transition.value,
      signal: _signal,
      child: ConstrainedBox(
        constraints: widget.style.constraints,
        child: MouseRegion(
          onEnter: (_) => _timer.cancel(),
          onExit: (_) => _resume(),
          child: FractionalTranslation(translation: entranceExit, child: Opacity(opacity: opacity, child: widget.child)),
        ),
      ),
    );
  }
}
