import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'progress.style.dart';

/// A progress indicator that shows the completion progress of a task.
///
/// See:
/// * https://forui.dev/docs/navigation/progress for working examples.
/// * [FLinearProgressStyle] for customizing a linear progress indicator's appearance.
abstract class FProgress extends StatefulWidget {
  /// The progress's value. Defaults to null.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range, `[0.0, 1.0]`.
  ///
  /// A null value indicates that the the progress should repeat indefinitely.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [value] is not null and is less than 0.0 or greater than 1.0.
  final double? value;

  /// Creates a linear [FProgress].
  ///
  /// The [constraints] is the constraints for the progress bar. Defaults to a height of 15.0 and no horizontal
  /// constraint.
  ///
  /// The [duration] is the duration of the animation. Defaults to 3s if [value] is null and 0.5s otherwise.
  const factory FProgress({
    FLinearProgressStyle? style,
    double? value,
    BoxConstraints constraints,
    Duration duration,
    Key? key,
  }) = _Linear;

  const FProgress._({this.value, super.key})
    : assert(value == null || value >= 0.0, 'The value must be greater than or equal to 0.0'),
      assert(value == null || value <= 1.0, 'The value must be less than or equal to 1.0');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('value', value));
  }
}

class _Linear extends FProgress {
  static const _infinite = Duration(milliseconds: 1500);
  static const _finite = Duration(milliseconds: 500);

  final FLinearProgressStyle? style;
  final Duration duration;
  final BoxConstraints constraints;

  const _Linear({
    this.style,
    this.constraints = const BoxConstraints(minHeight: 10.0, maxHeight: 10.0),
    Duration? duration,
    super.value,
    super.key,
  }) : duration = duration ?? (value == null ? _infinite : _finite),
       super._();

  @override
  State<_Linear> createState() => _LinearState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}

class _LinearState extends State<_Linear> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late CurvedAnimation _curve;
  late Animation<double> _animation;
  double _previous = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.value == null ? _controller.repeat() : _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final style = widget.style ?? context.theme.progressStyles.linearProgressStyle;
    _curve = CurvedAnimation(parent: _controller, curve: style.curve);
    _animation = Tween(begin: _previous, end: widget.value ?? 1).animate(_curve);
  }

  @override
  void didUpdateWidget(covariant _Linear old) {
    super.didUpdateWidget(old);
    var reanimate = false;
    if (widget.duration != old.duration) {
      _controller.duration = widget.duration;
      reanimate = true;
    }

    if (widget.value != old.value) {
      _previous = widget.value == null ? 0 : (old.value ?? 0);
      reanimate = true;
    }

    if (widget.style != old.style) {
      final style = widget.style ?? context.theme.progressStyles.linearProgressStyle;
      _curve = CurvedAnimation(parent: _controller, curve: style.curve);
      reanimate = true;
    }

    if (reanimate) {
      _animation = Tween(begin: _previous, end: widget.value ?? 1).animate(_curve);
      if (widget.value == null) {
        _controller.repeat();
      } else {
        _controller
          ..reset()
          ..forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.progressStyles.linearProgressStyle;
    return ConstrainedBox(
      constraints: widget.constraints,
      child: DecoratedBox(
        decoration: style.backgroundDecoration,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) => FractionallySizedBox(widthFactor: _animation.value, child: child!),
            child: Container(decoration: style.progressDecoration),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// The progress styles.
class FProgressStyles with Diagnosticable, _$FProgressStylesFunctions {
  /// The linear progress's style.
  @override
  final FLinearProgressStyle linearProgressStyle;

  /// Creates a [FProgressStyles].
  const FProgressStyles({required this.linearProgressStyle});

  /// Creates a [FProgressStyles] that inherits its properties from [colorScheme] and [style].
  FProgressStyles.inherit({required FColorScheme colorScheme, required FStyle style})
    : linearProgressStyle = FLinearProgressStyle.inherit(colorScheme: colorScheme, style: style);
}

/// [FProgress]'s style.
class FLinearProgressStyle with Diagnosticable, _$FLinearProgressStyleFunctions {
  /// The progress's background's decoration.
  @override
  final BoxDecoration backgroundDecoration;

  /// The progress's decoration.
  @override
  final BoxDecoration progressDecoration;

  /// The animation curve. Defaults to [Curves.ease].
  @override
  final Curve curve;

  /// Creates a [FLinearProgressStyle].
  const FLinearProgressStyle({
    required this.backgroundDecoration,
    required this.progressDecoration,
    this.curve = Curves.ease,
  });

  /// Creates a [FLinearProgressStyle] that inherits its properties from [colorScheme] and [style].
  FLinearProgressStyle.inherit({required FColorScheme colorScheme, required FStyle style})
    : this(
        backgroundDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.secondary),
        progressDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.primary),
      );
}
