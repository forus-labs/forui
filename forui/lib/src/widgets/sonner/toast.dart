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
  late final AnimationController _indexController;
  late Tween<double> _indexTween;
  late Animation<double> _transition;
  late Animation<double> _index;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _transitionController.addListener(() => setState(() {}));
    _transition = _transitionController.drive(CurveTween(curve: widget.style.transitionCurve));
    _transitionController.forward();

    _indexController = AnimationController(vsync: this, duration: widget.style.transitionDuration);
    _indexController.addListener(() => setState(() {}));
    _indexTween = Tween(begin: widget.index.toDouble(), end: widget.index.toDouble());
    _index = _indexTween.animate(CurvedAnimation(parent: _indexController, curve: widget.style.transitionCurve));
  }

  @override
  void didUpdateWidget(Toast old) {
    super.didUpdateWidget(old);
    if (old.style != widget.style) {
      _transitionController.duration = widget.style.transitionDuration;
      _transition = _transitionController.drive(CurveTween(curve: widget.style.transitionCurve));

      _indexController.duration = widget.style.transitionDuration;
    }

    if (widget.index != old.index) {
      _indexTween = Tween(begin: _index.value, end: widget.index.toDouble());
      _index = _indexTween.animate(CurvedAnimation(parent: _indexController, curve: widget.style.transitionCurve));
      _indexController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _indexController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _toast(_index.value);

  Widget _toast(double index) {
    final collapse = (1.0 - widget.expand) * _transition.value;

    // Shift up/down when behind another toast
    var offset =
        widget.style.collapsedOffset.scale(widget.behindTransform.dx, widget.behindTransform.dy) * collapse * index;
    // // Shift up/down when expanding/collapsing
    // offset = behindTransform * 16 * widget.expand;
    // // Add spacing when expanded
    // offset += behindTransform * widget.style.spacing * widget.expand * index;

    // Slide in
    var fractional = -widget.behindTransform * (1.0 - _transition.value);
    // Add dismiss offset
    // fractional += Offset(dismiss, 0);
    // // Shift up/down when behinddfix another toast & expanded
    fractional +=
        widget.behindTransform * widget.expand * index; // TODO: Using different sized children will break this.

    var opacity = widget.style.transitionOpacity + (1.0 - widget.style.transitionOpacity) * _transition.value;
    // Fade out the toast behind
    opacity *= pow(widget.style.collapsedOpacity, index * collapse);
    // Fade out the toast when dismissing
    // opacity *= 1 - dismiss.abs();

    return Animated(
      index: index - _indexTween.begin!,
      previous: _indexTween.begin!,
      child: Transform.translate(
        offset: offset,
        child: FractionalTranslation(translation: fractional, child: Opacity(opacity: opacity, child: widget.child)),
      ),
    );
  }
}
