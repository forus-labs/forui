// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'time_field_controller.control.dart';

/// The time field's controller.
class FTimeFieldController extends FValueNotifier<FTime?> {
  static String? _defaultValidator(FTime? _) => null;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a time in a picker is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<FTime> validator;

  final FTimePickerController _picker;
  bool _mutating = false;

  /// Creates a [FTimeFieldController].
  FTimeFieldController({FTime? initial, this.validator = _defaultValidator})
    : _picker = FTimePickerController(initial: initial ?? const FTime()),
      super(initial) {
    _picker.addValueListener((time) {
      try {
        _mutating = true;
        value = time;
      } finally {
        _mutating = false;
      }
    });

    addValueListener(_update);
  }

  void _update(FTime? time) {
    if (!_mutating && time != null) {
      _picker.value = time;
    }
  }

  @override
  void dispose() {
    _picker.dispose();
    super.dispose();
  }
}

@internal
extension InternalFTimeFieldController on FTimeFieldController {
  FTimePickerController get picker => _picker;
}

class _ProxyController extends FTimeFieldController {
  FTime? _unsynced;
  ValueChanged<FTime?> _onChange;
  Duration _duration;
  Curve _curve;
  int _monotonic = 0;

  _ProxyController({
    required super.initial,
    required ValueChanged<FTime?> onChange,
    required Duration duration,
    required Curve curve,
  }) : _unsynced = initial,
       _onChange = onChange,
       _duration = duration,
       _curve = curve;

  void update(FTime? newValue, ValueChanged<FTime?> onChange, bool shown, Duration duration, Curve curve) {
    _onChange = onChange;
    _duration = duration;
    _curve = curve;

    final current = ++_monotonic;
    if (super.value != newValue) {
      _unsynced = newValue;
      if (shown) {
        _animateTo(newValue, current);
      } else {
        super.value = newValue;
      }
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      if (shown) {
        _animateTo(newValue, current);
      }
      notifyListeners();
    }
  }

  @override
  set value(FTime? value) {
    _unsynced = value;

    final current = ++_monotonic;
    if (super.value != value) {
      _onChange(value);
      _animateTo(super.value, current);
    }
  }

  void _animateTo(FTime? value, int current) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (current == _monotonic) {
        _picker.animateTo(value ?? const FTime(), duration: _duration, curve: _curve);
      }
    });
  }
}

/// A [FTimeFieldControl] defines how a [FTimeField] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTimeFieldControl with Diagnosticable, _$FTimeFieldControlMixin {
  /// Creates a [FTimeFieldControl].
  const factory FTimeFieldControl.managed({
    FTimeFieldController? controller,
    FTime? initial,
    FormFieldValidator<FTime>? validator,
    ValueChanged<FTime?>? onChange,
  }) = FTimeFieldManagedControl;

  /// Creates lifted state control.
  ///
  /// The [value] parameter contains the current selected time.
  /// The [onChange] callback is invoked when the user selects a time.
  /// The [duration] when animating to [value] from an invalid/different time. Defaults to 200 milliseconds.
  /// The [curve] when animating to [value] from an invalid/different time. Defaults to [Curves.easeOutCubic].
  const factory FTimeFieldControl.lifted({
    required FTime? value,
    required ValueChanged<FTime?> onChange,
    Duration duration,
    Curve curve,
  }) = _Lifted;

  const FTimeFieldControl._();

  (FTimeFieldController, bool) _update(
    FTimeFieldControl old,
    FTimeFieldController controller,
    VoidCallback callback,
    bool shown,
  );
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

  /// Called when the selected time changes.
  @override
  final ValueChanged<FTime?>? onChange;

  /// Creates a [FTimeFieldControl].
  const FTimeFieldManagedControl({this.controller, this.initial, this.validator, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      assert(controller == null || validator == null, 'Cannot provide both controller and validator.'),
      super._();

  @override
  FTimeFieldController createController(bool _) =>
      controller ?? .new(initial: initial, validator: validator ?? FTimeFieldController._defaultValidator);
}

class _Lifted extends FTimeFieldControl with _$_LiftedMixin {
  @override
  final FTime? value;
  @override
  final ValueChanged<FTime?> onChange;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const _Lifted({
    required this.value,
    required this.onChange,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
  }) : super._();

  @override
  FTimeFieldController createController(bool _) =>
      _ProxyController(initial: value, onChange: onChange, duration: duration, curve: curve);

  @override
  void _updateController(FTimeFieldController controller, bool shown) =>
      (controller as _ProxyController).update(value, onChange, shown, duration, curve);
}
