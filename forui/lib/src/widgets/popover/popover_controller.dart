import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'popover_controller.control.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
class FPopoverController extends FChangeNotifier {
  final OverlayPortalController _overlay = .new();
  late final AnimationController _animation;
  late final CurvedAnimation _curveScale;
  late final CurvedAnimation _curveFade;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  /// Creates a [FPopoverController] with the given [vsync], [initial] and [motion].
  FPopoverController({required TickerProvider vsync, double initial = 0.0, FPopoverMotion motion = const .new()}) {
    _animation = AnimationController(
      vsync: vsync,
      duration: motion.entranceDuration,
      reverseDuration: motion.exitDuration,
    )..value = initial;
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
    _overlay.show();
    await _animation.forward();
    notifyListeners();
  }

  /// Hides the popover.
  ///
  /// Once hidden, the popover will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the popover may lose their states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    await _animation.reverse();
    _overlay.hide();
    notifyListeners();
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
extension InternalPopoverController on FPopoverController {
  /// Updates the given [controller] based on the [shown] and [onChange].
  ///
  /// Typically used when updating a popover controller nested in another controller.
  @useResult
  static FPopoverController updateNested(
    FPopoverController controller,
    TickerProvider vsync,
    bool? shown,
    ValueChanged<bool>? onChange,
  ) {
    switch ((controller, shown != null)) {
      // Lifted -> Lifted
      case (final LiftedPopoverController lifted, true):
        lifted.update(shown!, onChange!);
        return lifted;

      // Lifted -> Internal
      case (LiftedPopoverController(), false):
        controller.dispose();
        return FPopoverController(vsync: vsync);

      // Internal -> Lifted
      case (_, true) when controller is! LiftedPopoverController:
        controller.dispose();
        return LiftedPopoverController(shown!, onChange!, vsync: vsync);

      default:
        return controller;
    }
  }

  OverlayPortalController get overlay => _overlay;

  Animation<double> get scale => _scale;

  Animation<double> get fade => _fade;
}

@internal
class LiftedPopoverController extends FPopoverController {
  int _monotonic;
  void Function(bool shown) _onChange;

  LiftedPopoverController(bool shown, this._onChange, {required super.vsync, super.motion}) : _monotonic = 0 {
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

/// Defines how a popover's shown state is controlled.
sealed class FPopoverControl with Diagnosticable, _$FPopoverControlMixin {
  /// Creates a [FPopoverControl] for controlling a popover using lifted state.
  ///
  /// The [shown] parameter indicates whether the popover is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FPopoverControl.lifted({
    required bool shown,
    required ValueChanged<bool> onChange,
    FPopoverMotion motion,
  }) = Lifted;

  /// Creates a [FPopoverControl] for controlling a popover using a controller.
  ///
  /// Either [controller] or [motion] can be provided. If neither is provided,
  /// an internal controller with default motion is created.
  ///
  /// The [onChange] callback is invoked when the popover's shown state changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [motion] are provided.
  const factory FPopoverControl.managed({
    FPopoverController? controller,
    FPopoverMotion? motion,
    ValueChanged<bool>? onChange,
  }) = Managed;

  const FPopoverControl._();

  (FPopoverController, bool) _update(
    FPopoverControl old,
    FPopoverController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

@internal
class Lifted extends FPopoverControl with _$LiftedMixin {
  @override
  final bool shown;
  @override
  final ValueChanged<bool> onChange;
  @override
  final FPopoverMotion motion;

  const Lifted({required this.shown, required this.onChange, this.motion = const .new()}) : super._();

  @override
  FPopoverController _create(VoidCallback callback, TickerProvider vsync) =>
      LiftedPopoverController(vsync: vsync, shown, onChange, motion: motion);

  @override
  void _updateController(FPopoverController controller, TickerProvider vsync) =>
      (controller as LiftedPopoverController).update(shown, onChange);
}

@internal
class Managed extends FPopoverControl with Diagnosticable, _$ManagedMixin {
  @override
  final FPopoverController? controller;
  @override
  final FPopoverMotion? motion;
  @override
  final ValueChanged<bool>? onChange;

  const Managed({this.controller, this.motion, this.onChange})
    : assert(controller == null || motion == null, 'Cannot provide both controller and motion'),
      super._();

  @override
  FPopoverController _create(VoidCallback callback, TickerProvider vsync) =>
      (controller ?? .new(vsync: vsync, motion: motion ?? const .new()))..addListener(callback);
}
