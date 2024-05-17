import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

/// A builder of [FTappable] widget.
typedef TappableBuilder = Widget Function(
    BuildContext,
    VoidCallback?,
    );

/// A [FTappable] creates a scale animation that mimics a tap.
///
/// ```dart
/// Tappable(
///   onPressed: () { // Some action on pressed. },
///   builder: (context, onPressed) =>
///     ElevatedButton(
///       style: _style(settings.palette),
///       onPressed: onPressed,
///       child: Text('Hello World!'),
///     ),
/// );
/// ```
final class FTappable extends HookWidget {
  /// A builder for animated widgets.
  final TappableBuilder builder;

  /// The callback for when this [FTappable] is pressed.
  final VoidCallback? onPressed;

  /// Creates a [FTappable] widget.
  const FTappable({
    required this.builder,
    this.onPressed,
    super.key,
  });

  /// Creates a [FTappable] widget with an inbuilt `GestureDetector`.
  FTappable.gesture({
    required Widget child,
    this.onPressed,
    behavior = HitTestBehavior.deferToChild,
    super.key,
  }) : builder = ((context, onPressed) => GestureDetector(
    behavior: behavior,
    onTap: onPressed,
    child: child,
  ));

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );

    final animation = useState(
      Tween(begin: 1.0, end: 0.95).animate(controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.reverse();
          }
        }),
    );

    return ScaleTransition(
      scale: animation.value,
      child: builder(
        context,
        onPressed == null
            ? null
            : () {
          onPressed!();
          controller.forward();
        },
      ),
    );
  }
}
