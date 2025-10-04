import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'determinate_progress.design.dart';

/// A determinate linear progress indicator.
///
/// See:
/// * https://forui.dev/docs/feedback/progress for working examples.
/// * [FDeterminateProgressStyle] for customizing a progress's appearance.
/// * [FProgress] for for an indeterminate linear progress indicator.
/// * [FCircularProgress] for for an indeterminate circular progress indicator.
class FDeterminateProgress extends StatefulWidget {
  /// The style.
  final FDeterminateProgressStyle Function(FDeterminateProgressStyle style)? style;

  /// The semantics label. Defaults to [FLocalizations.progressSemanticsLabel].
  final String? semanticsLabel;

  /// The progress value. Defaults to null.
  ///
  /// ## Contract
  /// Throw [AssertionError] if value is not between 0.0 and 1.0.
  final double value;

  /// Creates a determinate [FDeterminateProgress].
  const FDeterminateProgress({required this.value, this.style, this.semanticsLabel, super.key})
    : assert((0.0 <= value && value <= 1.0), 'value ($value) must be between 0.0 and 1.0');

  @override
  State<FDeterminateProgress> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(PercentProperty('value', value));
  }
}

class _State extends State<FDeterminateProgress> with SingleTickerProviderStateMixin {
  FDeterminateProgressStyle? _style;
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setup();
  }

  @override
  void didUpdateWidget(covariant FDeterminateProgress old) {
    super.didUpdateWidget(old);
    _setup();
  }

  void _setup() {
    final style = widget.style?.call(context.theme.determinateProgressStyle) ?? context.theme.determinateProgressStyle;

    if (_style != style) {
      _style = style;
      _controller
        ..value = _controller.value
        ..duration = style.motion.duration;
      _animation.curve = style.motion.curve;
    }

    if (widget.value != _controller.value) {
      _controller.animateTo(widget.value, duration: style.motion.duration * (widget.value - _controller.value).abs());
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: _style!.constraints,
    child: Semantics(
      label: widget.semanticsLabel ?? (FLocalizations.of(context) ?? FDefaultLocalizations()).progressSemanticsLabel,
      child: DecoratedBox(
        decoration: _style!.trackDecoration,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) => FractionallySizedBox(widthFactor: _animation.value, child: child!),
            child: Container(decoration: _style!.fillDecoration),
          ),
        ),
      ),
    ),
  );
}

/// A [FDeterminateProgress]'s style.
class FDeterminateProgressStyle with Diagnosticable, _$FDeterminateProgressStyleFunctions {
  /// The linear progress's constraints. Defaults to a height of 10.0 and no horizontal constraint.
  @override
  final BoxConstraints constraints;

  /// The track's decoration.
  @override
  final BoxDecoration trackDecoration;

  /// The fill's decoration.
  @override
  final BoxDecoration fillDecoration;

  /// The motion-related properties for an indeterminate [FDeterminateProgress].
  @override
  final FDeterminateProgressMotion motion;

  /// Creates a [FDeterminateProgressStyle].
  const FDeterminateProgressStyle({
    required this.trackDecoration,
    required this.fillDecoration,
    this.constraints = const BoxConstraints.tightFor(height: 10.0),
    this.motion = const FDeterminateProgressMotion(),
  });

  /// Creates a [FDeterminateProgressStyle] that inherits its properties.
  FDeterminateProgressStyle.inherit({required FColors colors, required FStyle style})
    : this(
        trackDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
        fillDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.primary),
      );
}

/// Motion-related properties for a [FDeterminateProgress].
class FDeterminateProgressMotion with Diagnosticable, _$FDeterminateProgressMotionFunctions {
  /// The animation's duration for a full progress from 0.0 to 1.0. Defaults to 1s.
  @override
  final Duration duration;

  /// The animation curve. Defaults to [Curves.linear].
  @override
  final Curve curve;

  /// Creates a [FDeterminateProgressMotion].
  const FDeterminateProgressMotion({this.duration = const Duration(milliseconds: 1000), this.curve = Curves.linear});
}
