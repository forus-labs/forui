// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'tooltip_controller.control.dart';

/// A controller that controls whether a [FTooltip] is shown or hidden.
class FTooltipController extends FChangeNotifier {
  final OverlayPortalController _overlay = .new();
  late final AnimationController _animation;
  late final CurvedAnimation _curveFade;
  late final CurvedAnimation _curveScale;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FTooltipController] with the given [vsync], [shown] and [motion].
  FTooltipController({required TickerProvider vsync, bool shown = false, FTooltipMotion motion = const .new()}) {
    if (shown) {
      _overlay.show();
    }
    _animation = AnimationController(
      vsync: vsync,
      duration: motion.entranceDuration,
      reverseDuration: motion.exitDuration,
    )..value = shown ? 1 : 0;
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

class _ProxyController extends FTooltipController {
  int _monotonic;
  ValueChanged<bool> _onChange;
  FTooltipMotion _motion;

  _ProxyController(this._onChange, this._motion, {required super.vsync, super.shown})
    : _monotonic = 0,
      super(motion: _motion);

  void update(bool shown, ValueChanged<bool> onChange, FTooltipMotion motion) {
    _onChange = onChange;
    if (_motion != motion) {
      _motion = motion;
      _animation
        ..duration = motion.entranceDuration
        ..reverseDuration = motion.exitDuration;
      _curveFade
        ..curve = motion.fadeInCurve
        ..reverseCurve = motion.fadeOutCurve;
      _curveScale
        ..curve = motion.expandCurve
        ..reverseCurve = motion.collapseCurve;
      _scale = motion.scaleTween.animate(_curveScale);
      _fade = motion.fadeTween.animate(_curveFade);
    }

    final current = ++_monotonic;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (current == _monotonic) {
        if (!shown && status.isForwardOrCompleted) {
          await _animation.reverse();
          if (current == _monotonic) {
            _overlay.hide();
            notifyListeners();
          }
        } else if (shown && !status.isForwardOrCompleted) {
          _overlay.show();
          await _animation.forward();
          notifyListeners();
        }
      }
    });
  }

  @override
  Future<void> show() async => _onChange(true);

  @override
  Future<void> hide() async => _onChange(false);
}

/// A [FTooltipControl] defines how a [FTooltip] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTooltipControl with Diagnosticable, _$FTooltipControlMixin {
  /// Creates a [FTooltipControl].
  const factory FTooltipControl.managed({
    FTooltipController? controller,
    bool? initial,
    FTooltipMotion? motion,
    ValueChanged<bool>? onChange,
  }) = FTooltipManagedControl;

  /// Creates a [FTooltipControl] for controlling a tooltip using lifted state.
  ///
  /// The [shown] parameter indicates whether the tooltip is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FTooltipControl.lifted({
    required bool shown,
    required ValueChanged<bool> onChange,
    FTooltipMotion motion,
  }) = _Lifted;

  const FTooltipControl._();

  (FTooltipController, bool) _update(
    FTooltipControl old,
    FTooltipController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

/// A [FTooltipManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FTooltipManagedControl extends FTooltipControl with Diagnosticable, _$FTooltipManagedControlMixin {
  /// The controller.
  @override
  final FTooltipController? controller;

  /// Whether the tooltip is initially shown. Defaults to false (hidden).
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final bool? initial;

  /// The tooltip motion. Defaults to [FTooltipMotion].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [motion] and [controller] are both provided.
  @override
  final FTooltipMotion? motion;

  /// Called when the shown state changes.
  @override
  final ValueChanged<bool>? onChange;

  /// Creates a [FTooltipControl].
  const FTooltipManagedControl({this.controller, this.initial, this.motion, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both initially shown and controller. Pass initially shown to the controller instead.',
      ),
      assert(
        controller == null || motion == null,
        'Cannot provide both controller and motion. Pass motion to the controller instead.',
      ),
      super._();

  @override
  FTooltipController createController(TickerProvider vsync) =>
      controller ?? .new(vsync: vsync, motion: motion ?? const .new());
}

class _Lifted extends FTooltipControl with _$_LiftedMixin {
  @override
  final bool shown;
  @override
  final ValueChanged<bool> onChange;
  @override
  final FTooltipMotion motion;

  const _Lifted({required this.shown, required this.onChange, this.motion = const .new()}) : super._();

  @override
  FTooltipController createController(TickerProvider vsync) =>
      _ProxyController(vsync: vsync, shown: shown, onChange, motion);

  @override
  void _updateController(FTooltipController controller, TickerProvider vsync) =>
      (controller as _ProxyController).update(shown, onChange, motion);
}
