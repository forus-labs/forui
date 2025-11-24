import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// An alternative to [Tween] that is immutable.
///
/// This class is an exact copy of [Tween] except:
/// * [begin] and [end] are `final` and of type `T` instead of `T?`.
class FImmutableTween<T extends Object?> extends Animatable<T> {
  /// The value this variable has at the beginning of the animation.
  final T begin;

  /// The value this variable has at the end of the animation.
  final T end;

  /// Creates an immutable tween.
  const FImmutableTween({required this.begin, required this.end});

  /// Returns the value this variable has at the given animation clock value.
  ///
  /// The default implementation of this method uses the `+`, `-`, and `*` operators on `T`. The [begin] and [end]
  /// properties must therefore be non-null by the time this method is called.
  ///
  /// In general, however, it is possible for this to return null, especially when `t`=0.0 and [begin] is null, or
  /// `t`=1.0 and [end] is null.
  @visibleForTesting
  @protected
  T lerp(double t) {
    assert(begin != null);
    assert(end != null);
    assert(() {
      // Assertions that attempt to catch common cases of tweening types
      // that do not conform to the Tween requirements.
      dynamic result;
      try {
        // ignore: avoid_dynamic_calls
        result = (begin as dynamic) + ((end as dynamic) - (begin as dynamic)) * t;
        result as T;
        return true;
        // ignore: avoid_catching_errors
      } on NoSuchMethodError {
        throw FlutterError.fromParts([
          ErrorSummary('Cannot lerp between "$begin" and "$end".'),
          ErrorDescription(
            'The type ${begin.runtimeType} might not fully implement `+`, `-`, and/or `*`. '
            'See "Types with special considerations" at https://api.flutter.dev/flutter/animation/Tween-class.html '
            'for more information.',
          ),
          if (begin is Color || end is Color)
            ErrorHint('To lerp colors, consider ColorTween instead.')
          else if (begin is Rect || end is Rect)
            ErrorHint('To lerp rects, consider RectTween instead.')
          else
            ErrorHint(
              'There may be a dedicated "${begin.runtimeType}Tween" for this type, '
              'or you may need to create one.',
            ),
        ]);
        // ignore: avoid_catching_errors
      } on TypeError {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot lerp between "$begin" and "$end".'),
          ErrorDescription(
            'The type ${begin.runtimeType} returned a ${result.runtimeType} after '
            'multiplication with a double value. '
            'See "Types with special considerations" at https://api.flutter.dev/flutter/animation/Tween-class.html '
            'for more information.',
          ),
          if (begin is int || end is int)
            ErrorHint('To lerp int values, consider IntTween or StepTween instead.')
          else
            ErrorHint(
              'There may be a dedicated "${begin.runtimeType}Tween" for this type, '
              'or you may need to create one.',
            ),
        ]);
      }
    }());
    // ignore: avoid_dynamic_calls
    return (begin as dynamic) + ((end as dynamic) - (begin as dynamic)) * t as T;
  }

  /// Returns the interpolated value for the current value of the given animation.
  ///
  /// This method returns `begin` and `end` when the animation values are 0.0 or 1.0, respectively.
  ///
  /// This function is implemented by deferring to [lerp]. Subclasses that want to provide custom behavior should
  /// override [lerp], not [transform] (nor [evaluate]).
  ///
  /// See the constructor for details about whether the [begin] and [end] properties may be null when this is called. It
  /// varies from subclass to subclass.
  @override
  T transform(double t) {
    if (t == 0.0) {
      return begin;
    }
    if (t == 1.0) {
      return end;
    }
    return lerp(t);
  }

  @override
  String toString() => '${objectRuntimeType(this, 'FImmutableTween')}($begin \u2192 $end)';
}
