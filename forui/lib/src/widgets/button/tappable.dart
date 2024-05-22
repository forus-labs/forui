import 'package:flutter/material.dart';

/// A [FTappable] creates a scale animation that mimics a tap.
class FTappable extends StatefulWidget {
  /// The callback for when this [FTappable] is pressed.
  final VoidCallback? onPressed;

  /// This child.
  final Widget child;

  /// Creates a [FTappable] widget.
  const FTappable({
    required this.child,
    this.onPressed,
    super.key,
  });

  @override
  State<FTappable> createState() => _FTappableState();
}

class _FTappableState extends State<FTappable> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _animation,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: widget.onPressed == null
              ? null
              : () {
                  widget.onPressed!();
                  _controller.forward();
                },
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
