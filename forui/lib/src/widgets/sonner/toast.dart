import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/animated_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class Toast extends StatefulWidget {
  final FToastStyle style;
  final int index;
  final Offset behindTransform;
  final double expand;
  final Widget child;

  const Toast({
    required this.style,
    required this.index,
    required this.behindTransform,
    required this.expand,
    required this.child,
    super.key,
  });

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> with TickerProviderStateMixin {
  late final AnimationController _transitionController;
  late final AnimationController _indexTransitionController;
  late Tween<double> _indexTransitionTween;
  late Animation<double> _transition;
  late Animation<double> _indexTransition;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _transitionController.addListener(() => setState(() {}));
    _transition = _transitionController.drive(CurveTween(curve: widget.style.transitionCurve));
    _transitionController.forward();

    _indexTransitionController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _indexTransitionController.addListener(() => setState(() {}));
    _indexTransitionTween = Tween(begin: widget.index.toDouble(), end: widget.index.toDouble());
    _indexTransition = _indexTransitionTween.animate(
      CurvedAnimation(parent: _indexTransitionController, curve: widget.style.transitionCurve),
    );
  }

  @override
  void didUpdateWidget(Toast old) {
    super.didUpdateWidget(old);
    if (old.style != widget.style) {
      _transitionController.duration = widget.style.transitionDuration;
      _transition = _transitionController.drive(CurveTween(curve: widget.style.transitionCurve));

      _indexTransitionController.duration = widget.style.transitionDuration;
    }

    if (widget.index != old.index) {
      _indexTransitionTween = Tween(begin: _indexTransition.value, end: widget.index.toDouble());
      _indexTransition = _indexTransitionTween.animate(
        CurvedAnimation(parent: _indexTransitionController, curve: widget.style.transitionCurve),
      );

      _indexTransitionController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _indexTransitionController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final behindTransform = widget.behindTransform;
    final indexTransition = _indexTransition.value;
    final previousIndex = _indexTransitionTween.begin!;
    final collapse = (1.0 - widget.expand) * _transition.value;

    // Shift up/down when behind another toast
    final collapsedOffset = widget.style.collapsedOffset;
    var offset = collapsedOffset.scale(behindTransform.dx, behindTransform.dy) * collapse * indexTransition;
    // // Shift up/down when expanding/collapsing
    // offset = behindTransform * 16 * widget.expand;
    // // Add spacing when expanded
    // offset += behindTransform * widget.style.spacing * widget.expand * index;

    // Slide in
    var fractional = -behindTransform * (1.0 - _transition.value);
    // Add dismiss offset
    // fractional += Offset(dismiss, 0);
    // // Shift up/down when behinddfix another toast & expanded
    fractional +=
        behindTransform * widget.expand * indexTransition; // TODO: Using different sized children will break this.

    var opacity = widget.style.transitionOpacity + (1.0 - widget.style.transitionOpacity) * _transition.value;
    // Fade out the toast behind
    opacity *= pow(widget.style.collapsedOpacity, indexTransition * collapse);
    // Fade out the toast when dismissing
    // opacity *= 1 - dismiss.abs();

    return Animated(
      indexTransition: indexTransition - previousIndex,
      previousIndex: previousIndex,
      child: Transform.translate(
        offset: offset,
        child: FractionalTranslation(translation: fractional, child: Opacity(opacity: opacity, child: widget.child)),
      ),
    );
  }
}
