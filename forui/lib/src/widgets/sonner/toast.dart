import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/animated_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class Toast extends StatefulWidget {
  /// The style.
  final FToastStyle style;

  /// The toast's index starting from the back.
  final int index;

  /// A unit vector indicating how a toast's protrusion should be aligned to the toast in front of it.
  ///
  /// For example, `Offset(0, -1)` indicates that the top-center of this toast's protrusion should be aligned to the
  /// top-center of the toast in front of it.
  final Offset alignmentTransform;

  /// The expansion's animation value between `[0, 1]`.
  final double expand;

  /// The toast's content.
  final Widget child;

  const Toast({
    required this.style,
    required this.index,
    required this.alignmentTransform,
    required this.expand,
    required this.child,
    super.key,
  });

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> with TickerProviderStateMixin {
  late final AnimationController _transitionController;
  late final AnimationController _scaleController;
  late final AnimationController _shiftController;
  late Tween<double> _scaleTween;
  late Animation<double> _transition;
  late Animation<double> _scale;
  late Animation<double> _shift;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _transitionController.addListener(() => setState(() {}));
    _transition = _transitionController.drive(CurveTween(curve: widget.style.transitionCurve));
    _transitionController.forward();

    _scaleController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _scaleController.addListener(() => setState(() {}));
    _scaleTween = Tween(begin: widget.index.toDouble(), end: widget.index.toDouble());
    _scale = _scaleTween.animate(CurvedAnimation(parent: _scaleController, curve: widget.style.transitionCurve));

    _shiftController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _shiftController.addListener(() => setState(() {}));
    _shift = _shiftController.drive(CurveTween(curve: widget.style.transitionCurve));
    _shiftController.forward();
  }

  @override
  void didUpdateWidget(Toast old) {
    super.didUpdateWidget(old);
    if (old.style != widget.style) {
      _transitionController.duration = widget.style.transitionDuration;
      _transition = _transitionController.drive(CurveTween(curve: widget.style.transitionCurve));

      _scaleController.duration = widget.style.transitionDuration;
    }

    if (widget.index != old.index) {
      _scaleTween = Tween(begin: _scale.value, end: widget.index.toDouble());
      _scale = _scaleTween.animate(CurvedAnimation(parent: _scaleController, curve: widget.style.transitionCurve));

      _scaleController
        ..reset()
        ..forward();

      _shiftController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _shiftController.dispose();
    _scaleController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alignmentTransform = widget.alignmentTransform;
    final indexTransition = _scale.value;
    final previousIndex = _scaleTween.begin!;
    final collapse = (1.0 - widget.expand) * _transition.value;

    // Slide in
    var fractional = -alignmentTransform * (1.0 - _transition.value);
    // Add dismiss offset
    // fractional += Offset(dismiss, 0);

    var opacity = widget.style.transitionOpacity + (1.0 - widget.style.transitionOpacity) * _transition.value;
    // Fade out the toast behind
    opacity *= pow(widget.style.collapsedOpacity, indexTransition * collapse);
    // Fade out the toast when dismissing
    // opacity *= 1 - dismiss.abs();

    return Animated(
      index: widget.index.toDouble(),
      previousIndex: previousIndex,
      transition: _transition.value,
      scale: indexTransition - previousIndex,
      shift: _shift.value,
      child: FractionalTranslation(
        translation: fractional,
        child: Opacity(opacity: opacity.clamp(0, 1), child: widget.child),
      ),
    );
  }
}
