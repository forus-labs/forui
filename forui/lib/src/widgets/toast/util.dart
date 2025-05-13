import 'package:flutter/widgets.dart';

typedef AnimatedChildBuilder<T> = Widget Function(BuildContext context, T value, Widget? child);
typedef AnimationBuilder<T> = Widget Function(BuildContext context, Animation<T> animation);
typedef AnimatedChildValueBuilder<T> =
Widget Function(BuildContext context, T oldValue, T newValue, double t, Widget? child);

class AnimatedValueBuilder<T> extends StatefulWidget {
  final T? initialValue;
  final T value;
  final Duration duration;
  final AnimatedChildBuilder<T>? builder;
  final AnimationBuilder<T>? animationBuilder;
  final AnimatedChildValueBuilder<T>? rawBuilder;
  final void Function(T value)? onEnd;
  final Curve curve;
  final T Function(T a, T b, double t)? lerp;
  final Widget? child;

  const AnimatedValueBuilder({
    super.key,
    this.initialValue,
    required this.value,
    required this.duration,
    required AnimatedChildBuilder<T> this.builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.lerp,
    this.child,
  }) : animationBuilder = null,
        rawBuilder = null;

  const AnimatedValueBuilder.animation({
    super.key,
    this.initialValue,
    required this.value,
    required this.duration,
    required AnimationBuilder<T> builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.lerp,
  }) : builder = null,
        animationBuilder = builder,
        child = null,
        rawBuilder = null;

  const AnimatedValueBuilder.raw({
    super.key,
    this.initialValue,
    required this.value,
    required this.duration,
    required AnimatedChildValueBuilder<T> builder,
    this.onEnd,
    this.curve = Curves.linear,
    this.child,
    this.lerp,
  }) : animationBuilder = null,
        rawBuilder = builder,
        builder = null;

  @override
  State<StatefulWidget> createState() => AnimatedValueBuilderState<T>();
}

class _AnimatableValue<T> extends Animatable<T> {
  final T start;
  final T end;
  final T Function(T a, T b, double t) lerp;

  _AnimatableValue({required this.start, required this.end, required this.lerp});

  @override
  T transform(double t) {
    return lerp(start, end, t);
  }

  @override
  String toString() {
    return 'AnimatableValue($start, $end)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _AnimatableValue && other.start == start && other.end == end && other.lerp == lerp;
  }

  @override
  int get hashCode {
    return Object.hash(start, end, lerp);
  }
}

class AnimatedValueBuilderState<T> extends State<AnimatedValueBuilder<T>> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<T> _animation;
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue ?? widget.value;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _curvedAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onEnd();
      }
    });
    _animation = _curvedAnimation.drive(
      _AnimatableValue(start: widget.initialValue ?? widget.value, end: widget.value, lerp: lerpedValue),
    );
    if (widget.initialValue != null) {
      _controller.forward();
    }
  }

  T lerpedValue(T a, T b, double t) {
    if (widget.lerp != null) {
      return widget.lerp!(a, b, t);
    }
    try {
      return (a as dynamic) + ((b as dynamic) - (a as dynamic)) * t;
    } catch (e) {
      throw Exception('Could not lerp $a and $b. You must provide a custom lerp function.');
    }
  }

  @override
  void didUpdateWidget(AnimatedValueBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    T currentValue = _animation.value;
    _currentValue = currentValue;
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      _curvedAnimation.dispose();
      _curvedAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    }
    if (oldWidget.value != widget.value || oldWidget.lerp != widget.lerp) {
      _animation = _curvedAnimation.drive(_AnimatableValue(start: currentValue, end: widget.value, lerp: lerpedValue));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnd() {
    if (widget.onEnd != null) {
      widget.onEnd!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationBuilder != null) {
      return widget.animationBuilder!(context, _animation);
    }
    return AnimatedBuilder(animation: _animation, builder: _builder, child: widget.child);
  }

  Widget _builder(BuildContext context, Widget? child) {
    if (widget.rawBuilder != null) {
      return widget.rawBuilder!(context, _currentValue, widget.value, _curvedAnimation.value, child);
    }
    T newValue = _animation.value;
    return widget.builder!(context, newValue, child);
  }
}