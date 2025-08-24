import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/widgets/toast/animated_toaster.dart';

@internal
class AnimatedToastData extends ParentDataWidget<AnimatedToasterParentData> {
  /// The index.
  final int index;

  /// The transition between different indexes.
  final double transition;

  /// True if visible.
  final bool visible;

  /// The signal to indicate that a widget update has occurred.
  final int signal;

  const AnimatedToastData({
    required this.index,
    required this.transition,
    required this.visible,
    required this.signal,
    required super.child,
    super.key,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    assert(
      renderObject.parentData is AnimatedToasterParentData,
      'Parent data must be of type AnimatedToasterParentData',
    );

    final data = renderObject.parentData! as AnimatedToasterParentData;
    var needsLayout = false;

    if (data.index.current != index) {
      data.index = (previous: data.index.current, current: index);
      needsLayout = true;
    }

    if (data.transition != transition) {
      data.transition = transition;
      needsLayout = true;
    }

    if (data.visible != visible) {
      data.visible = visible;
      needsLayout = true;
    }

    if (data._signal != signal) {
      data.signal = signal;
      needsLayout = true;
    }

    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => AnimatedToaster;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('index', index.toString()))
      ..add(DoubleProperty('transition', transition))
      ..add(DiagnosticsProperty('visible', visible))
      ..add(IntProperty('signal', signal));
  }
}

/// Parent data for use with [RenderAnimatedToaster].
@internal
class AnimatedToasterParentData extends ContainerBoxParentData<RenderBox> {
  final AnimationTween<Size> scale = AnimationTween.size();

  final AnimationTween<Offset> alignment = AnimationTween.offset();

  final AnimationTween<double> shift = AnimationTween.of();

  final AnimationTween<double> protrusion = AnimationTween.of();

  /// The index of the child.
  ({int previous, int current}) index = (previous: 0, current: 0);

  Size? collapsedUntransformedSize;

  /// The transition between different indexes.
  double transition = 0.0;

  /// True if visible.
  bool visible = true;

  int _signal = 0;

  int get signal => _signal;

  set signal(int value) {
    _signal = value;
    scale.mark();
    alignment.mark();
    shift.mark();
    protrusion.mark();
  }
}

/// This preserves a widget's animation across rebuilds, preventing an animation from restarting from scratch when an
/// rebuild occurs mid animation.
@internal
class AnimationTween<T> {
  static const epsilon = 1e-6;

  static bool _offset(Offset a, Offset b) => (a.dx - b.dx).abs() < epsilon && (a.dy - b.dy).abs() < epsilon;

  static bool _size(Size a, Size b) => (a.width - b.width).abs() < epsilon && (a.height - b.height).abs() < epsilon;

  T? begin;
  T? end;
  T? _value;
  final bool Function(T, T) _equal;

  static AnimationTween<double> of({double? begin, double? end}) =>
      AnimationTween<double>(equal: (a, b) => (a - b).abs() < epsilon, begin: begin, end: end);

  static AnimationTween<Offset> offset({Offset? begin, Offset? end}) =>
      AnimationTween<Offset>(equal: _offset, begin: begin, end: end);

  static AnimationTween<Size> size({Size? begin, Size? end}) =>
      AnimationTween<Size>(equal: _size, begin: begin, end: end);

  AnimationTween({required bool Function(T, T) equal, this.begin, this.end}) : _equal = equal;

  void mark() {
    begin = value;
    end = null;
  }

  T? get value => _value ??= begin;

  set value(T? value) {
    _value = value;
    if (value != null && end != null && _equal(value, end as T)) {
      begin = end;
      end = null;
    }
  }
}
