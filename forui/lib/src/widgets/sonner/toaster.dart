import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/toast.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/sonner/animated_toaster.dart';

/// A toaster is responsible for managing a stack of toasts, including the expanding & transitioning animations.
///
/// The actual positioning of toasts is delegated to [AnimatedToaster].
@internal
class Toaster extends StatefulWidget {
  final FToastStyle style;
  final Offset shiftTransform;
  final List<Widget> children;

  const Toaster({required this.style, required this.shiftTransform, required this.children, super.key});

  @override
  State<Toaster> createState() => _ToasterState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

class _ToasterState extends State<Toaster> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expand;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.style.expandDuration);
    _controller.addListener(() => setState(() {}));
    _expand = _controller.drive(CurveTween(curve: widget.style.expandCurve));
  }

  @override
  void didUpdateWidget(Toaster oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style) {
      _controller.duration = widget.style.expandDuration;
      _expand = _controller.drive(CurveTween(curve: widget.style.expandCurve));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      MouseRegion(
        onEnter: (_) => _controller.forward(),
        onExit: (_) => _controller.reverse(),
        child: AnimatedToaster(
          behindTransform: widget.shiftTransform,
          expand: _expand.value,
          children: [
            for (final (index, child) in widget.children.reversed.indexed)
              Toast(
                  style: widget.style, index: widget.children.length - 1 - index, expand: _expand.value, child: child),
          ],
        ),
      );
}
