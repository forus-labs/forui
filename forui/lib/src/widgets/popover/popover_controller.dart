import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
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

  /// Creates a [FPopoverController] with the given [vsync] and [motion].
  FPopoverController({required TickerProvider vsync, FPopoverMotion motion = const FPopoverMotion()}) {
    _animation = AnimationController(
      vsync: vsync,
      duration: motion.entranceDuration,
      reverseDuration: motion.exitDuration,
    );
    _curveFade = CurvedAnimation(parent: _animation, curve: motion.fadeInCurve, reverseCurve: motion.fadeOutCurve);
    _curveScale = CurvedAnimation(parent: _animation, curve: motion.expandCurve, reverseCurve: motion.collapseCurve);
    _scale = motion.scaleTween.animate(_curveScale);
    _fade = motion.fadeTween.animate(_curveFade);
  }

  /// Convenience method for showing/hiding the popover.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle() async =>
      const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_animation.status) ? hide() : show();

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
  OverlayPortalController get overlay => _overlay;

  Animation<double> get scale => _scale;

  Animation<double> get fade => _fade;
}

@internal
class LiftedController extends FPopoverController {
  int _monotonic;
  void Function(bool shown) _onChange;

  LiftedController(bool shown, this._onChange, {required super.vsync, super.motion}) : _monotonic = 0 {
    if (shown) {
      _overlay.show();
      _animation.value = 1;
    }
  }

  void update(bool shown, void Function(bool shown) onChange) {
    _onChange = onChange;
    final current = ++_monotonic;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (current != _monotonic) {
        return;
      }

      if (shown && status.isDismissed) {
        _overlay.show();
        _animation.forward();
      } else if (!shown && status.isForwardOrCompleted) {
        _animation.reverse().then((_) => _overlay.hide());
      }
    });
  }

  @override
  Future<void> show() async => _onChange(true);

  @override
  Future<void> hide() async => _onChange(false);
}

/// Defines how a popover's shown state is controlled.
sealed class FPopoverControl with Diagnosticable {
  /// Creates a [FPopoverControl] for controlling a popover using lifted state.
  ///
  /// The [shown] parameter indicates whether the popover is currently shown.
  /// The [onChange] callback is invoked when the user triggers a show/hide action.
  const factory FPopoverControl.lifted({
    required bool shown,
    required void Function(bool shown) onChange,
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
    void Function(bool shown)? onChange,
  }) = Managed;

  const FPopoverControl._();

  FPopoverController _create(VoidCallback callback, TickerProvider vsync);

  FPopoverController _update(
    FPopoverControl old,
    FPopoverController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );

  void _dispose(FPopoverController controller, VoidCallback callback);
}

@internal
class Lifted extends FPopoverControl with _$LiftedFunctions {
  @override
  final bool shown;
  @override
  final void Function(bool shown) onChange;
  @override
  final FPopoverMotion motion;

  const Lifted({required this.shown, required this.onChange, this.motion = const FPopoverMotion()}) : super._();

  @override
  FPopoverController _create(VoidCallback callback, TickerProvider vsync) =>
      LiftedController(vsync: vsync, shown, onChange, motion: motion);

  @override
  void _updateController(FPopoverController controller, TickerProvider vsync) =>
      (controller as LiftedController).update(shown, onChange);
}

@internal
class Managed extends FPopoverControl with Diagnosticable, _$ManagedFunctions {
  @override
  final FPopoverController? controller;
  @override
  final FPopoverMotion? motion;
  @override
  final void Function(bool shown)? onChange;

  const Managed({this.controller, this.motion, this.onChange})
    : assert(controller == null || motion == null, 'Cannot provide both controller and motion'),
      super._();

  @override
  FPopoverController _create(VoidCallback callback, TickerProvider vsync) =>
      (controller ?? .new(vsync: vsync, motion: motion ?? const .new()))..addListener(callback);
}
