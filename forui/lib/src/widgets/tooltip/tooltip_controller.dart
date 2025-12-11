import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'tooltip_controller.control.dart';

/// A controller that controls whether a [FTooltip] is shown or hidden.
class FTooltipController extends FChangeNotifier {
  final OverlayPortalController _overlay = .new();
  late final AnimationController _animation;
  late final CurvedAnimation _curveFade;
  late final CurvedAnimation _curveScale;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FTooltipController] with the given [vsync] and [motion].
  FTooltipController({required TickerProvider vsync, double initial = 0.0, FTooltipMotion motion = const .new()}) {
    _animation = AnimationController(
      vsync: vsync,
      duration: motion.entranceDuration,
      reverseDuration: motion.exitDuration,
    )..value = initial;
    _curveFade = CurvedAnimation(parent: _animation, curve: motion.fadeInCurve, reverseCurve: motion.fadeOutCurve);
    _curveScale = CurvedAnimation(parent: _animation, curve: motion.expandCurve, reverseCurve: motion.collapseCurve);
    _fade = motion.fadeTween.animate(_curveFade);
    _scale = motion.scaleTween.animate(_curveScale);
  }

  /// Convenience method for showing/hiding the tooltip.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle() => _animation.status.isForwardOrCompleted ? hide() : show();

  /// Shows the tooltip.
  ///
  /// If already shown, calling this method brings the tooltip to the top.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> show() async {
    _overlay.show();
    await _animation.forward();
    notifyListeners();
  }

  /// Hides the tooltip.
  ///
  /// Once hidden, the tooltip will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the tooltip may lose their states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    await _animation.reverse();
    _overlay.hide();
    notifyListeners();
  }

  /// The current status.
  ///
  /// [AnimationStatus.dismissed] - The tooltip is hidden.
  /// [AnimationStatus.forward] - The tooltip is transitioning from hidden to shown.
  /// [AnimationStatus.completed] - The tooltip is shown.
  /// [AnimationStatus.reverse] - The tooltip is transitioning from shown to hidden.
  AnimationStatus get status => _animation.status;

  @override
  void dispose() {
    _curveFade.dispose();
    _curveScale.dispose();
    _animation.dispose();
    super.dispose();
  }
}

@internal
extension InternalTooltipController on FTooltipController {
  OverlayPortalController get overlay => _overlay;

  Animation<double> get fade => _fade;

  Animation<double> get scale => _scale;
}

class _Controller extends FTooltipController {
  int _monotonic;
  void Function(bool shown) _onChange;

  _Controller(bool shown, this._onChange, {required super.vsync, super.motion}) : _monotonic = 0 {
    if (shown) {
      _overlay.show();
      _animation.value = 1;
    }
  }

  void update(bool shown, void Function(bool shown) onChange) {
    _onChange = onChange;
    final current = ++_monotonic;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (current == _monotonic) {
        if (!shown && status.isForwardOrCompleted) {
          await _animation.reverse();
          if (current == _monotonic) {
            _overlay.hide();
          }
        } else if (shown && !status.isForwardOrCompleted) {
          _overlay.show();
          await _animation.forward();
        }
      }
    });
  }

  @override
  Future<void> show() async => _onChange(true);

  @override
  Future<void> hide() async => _onChange(false);
}

/// Defines how a tooltip's shown state is controlled.
sealed class FTooltipControl with Diagnosticable, _$FTooltipControlMixin {
  /// Creates a [FTooltipControl] for controlling a tooltip using lifted state.
  ///
  /// The [shown] parameter indicates whether the tooltip is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FTooltipControl.lifted({
    required bool shown,
    required void Function(bool shown) onChange,
    FTooltipMotion motion,
  }) = Lifted;

  /// Creates a [FTooltipControl] for controlling a tooltip using a controller.
  ///
  /// Either [controller] or [motion] can be provided. If neither is provided,
  /// an internal controller with default motion is created.
  ///
  /// The [onChange] callback is invoked when the tooltip's shown state changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [motion] are provided.
  const factory FTooltipControl.managed({
    FTooltipController? controller,
    FTooltipMotion? motion,
    void Function(bool shown)? onChange,
  }) = Managed;

  const FTooltipControl._();

  (FTooltipController, bool) _update(
    FTooltipControl old,
    FTooltipController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

@internal
class Lifted extends FTooltipControl with _$LiftedMixin {
  @override
  final bool shown;
  @override
  final void Function(bool shown) onChange;
  @override
  final FTooltipMotion motion;

  const Lifted({required this.shown, required this.onChange, this.motion = const FTooltipMotion()}) : super._();

  @override
  FTooltipController _create(VoidCallback callback, TickerProvider vsync) =>
      _Controller(vsync: vsync, shown, onChange, motion: motion);

  @override
  void _updateController(FTooltipController controller, TickerProvider vsync) =>
      (controller as _Controller).update(shown, onChange);
}

@internal
class Managed extends FTooltipControl with Diagnosticable, _$ManagedMixin {
  @override
  final FTooltipController? controller;
  @override
  final FTooltipMotion? motion;
  @override
  final void Function(bool shown)? onChange;

  const Managed({this.controller, this.motion, this.onChange})
    : assert(controller == null || motion == null, 'Cannot provide both controller and motion'),
      super._();

  @override
  FTooltipController _create(VoidCallback callback, TickerProvider vsync) =>
      (controller ?? .new(vsync: vsync, motion: motion ?? const .new()))..addListener(callback);
}
