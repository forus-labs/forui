import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/collection.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/toast/animated_toaster.dart';
import 'package:forui/src/widgets/toast/animated_toaster_parent_data.dart';
import 'package:forui/src/widgets/toast/toaster_stack.dart';

@internal
class AnimatedToast extends StatefulWidget {
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

  /// The directions which to swipe to dismiss the toast.
  final List<AxisDirection> swipeToDismiss;

  /// The toast's show duration.
  final Duration? duration;

  /// The expansion animation, between `[0, 1]`.
  final double expand;

  /// True if the toast is visible.
  final bool visible;

  /// True if the toast should be auto dismissed.
  final bool autoDismiss;

  /// A value that indicates whether a toast is current being swiping.
  final ValueNotifier<Swipe> swiping;

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
    required this.swipeToDismiss,
    required this.duration,
    required this.expand,
    required this.visible,
    required this.autoDismiss,
    required this.swiping,
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
      ..add(IterableProperty('swipeToDismiss', swipeToDismiss))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(PercentProperty('expand', expand))
      ..add(FlagProperty('visible', value: visible, ifTrue: 'visible'))
      ..add(FlagProperty('autoDismiss', value: autoDismiss, ifTrue: 'autoDismiss'))
      ..add(DiagnosticsProperty('swiping', swiping))
      ..add(DiagnosticsProperty('dismissing', dismissing))
      ..add(ObjectFlagProperty.has('onDismiss', onDismiss));
  }
}

class _AnimatedToastState extends State<AnimatedToast> with TickerProviderStateMixin {
  static const _horizontal = [AxisDirection.left, AxisDirection.right];
  static const _vertical = [AxisDirection.up, AxisDirection.down];

  Timer? _timer;
  late final AnimationController _entranceDismissController;
  late final AnimationController _transitionController;
  late final AnimationController _visibleController;
  late final AnimationController _swipeCompletionController;
  late CurvedAnimation _curvedEntranceDismiss;
  late CurvedAnimation _transition;
  late CurvedAnimation _visible;
  late CurvedAnimation _swipeCompletion;
  late Animation<double> _entranceDismiss;

  /// The current offset of the toast when swiping, normalized as a fraction of the toast's height/width. It is always
  /// in the range [-1, 1].
  ///
  /// If the toast is swiped to the left/top, it will be negative, and if it is swiped to the right/bottom, it will be
  /// positive.
  Offset _swipeFraction = Offset.zero;

  /// The offset that the toast should be at when the swipe animation is completed.
  Offset _swipeFractionEnd = Offset.zero;

  /// Used to signal to [RenderAnimatedToaster] that a toast has been updated.
  int _signal = 0;

  @override
  void initState() {
    super.initState();
    widget.dismissing.addListener(_startDismissing);
    if (widget.dismissing.value) {
      _entranceDismissController.value = 1;
    }

    if (widget.duration case final duration?) {
      _timer = Timer(duration, _startDismissing);
    }

    _entranceDismissController =
        AnimationController(
            vsync: this,
            duration: widget.style.motion.entranceDuration,
            reverseDuration: widget.style.motion.dismissDuration,
          )
          ..forward()
          ..addListener(() => setState(() {}))
          ..addStatusListener(_dismiss);
    _transitionController = AnimationController(vsync: this, duration: widget.style.motion.transitionDuration)
      ..forward()
      ..addListener(() => setState(() {}));
    _visibleController =
        AnimationController(
            vsync: this,
            duration: widget.style.motion.reentranceDuration,
            reverseDuration: widget.style.motion.exitDuration,
          )
          ..value = widget.visible ? 1 : 0
          ..addListener(() => setState(() {}));
    _swipeCompletionController = AnimationController(vsync: this, duration: widget.style.motion.swipeCompletionDuration)
      ..addListener(() => setState(() {}))
      ..addStatusListener(_completeSwipe);

    _curvedEntranceDismiss = CurvedAnimation(
      parent: _entranceDismissController,
      curve: widget.style.motion.entranceCurve,
      reverseCurve: widget.style.motion.dismissCurve,
    );
    _transition = CurvedAnimation(parent: _transitionController, curve: widget.style.motion.transitionCurve);
    _visible = CurvedAnimation(
      parent: _visibleController,
      curve: widget.style.motion.reentranceCurve,
      reverseCurve: widget.style.motion.exitCurve,
    );
    _swipeCompletion = CurvedAnimation(
      parent: _swipeCompletionController,
      curve: widget.style.motion.swipeCompletionCurve,
    );
    _entranceDismiss = widget.style.motion.entranceDismissFadeTween.animate(_curvedEntranceDismiss);
  }

