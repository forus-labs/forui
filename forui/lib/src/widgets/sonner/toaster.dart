import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/animated_toaster.dart';
import 'package:forui/src/widgets/sonner/sonner.dart';
import 'package:forui/src/widgets/sonner/toast.dart';
import 'package:meta/meta.dart';

/// A toaster is responsible for managing a stack of toasts, including the expanding animations.
///
/// The actual positioning of toasts is delegated to [AnimatedToaster].
@internal
class Toaster extends StatefulWidget {
  final FSonnerStyle style;
  final Offset alignTransform;
  final List<ToastEntry> entries;

  const Toaster({required this.style, required this.alignTransform, required this.entries, super.key});

  @override
  State<Toaster> createState() => _ToasterState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('alignTransform', alignTransform))
      ..add(IterableProperty('entries', entries));
  }
}

class _ToasterState extends State<Toaster> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expand;
  int _monotonic = 0;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.style.expandDuration)
      ..addListener(() => setState(() {}));
    _expand = _controller.drive(CurveTween(curve: widget.style.expandCurve));

    if (widget.style.expandBehavior == FSonnerExpandBehavior.always) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(Toaster old) {
    super.didUpdateWidget(old);
    if (old.style != widget.style) {
      _controller.duration = widget.style.expandDuration;
      _expand = _controller.drive(CurveTween(curve: widget.style.expandCurve));
    }

    if (widget.style.expandBehavior != old.style.expandBehavior) {
      if (widget.style.expandBehavior == FSonnerExpandBehavior.always) {
        _controller.value = 1;
      } else if (widget.style.expandBehavior == FSonnerExpandBehavior.disabled) {
        _controller.value = 0;
      }
    }

    if (widget.entries.isEmpty && widget.style.expandBehavior == FSonnerExpandBehavior.onHoverOrPressed) {
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget toaster = AnimatedToaster(
      style: widget.style,
      alignTransform: widget.alignTransform,
      expand: _expand.value,
      children: [
        for (final (index, entry) in widget.entries.reversed.indexed)
          Toast(
            key: entry.key,
            style: entry.style ?? widget.style.toastStyle,
            alignTransform: widget.alignTransform,
            index: widget.entries.length - 1 - index,
            length: widget.entries.length,
            duration: entry.duration,
            expand: _expand.value,
            dismissing: entry.dismissing,
            onDismiss: entry.onDismiss!,
            child: entry.builder(context, entry),
          ),
      ],
    );

    if (widget.style.expandBehavior == FSonnerExpandBehavior.onHoverOrPressed) {
      toaster = MouseRegion(
        onEnter: (_) => _enter(),
        onExit: (_) => _exit(),
        child: GestureDetector(
          onTap: () {
            if (!_hovered) {
              _controller.isForwardOrCompleted ? _controller.reverse() : _controller.forward();
            }
          },
          child: toaster,
        ),
      );
    }

    return toaster;
  }

  Future<void> _enter() async {
    final fencingToken = ++_monotonic;
    _hovered = true;
    await Future.delayed(widget.style.expandHoverEnterDuration);

    if (fencingToken == _monotonic && mounted) {
      await _controller.forward();
    }
  }

  Future<void> _exit() async {
    final count = ++_monotonic;
    _hovered = false;
    await Future.delayed(widget.style.expandHoverExitDuration);

    if (count == _monotonic && mounted) {
      await _controller.reverse();
    }
  }
}
