import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

part 'time_field_controller.control.dart';

/// The time field's controller.
class FTimeFieldController extends FValueNotifier<FTime?> {
  static String? _defaultValidator(FTime? _) => null;

  /// The controller for the popover. Does nothing if the time field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FTimeFieldController] instead.
  final FPopoverController popover;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a time in a picker is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<FTime> validator;

  final FTimePickerController _picker;
  bool _mutating = false;

  /// Creates a [FTimeFieldController].
  FTimeFieldController({
    required TickerProvider vsync,
    FTime? initialTime,
    String? Function(FTime?) validator = _defaultValidator,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : this._(
         popover: FPopoverController(vsync: vsync, motion: popoverMotion),
         initialTime: initialTime,
         validator: validator,
       );

  FTimeFieldController._({required this.popover, required FTime? initialTime, this.validator = _defaultValidator})
    : _picker = FTimePickerController(initial: initialTime ?? const FTime()),
      super(initialTime) {
    _picker.addValueListener((time) {
      try {
        _mutating = true;
        value = time;
      } finally {
        _mutating = false;
      }
    });

    addValueListener(update);
  }

  @override
  void dispose() {
    _picker.dispose();
    popover.dispose();
    super.dispose();
  }
}

@internal
extension InternalFTimeFieldController on FTimeFieldController {
  void update(FTime? time) {
    if (!_mutating && time != null) {
      _picker.value = time;
    }
  }

  FTimePickerController get picker => _picker;
}

class _Controller extends FTimeFieldController {
  late FPopoverController _popover;
  ValueChanged<FTime?> _onChange;
  int _monotonic = 0;

  _Controller({
    required TickerProvider vsync,
    required FTime? value,
    required ValueChanged<FTime?> onChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : _onChange = onChange,
       super._(
         popover: popoverShown != null && onPopoverChange != null
             ? LiftedPopoverController(popoverShown, onPopoverChange, vsync: vsync, motion: popoverMotion)
             : FPopoverController(vsync: vsync, motion: popoverMotion),
         initialTime: value,
       ) {
    _popover = super.popover; // This prevents the creation of two popover controllers, with one being shadowed.
  }

  void _update(
    TickerProvider vsync,
    FTime? value,
    ValueChanged<FTime?> onChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    Duration duration,
    Curve curve,
  ) {
    _onChange = onChange;
    _popover = InternalFPopoverController.updateNested(_popover, vsync, popoverShown, onPopoverChange);

    if (super.value == value) {
      return;
    }

    if (_popover.status.isForwardOrCompleted) {
      final current = ++_monotonic;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (current == _monotonic) {
          _picker.animateTo(value ?? const FTime(), duration: duration, curve: curve);
        }
      });
    } else {
      super.value = value;
    }
  }

  @override
  set value(FTime? value) {
    if (super.value != value) {
      super.value = value;
      final current = ++_monotonic;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (current == _monotonic) {
          _onChange(value);
        }
      });
    }
  }

  @override
  FPopoverController get popover => _popover;
}

/// A [FTimeFieldControl] defines how a [FTimeField] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTimeFieldControl with Diagnosticable, _$FTimeFieldControlMixin {
  /// Creates lifted state control.
  ///
  /// Time value is always lifted.
  /// Popover visibility is optionally lifted - if [popoverShown] is provided, [onPopoverChange] must also be provided.
  ///
  /// The [value] parameter contains the current selected time.
  /// The [onChange] callback is invoked when the user selects a time.
  /// The [duration] when animating to [value] from an invalid/different time. Defaults to 200 milliseconds.
  /// The [curve] when animating to [value] from an invalid/different time. Defaults to [Curves.easeOutCubic].
  ///
  /// ## Contract
  /// Throws [AssertionError] if only one of [popoverShown]/[onPopoverChange] is provided.
  const factory FTimeFieldControl.lifted({
    required FTime? value,
    required ValueChanged<FTime?> onChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion motion,
    Duration duration,
    Curve curve,
  }) = Lifted;

  /// Creates a [FTimeFieldControl].
  const factory FTimeFieldControl.managed({
    FTimeFieldController? controller,
    FTime? initial,
    FormFieldValidator<FTime>? validator,
    FPopoverMotion? popoverMotion,
    ValueChanged<FTime?>? onChange,
  }) = FTimeFieldManagedControl;

  const FTimeFieldControl._();

  (FTimeFieldController, bool) _update(
    FTimeFieldControl old,
    FTimeFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

@internal
class Lifted extends FTimeFieldControl with _$LiftedMixin {
  @override
  final FTime? value;
  @override
  final ValueChanged<FTime?> onChange;
  @override
  final bool? popoverShown;
  @override
  final ValueChanged<bool>? onPopoverChange;
  @override
  final FPopoverMotion motion;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const Lifted({
    required this.value,
    required this.onChange,
    this.popoverShown,
    this.onPopoverChange,
    this.motion = const FPopoverMotion(),
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  }) : assert(
         (popoverShown == null) == (onPopoverChange == null),
         'popoverShown and onPopoverChange must both be provided or both be null.',
       ),
       super._();

  @override
  FTimeFieldController createController(TickerProvider vsync) => _Controller(
    vsync: vsync,
    value: value,
    onChange: onChange,
    popoverShown: popoverShown,
    onPopoverChange: onPopoverChange,
    popoverMotion: motion,
  );

  @override
  void _updateController(FTimeFieldController controller, TickerProvider vsync) =>
      (controller as _Controller)._update(vsync, value, onChange, popoverShown, onPopoverChange, duration, curve);
}

/// A [FTimeFieldManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FTimeFieldManagedControl extends FTimeFieldControl with Diagnosticable, _$FTimeFieldManagedControlMixin {
  /// The controller.
  @override
  final FTimeFieldController? controller;

  /// The initial time. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final FTime? initial;

  /// The validator. Defaults to no validation.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [validator] and [controller] are both provided.
  @override
  final FormFieldValidator<FTime>? validator;

  /// The popover motion. Defaults to [FPopoverMotion].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [popoverMotion] and [controller] are both provided.
  @override
  final FPopoverMotion? popoverMotion;

  /// Called when the selected time changes.
  @override
  final ValueChanged<FTime?>? onChange;

  /// Creates a [FTimeFieldControl].
  const FTimeFieldManagedControl({this.controller, this.initial, this.validator, this.popoverMotion, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      assert(controller == null || popoverMotion == null, 'Cannot provide both controller and popoverMotion.'),
      assert(controller == null || validator == null, 'Cannot provide both controller and validator.'),
      super._();

  @override
  FTimeFieldController createController(TickerProvider vsync) =>
      controller ??
      FTimeFieldController(
        vsync: vsync,
        initialTime: initial,
        validator: validator ?? FTimeFieldController._defaultValidator,
        popoverMotion: popoverMotion ?? const FPopoverMotion(),
      );
}
