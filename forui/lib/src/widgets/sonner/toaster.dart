import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/animated_toast.dart';
import 'package:forui/src/widgets/sonner/animated_toaster.dart';
import 'package:forui/src/widgets/sonner/sonner.dart';

/// A toaster is responsible for managing a stack of toasts, including the expanding animations.
///
/// The actual positioning of toasts is delegated to [AnimatedToaster].
@internal
class Toaster extends StatefulWidget {
  final FSonnerStyle style;
  final Offset expandedAlignTransform;
  final Offset collapsedAlignTransform;
  final List<SonnerEntry> entries;

  const Toaster({
    required this.style,
    required this.expandedAlignTransform,
    required this.collapsedAlignTransform,
    required this.entries,
    super.key,
  });

  @override
  State<Toaster> createState() => _ToasterState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('expandedAlignTransform', expandedAlignTransform))
      ..add(DiagnosticsProperty('collapsedAlignTransform', collapsedAlignTransform))
      ..add(IterableProperty('entries', entries));
  }
}

class _ToasterState extends State<Toaster> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expand;
  bool _autoDismiss = true;
  bool _hovered = false;
  int _monotonic = 0;

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
      _controller
        ..duration = widget.style.expandDuration
        ..value = 0;
      _expand = _controller.drive(CurveTween(curve: widget.style.expandCurve));
    }

    if (widget.style.expandBehavior != old.style.expandBehavior) {
      if (widget.style.expandBehavior == FSonnerExpandBehavior.always) {
        _controller.value = 1;
      } else if (widget.style.expandBehavior == FSonnerExpandBehavior.disabled) {
        _controller.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => _enter(),
    onExit: (_) => _exit(),
    child: GestureDetector(
      onTap: () {
        if (!_hovered) {
          setState(() => _autoDismiss = !_autoDismiss);
          if (widget.style.expandBehavior == FSonnerExpandBehavior.hoverOrPress) {
            _controller.isForwardOrCompleted ? _controller.reverse() : _controller.forward();
          }
        }
      },
      child: AnimatedToaster(
        style: widget.style,
        expandedAlignTransform: widget.expandedAlignTransform,
        collapsedAlignTransform: widget.collapsedAlignTransform,
        expand: _expand.value,
        children: [
          for (final (index, entry) in widget.entries.indexed)
            AnimatedToast(
              key: entry.key,
              style: entry.style ?? widget.style.toastStyle,
              alignTransform: widget.collapsedAlignTransform,
              index: widget.entries.length - 1 - index,
              length: widget.entries.length,
              duration: entry.duration,
              expand: _expand.value,
              visible: (widget.entries.length - 1 - index) < (widget.style.max),
              autoDismiss: _autoDismiss,
              dismissing: entry.dismissing,
              onDismiss: entry.onDismiss!,
              child: entry.builder(context, entry),
            ),
        ],
      ),
    ),
  );

  Future<void> _enter() async {
    final fencingToken = ++_monotonic;
    _hovered = true;
    await Future.delayed(widget.style.expandHoverEnterDuration);

    if (fencingToken == _monotonic && mounted) {
      setState(() => _autoDismiss = false);
      if (widget.style.expandBehavior == FSonnerExpandBehavior.hoverOrPress) {
        await _controller.forward();
      }
    }
  }

  Future<void> _exit() async {
    final fencingToken = ++_monotonic;
    _hovered = false;
    await Future.delayed(widget.style.expandHoverExitDuration);

    if (fencingToken == _monotonic && mounted) {
      setState(() => _autoDismiss = true);
      if (widget.style.expandBehavior == FSonnerExpandBehavior.hoverOrPress) {
        await _controller.reverse();
      }
    }
  }
}