  @override
  void didUpdateWidget(AnimatedToast old) {
    super.didUpdateWidget(old);
    if (widget.dismissing != old.dismissing) {
      old.dismissing.removeListener(_startDismissing);
      widget.dismissing.addListener(_startDismissing);
    }

    if (widget.style != old.style) {
      _entranceDismissController
        ..duration = widget.style.motion.entranceDuration
        ..reverseDuration = widget.style.motion.dismissDuration;
      _transitionController
        ..duration = widget.style.motion.reentranceDuration
        ..reverseDuration = widget.style.motion.exitDuration;

      _curvedEntranceDismiss = CurvedAnimation(
        parent: _entranceDismissController,
        curve: widget.style.motion.entranceCurve,
        reverseCurve: widget.style.motion.dismissCurve,
      );
      _transition = CurvedAnimation(
        parent: _transitionController,
        curve: widget.style.motion.reentranceCurve,
        reverseCurve: widget.style.motion.exitCurve,
      );

      _entranceDismiss = widget.style.motion.entranceDismissFadeTween.animate(_curvedEntranceDismiss);

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
        _resumeDismissing(Duration(milliseconds: (widget.length - widget.index - 1) * 300));
      } else {
        _timer?.cancel();
      }
    }

    if (widget.visible != old.visible) {
      widget.visible ? _visibleController.forward() : _visibleController.reverse();
    }
  }

  void _completeSwipe(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      // Reset the swipe fraction to zero if the swipe was not completed.
      if (_swipeFractionEnd == Offset.zero) {
        setState(() {
          _swipeFraction = Offset.zero;
          _swipeCompletionController.reset();
          _resumeDismissing();
        });
      } else {
        // If the swipe was completed, we need to dismiss the toast.
        widget.onDismiss();
      }
    }
  }

  void _startDismissing() => _entranceDismissController.reverse();

  void _resumeDismissing([Duration stagger = Duration.zero]) {
    if (widget.duration case final duration?) {
      _timer?.cancel();
      _timer = Timer(duration + stagger, _startDismissing);
    }
  }

  void _dismiss(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    widget.dismissing.removeListener(_startDismissing);
    _swipeCompletion.dispose();
    _swipeCompletionController.dispose();
    _visible.dispose();
    _visibleController.dispose();
    _transition.dispose();
    _transitionController.dispose();
    _curvedEntranceDismiss.dispose();
    _entranceDismissController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slide in & out during entrance & exit.
    var translation = -widget.alignTransform * (1.0 - _curvedEntranceDismiss.value);
    // Slide out during swiping to dismiss.
    translation += Offset.lerp(_swipeFraction, _swipeFractionEnd, _swipeCompletion.value)!;

    // Gradually increase & decrease opacity during entrance & exit.
    var opacity = _entranceDismiss.value * _visible.value;
    // Gradually decrease opacity during swiping to dismiss.
    opacity *= 1 - _swipeFraction.distance.abs();

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
            onExit: (_) {
              if (widget.autoDismiss) {
                _resumeDismissing();
              }
            },
            child: GestureDetector(
              onHorizontalDragStart: (_) {
                if (!disjoint(widget.swipeToDismiss, _horizontal)) {
                  _timer?.cancel();
                  widget.swiping.value = widget.swiping.value.start();
                }
              },
              onHorizontalDragUpdate: (details) {
                if (widget.swipeToDismiss.contains(AxisDirection.left)) {
                  setState(() {
                    final offset = _swipeFraction + Offset(details.primaryDelta! / context.size!.width, 0);
                    _swipeFraction = Offset(offset.dx.clamp(-1.1, 0.05), offset.dy);
                  });
                } else if (widget.swipeToDismiss.contains(AxisDirection.right)) {
                  setState(() {
                    final offset = _swipeFraction + Offset(details.primaryDelta! / context.size!.width, 0);
                    _swipeFraction = Offset(offset.dx.clamp(-0.05, 1.1), offset.dy);
                  });
                }
              },
              onHorizontalDragEnd: (_) {
                if (!disjoint(widget.swipeToDismiss, _horizontal)) {
                  _swipeFractionEnd = switch (_swipeFraction.dx) {
                    < -0.5 => const Offset(-1, 0),
                    > 0.5 => const Offset(1, 0),
                    _ => Offset.zero,
                  };
                  _swipeCompletionController.forward();
                  widget.swiping.value = widget.swiping.value.end();
                }
              },
              onVerticalDragStart: (_) {
                if (!disjoint(widget.swipeToDismiss, _vertical)) {
                  _timer?.cancel();
                  widget.swiping.value = widget.swiping.value.start();
                }
              },
              onVerticalDragUpdate: (details) {
                if (widget.swipeToDismiss.contains(AxisDirection.up)) {
                  setState(() {
                    final offset = _swipeFraction + Offset(0, details.primaryDelta! / context.size!.height);
                    _swipeFraction = Offset(offset.dx, offset.dy.clamp(-1.1, 0.05));
                  });
                } else if (widget.swipeToDismiss.contains(AxisDirection.down)) {
                  setState(() {
                    final offset = _swipeFraction + Offset(0, details.primaryDelta! / context.size!.height);
                    _swipeFraction = Offset(offset.dx, offset.dy.clamp(-0.05, 1.1));
                  });
                }
              },
              onVerticalDragEnd: (_) {
                if (!disjoint(widget.swipeToDismiss, _vertical)) {
                  _swipeFractionEnd = switch (_swipeFraction.dy) {
                    < -0.5 => const Offset(0, -1),
                    > 0.5 => const Offset(0, 1),
                    _ => Offset.zero,
                  };
                  _swipeCompletionController.forward();
                  widget.swiping.value = widget.swiping.value.end();
                }
              },
              child: FractionalTranslation(
                translation: translation,
                child: Opacity(opacity: opacity.clamp(0, 1), child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
