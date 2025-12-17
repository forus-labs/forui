// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'popover_controller.control.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
class FPopoverController extends FChangeNotifier {
  final OverlayPortalController _overlay = .new();
  late final AnimationController _animation;
  late final CurvedAnimation _curveScale;
  late final CurvedAnimation _curveFade;
  late Animation<double> _scale;
  late Animation<double> _fade;

  /// Creates a [FPopoverController] with the given [vsync], [shown] and [motion].
  FPopoverController({required TickerProvider vsync, bool shown = false, FPopoverMotion motion = const .new()}) {
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
    _scale = motion.scaleTween.animate(_curveScale);
    _fade = motion.fadeTween.animate(_curveFade);
  }

  /// Convenience method for showing/hiding the popover.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle() => _animation.status.isForwardOrCompleted ? hide() : show();

  /// Shows the popover.
  ///
  /// If already shown, calling this method brings the popover to the top.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> show() async {
    if (!_animation.isForwardOrCompleted) {
      _overlay.show();
      await _animation.forward();
      notifyListeners();
    }
  }

  /// Hides the popover.
  ///
  /// Once hidden, the popover will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the popover may lose their states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    if (_animation.isForwardOrCompleted) {
      await _animation.reverse();
      _overlay.hide();
      notifyListeners();
    }
  }

  /// The current status.
  ///
  /// [AnimationStatus.dismissed] - The popover is hidden.
  /// [AnimationStatus.forward] - The popover is transitioning from hidden to shown.
  /// [AnimationStatus.completed] - The popover is shown.
  /// [AnimationStatus.reverse] - The popover is transitioning from shown to hidden.
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
extension InternalFPopoverController on FPopoverController {
  OverlayPortalController get overlay => _overlay;

  Animation<double> get scale => _scale;

  Animation<double> get fade => _fade;
}

class _ProxyController extends FPopoverController {
  int _monotonic;
  ValueChanged<bool> _onChange;
  FPopoverMotion _motion;

  _ProxyController(this._onChange, this._motion, {required super.vsync, super.shown})
    : _monotonic = 0,
      super(motion: _motion);

  void update(bool shown, ValueChanged<bool> onChange, FPopoverMotion motion) {
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

/// A [FPopoverControl] defines how a [FPopover] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FPopoverControl with Diagnosticable, _$FPopoverControlMixin {
  /// Creates a [FPopoverControl].
  const factory FPopoverControl.managed({
    FPopoverController? controller,
    bool? initial,
    FPopoverMotion? motion,
    ValueChanged<bool>? onChange,
  }) = FPopoverManagedControl;

  /// Creates a [FPopoverControl] for controlling a popover using lifted state.
  ///
  /// The [shown] parameter indicates whether the popover is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FPopoverControl.lifted({
    required bool shown,
    required ValueChanged<bool> onChange,
    FPopoverMotion motion,
  }) = _Lifted;

  const FPopoverControl._();

  (FPopoverController, bool) _update(
    FPopoverControl old,
    FPopoverController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

/// A [FPopoverManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FPopoverManagedControl extends FPopoverControl with Diagnosticable, _$FPopoverManagedControlMixin {
  /// The controller.
  @override
  final FPopoverController? controller;

  /// Whether the popover is initially shown. Defaults to false (hidden).
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final bool? initial;

  /// The popover motion. Defaults to [FPopoverMotion].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [motion] and [controller] are both provided.
  @override
  final FPopoverMotion? motion;

  /// Called when the shown state changes.
  @override
  final ValueChanged<bool>? onChange;

  /// Creates a [FPopoverControl].
  const FPopoverManagedControl({this.controller, this.initial, this.motion, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initially shown. Pass initially shown to the controller instead.',
      ),
      assert(
        controller == null || motion == null,
        'Cannot provide both controller and motion. Pass motion to the controller instead.',
      ),
      super._();

  @override
  FPopoverController createController(TickerProvider vsync) =>
      controller ?? .new(vsync: vsync, shown: initial ?? false, motion: motion ?? const .new());
}

class _Lifted extends FPopoverControl with _$_LiftedMixin {
  @override
  final bool shown;
  @override
  final ValueChanged<bool> onChange;
  @override
  final FPopoverMotion motion;

  const _Lifted({required this.shown, required this.onChange, this.motion = const .new()}) : super._();

  @override
  FPopoverController createController(TickerProvider vsync) =>
      _ProxyController(vsync: vsync, shown: shown, onChange, motion);

  @override
  void _updateController(FPopoverController controller, TickerProvider vsync) =>
      (controller as _ProxyController).update(shown, onChange, motion);
}
