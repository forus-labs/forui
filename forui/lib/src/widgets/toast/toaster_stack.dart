import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/toast/animated_toast.dart';
import 'package:forui/src/widgets/toast/animated_toaster.dart';
import 'package:forui/src/widgets/toast/toaster.dart';

/// A toaster stack is responsible for managing a stack of toasts, including the expanding animations.
///
/// The actual positioning of toasts is delegated to [AnimatedToaster].
@internal
class ToasterStack extends StatefulWidget {
  final FToasterStyle style;
  final Offset expandedAlignTransform;
  final Offset collapsedAlignTransform;
  final List<ToasterEntry> entries;

  const ToasterStack({
    required this.style,
    required this.expandedAlignTransform,
    required this.collapsedAlignTransform,
    required this.entries,
    super.key,
  });

  @override
  State<ToasterStack> createState() => _ToasterStackState();

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

class _ToasterStackState extends State<ToasterStack> with SingleTickerProviderStateMixin {
  final ValueNotifier<Swipe> _swiping = ValueNotifier(const Unswiped());
  late AnimationController _controller;
  late CurvedAnimation _expand;
  bool _autoDismiss = true;
  bool _hovered = false;
  int _monotonic = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.style.motion.expandDuration,
      reverseDuration: widget.style.motion.collapseDuration,
    )..addListener(() => setState(() {}));
    _expand = CurvedAnimation(
      parent: _controller,
      curve: widget.style.motion.expandCurve,
      reverseCurve: widget.style.motion.collapseCurve,
    );
    _swiping.addListener(_collapseAfterSwipe);

    if (widget.style.expandBehavior == FToasterExpandBehavior.always) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(ToasterStack old) {
    super.didUpdateWidget(old);
    if (old.style != widget.style) {
      _controller
        ..duration = widget.style.motion.expandDuration
        ..reverseDuration = widget.style.motion.collapseDuration
        ..value = 0;
      _expand
        ..curve = widget.style.motion.expandCurve
        ..reverseCurve = widget.style.motion.collapseCurve;
    }

    if (widget.style.expandBehavior != old.style.expandBehavior) {
      if (widget.style.expandBehavior == FToasterExpandBehavior.always) {
        _controller.value = 1;
      } else if (widget.style.expandBehavior == FToasterExpandBehavior.disabled) {
        _controller.value = 0;
      }
    }
  }

  // Handles cases where user is using a mouse & moves outside of the toaster's expanded region when swiping to dismiss.
  void _collapseAfterSwipe() {
    if (mounted && _swiping.value is ExternalEndSwipe) {
      setState(() {
        _autoDismiss = true;
        _swiping.value = _swiping.value.end();
      });
      if (widget.style.expandBehavior == FToasterExpandBehavior.hoverOrPress) {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _swiping.dispose();
    _expand.dispose();
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
          if (widget.style.expandBehavior == FToasterExpandBehavior.hoverOrPress) {
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
              swipeToDismiss: entry.swipeToDismiss,
              expand: _expand.value,
              visible: (widget.entries.length - 1 - index) < (widget.style.max),
              autoDismiss: _autoDismiss,
              swiping: _swiping,
              dismissing: entry.dismissing,
              onDismiss: () {
                entry.onDismiss?.call();
                if (mounted &&
                    widget.entries.isEmpty &&
                    widget.style.expandBehavior == FToasterExpandBehavior.hoverOrPress) {
                  _controller.value = 0;
                }
              },
              child: entry.builder(context, entry),
            ),
        ],
      ),
    ),
  );

  Future<void> _enter() async {
    final fencingToken = ++_monotonic;
    _hovered = true;
    _swiping.value = _swiping.value.enter();
    await Future.delayed(widget.style.expandHoverEnterDuration);

    if (fencingToken == _monotonic && mounted) {
      setState(() => _autoDismiss = false);
      if (widget.style.expandBehavior == FToasterExpandBehavior.hoverOrPress) {
        await _controller.forward();
      }
    }
  }

  Future<void> _exit() async {
    final fencingToken = ++_monotonic;
    _hovered = false;
    _swiping.value = _swiping.value.exit();

    await Future.delayed(widget.style.expandHoverExitDuration);

    if (fencingToken == _monotonic && mounted && _swiping.value is! ExternalSwipe) {
      setState(() => _autoDismiss = true);
      if (widget.style.expandBehavior == FToasterExpandBehavior.hoverOrPress) {
        await _controller.reverse();
      }
    }
  }
}

/// A state machine which describes a toast's swipe to dismiss state.
@internal
sealed class Swipe {
  const Swipe();

  // ignore: avoid_returning_this
  Swipe start() => this;

  // ignore: avoid_returning_this
  Swipe end() => this;

  // ignore: avoid_returning_this
  Swipe enter() => this;

  // ignore: avoid_returning_this
  Swipe exit() => this;
}

/// A toast is not being swiped, initial state.
@internal
class Unswiped extends Swipe {
  const Unswiped();

  @override
  Swipe start() => const InternalSwipe();
}

/// A toast is being swiped internally, i.e. within the toast region.
@internal
class InternalSwipe extends Swipe {
  const InternalSwipe();

  @override
  Swipe end() => const Unswiped();

  @override
  Swipe exit() => const ExternalSwipe();
}

/// A toast is being swiped externally, i.e. outside the toast region.
@internal
class ExternalSwipe extends Swipe {
  const ExternalSwipe();

  @override
  Swipe end() => const ExternalEndSwipe();

  @override
  Swipe enter() => const InternalSwipe();
}

/// A toast has been swiped externally, and the swipe has ended outside the toast region.
@internal
class ExternalEndSwipe extends Swipe {
  const ExternalEndSwipe();

  @override
  Swipe end() => const Unswiped();

  @override
  Swipe enter() => this;
}
