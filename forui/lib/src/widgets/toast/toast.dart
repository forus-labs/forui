import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

@internal
class Toast extends StatefulWidget {
  final FToastStyle style;
  final int index;
  final int length;
  final Alignment behindAlignment;
  final Duration duration;
  final bool expanded;
  final bool dismissible;
  final ValueListenable<bool> closing;
  final VoidCallback onClosing;
  final VoidCallback onClose;
  final Widget child;

  const Toast({
    required this.style,
    required this.index,
    required this.length,
    required this.behindAlignment,
    required this.duration,
    required this.expanded,
    required this.dismissible,
    required this.closing,
    required this.onClosing,
    required this.onClose,
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
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length))
      ..add(DiagnosticsProperty('behindAlignment', behindAlignment))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(FlagProperty('expanded', value: expanded, ifTrue: 'expanded'))
      ..add(FlagProperty('dismissible', value: dismissible, ifTrue: 'dismissible'))
      ..add(DiagnosticsProperty('closing', closing))
      ..add(ObjectFlagProperty.has('onClosing', onClosing))
      ..add(ObjectFlagProperty.has('onClose', onClose));
  }
}

class _ToastState extends State<Toast> {
  late Timer _timer;
  bool _dismissing = false;
  double _dismiss = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, widget.onClosing);
  }

  @override
  void didUpdateWidget(covariant Toast old) {
    super.didUpdateWidget(old);
    if (widget.expanded != old.expanded) {
      if (widget.expanded) {
        _timer.cancel();
      } else {
        _resume(Duration(milliseconds: (widget.length - widget.index - 1) * 500));
      }
    }
  }

  void _resume([Duration stagger = Duration.zero]) {
    _timer.cancel();
    _timer = Timer(widget.duration + stagger, widget.onClosing);
  }

  @override
  Widget build(BuildContext context) {
    // TODO improve exit animation -> Needs to fade out more?
    Widget toast = ValueListenableBuilder(
      valueListenable: widget.closing,
      // This isn't the most ideal for performance but manually managing several animation controllers isn't worth it.
      builder:
          (_, closing, _) => TweenAnimationBuilder(
            tween: Tween(end: closing ? 0.0 : _dismiss),
            curve: widget.style.dismissCurve,
            duration: _dismissing ? Duration.zero : widget.style.dismissDuration,
            onEnd: (_dismiss == 1 || _dismiss == -1) ? widget.onClose : null,
            builder:
                (_, dismiss, _) => TweenAnimationBuilder(
                  tween: Tween(end: widget.expanded ? 1.0 : 0.0),
                  curve: widget.style.expandCurve,
                  duration: widget.style.expandDuration,
                  builder:
                      (_, expand, _) => TweenAnimationBuilder(
                        tween: Tween(begin: widget.index > 0 ? 1.0 : 0.0, end: closing && !_dismissing ? 0.0 : 1.0),
                        curve: widget.style.transitionCurve,
                        duration: widget.style.transitionDuration,
                        onEnd: closing ? widget.onClose : null,
                        builder:
                            (_, transition, _) => TweenAnimationBuilder(
                              tween: Tween(end: widget.index.toDouble()),
                              curve: widget.style.transitionCurve,
                              duration: widget.style.transitionDuration,
                              builder: (_, index, _) => _toast(dismiss, expand, transition, index),
                            ),
                      ),
                ),
          ),
    );

    // toast = MouseRegion(
    //   hitTestBehavior: HitTestBehavior.deferToChild,
    //   onEnter: (_) => _timer.cancel(),
    //   onExit: (_) => _resume(),
    //   child: toast,
    // );

    if (false) {
      toast = GestureDetector(
        onHorizontalDragStart:
            (_) => setState(() {
              _timer.cancel();
              _dismissing = true;
            }),
        onHorizontalDragUpdate: (details) => setState(() => _dismiss += details.primaryDelta! / context.size!.width),
        onHorizontalDragEnd:
            (_) => setState(() {
              _dismissing = false;
              switch (_dismiss) {
                case < -0.5:
                  _dismiss = -1;
                case > 0.5:
                  _dismiss = 1;
                default:
                  _dismiss = 0;
                  _resume();
              }
            }),
        child: toast,
      );
    }

    return toast;
  }

  Widget _toast(double dismiss, double expand, double transition, double index) {
    final collapse = (1.0 - expand) * transition;
    final behindTransform = Offset(widget.behindAlignment.x, widget.behindAlignment.y);

    // Shift up/down when behind another toast
    var offset = widget.style.collapsedOffset.scale(behindTransform.dx, behindTransform.dy) * collapse * index;
    // Shift up/down when expanding/collapsing
    offset += behindTransform * 16 * expand;
    // Add spacing when expanded
    offset += behindTransform * widget.style.spacing * expand * index;

    // Slide in
    var fractional = -behindTransform * (1.0 - transition);
    // Add dismiss offset
    // fractional += Offset(dismiss, 0);
    // // Shift up/down when behind another toast & expanded
    // fractional += behindTransform * expand * index;

    var opacity = widget.style.transitionOpacity + (1.0 - widget.style.transitionOpacity) * transition;
    // Fade out the toast behind
    opacity *= pow(widget.style.collapsedOpacity, index * collapse);
    // Fade out the toast when dismissing
    opacity *= 1 - dismiss.abs();

    final scale = 1.0 * pow(widget.style.collapsedScale, index * (1 - expand));

    return Transform.translate(
      offset: offset,
      child: FractionalTranslation(
        translation: fractional,
        child: Opacity(opacity: opacity.clamp(0, 1), child: Transform.scale(scale: scale, child: widget.child)),
      ),
    );
  }
}
