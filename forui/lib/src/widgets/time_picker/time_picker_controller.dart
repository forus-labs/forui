import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';

part 'time_picker_controller.control.dart';

/// A [FTimePicker]'s controller.
final class FTimePickerController extends FValueNotifier<FTime> {
  FPickerController? _picker;
  bool _mutating = false;
  late String _pattern;
  late bool _hours24;
  late int _hourInterval;
  late int _minuteInterval;

  /// Creates a [FTimePickerController].
  FTimePickerController({FTime initial = const FTime()}) : super(initial);

  /// Animates the controller to the given [value].
  Future<void> animateTo(
    FTime value, {
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (value == super.value) {
      return;
    }

    final values = [
      (value.hour / _hourInterval).round(),
      (value.minute / _minuteInterval).round(),
      if (!_hours24) value.hour < 12 ? 0 : 1,
    ];

    try {
      _mutating = true;
      await Future.wait([
        for (final (index, wheel) in (_picker?.wheels ?? []).indexed)
          wheel.animateToItem(values[index], duration: duration, curve: curve),
      ]);
      // The value does not need to be explicitly set as the picker will update it via a listener.
    } finally {
      _mutating = false;
    }
  }

  @override
  set value(FTime value) {
    if (value == super.value) {
      return;
    }

    try {
      _mutating = true;
      super.value = value;
      _picker?.value = encode(value);
    } finally {
      _mutating = false;
    }
  }

  // ignore: avoid_setters_without_getters
  set _value(FTime value) => super.value = value;

  @override
  void dispose() {
    _picker?.dispose();
    super.dispose();
  }
}

@internal
extension FTimePickerControllers on FTimePickerController {
  void configure(DateFormat format, int hourInterval, int minuteInterval) {
    // This behavior isn't ideal since changing the hour/minute interval causes an unintuitive time to be shown.
    // It is difficult to fix without FixedExtentScrollController exposing the keepOffset parameter.
    // See https://github.com/flutter/flutter/issues/162972
    this
      .._pattern = format.pattern!
      .._hours24 = !format.pattern!.contains('a')
      .._hourInterval = hourInterval
      .._minuteInterval = minuteInterval;

    _picker?.dispose();
    _picker = FPickerController(initialIndexes: encode(value));
    _picker?.addListener(decode);
  }

  /// Encodes the given [value] as picker wheels.
  List<int> encode(FTime value) {
    final indexes = [(value.hour / _hourInterval).round(), (value.minute / _minuteInterval).round()];

    if (!_hours24) {
      final period = value.hour < 12 ? 0 : 1;
      _pattern.startsWith('a') ? indexes.insert(0, period) : indexes.add(period);
    }

    return indexes;
  }

  /// Decodes the current picker wheels as an [FTime].
  void decode() {
    final indexes = _picker!.value;
    final hourIndex = _pattern.startsWith('a') ? 1 : 0;
    final periodIndex = _pattern.startsWith('a') ? 0 : 2;

    var hour = (indexes[hourIndex] * _hourInterval) % (_hours24 ? 24 : 12);
    if (!_hours24 && indexes[periodIndex].isOdd) {
      hour += 12;
    }

    _value = FTime(hour, (indexes[hourIndex + 1] * _minuteInterval) % 60);
  }

  FPickerController? get picker => _picker;

  set picker(FPickerController? controller) => _picker = controller;

  bool get mutating => _mutating;

  String get pattern => _pattern;

  bool get hours24 => _hours24;

  int get hourInterval => _hourInterval;

  int get minuteInterval => _minuteInterval;
}

final class _Controller extends FTimePickerController {
  ValueChanged<FTime> _onChange;
  int _monotonic = 0;

  _Controller({required FTime value, required ValueChanged<FTime> onChange})
    : _onChange = onChange,
      super(initial: value);

  void update(FTime value, ValueChanged<FTime> onChange, Duration duration, Curve curve) {
    _onChange = onChange;

    final current = ++_monotonic;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (super.value != value && current == _monotonic) {
        animateTo(value, duration: duration, curve: curve);
      }
    });
  }

  @override
  set value(FTime value) {
    if (super.value != value) {
      super.value = value;
      _onChange(value);
    }
  }

  @override
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  set _value(FTime value) {
    if (super.value != value) {
      super._value = value;
      final current = ++_monotonic;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (current == _monotonic) {
          _onChange(value);
        }
      });
    }
  }
}

/// A [FTimePickerControl] defines how a [FTimePicker] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTimePickerControl with Diagnosticable, _$FTimePickerControlMixin {
  /// Creates a [FTimePickerControl] for controlling time picker using lifted state.
  ///
  /// It does not prevent the user from scrolling to invalid indexes. To animate back to the provided [value],
  /// consider passing in `onChange: (_) => setState(() {})`.
  ///
  /// The [value] parameter contains the current selected time.
  /// The [onChange] callback is invoked when the user selects a time.
  /// The [duration] when animating to [value] from an invalid/different time. Defaults to 200 milliseconds.
  /// The [curve] when animating to [value] from an invalid/different time. Defaults to [Curves.easeOutCubic].
  const factory FTimePickerControl.lifted({
    required FTime value,
    required ValueChanged<FTime> onChange,
    Duration duration,
    Curve curve,
  }) = Lifted;

  /// Creates a [FTimePickerControl].
  const factory FTimePickerControl.managed({
    FTimePickerController? controller,
    FTime? initial,
    ValueChanged<FTime>? onChange,
  }) = FTimePickerManagedControl;

  const FTimePickerControl._();

  (FTimePickerController, bool) _update(
    FTimePickerControl old,
    FTimePickerController controller,
    VoidCallback callback,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  );

  @override
  FTimePickerController _default(
    FTimePickerControl old,
    FTimePickerController controller,
    VoidCallback _,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  ) => controller..configure(format, hourInterval, minuteInterval);
}

@internal
class Lifted extends FTimePickerControl with _$LiftedMixin {
  @override
  final FTime value;
  @override
  final ValueChanged<FTime> onChange;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const Lifted({
    required this.value,
    required this.onChange,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  }) : super._();

  @override
  FTimePickerController createController(DateFormat format, int hourInterval, int minuteInterval) =>
      (_Controller(value: value, onChange: onChange))..configure(format, hourInterval, minuteInterval);

  @override
  void _updateController(FTimePickerController controller, DateFormat format, int hourInterval, int minuteInterval) {
    (controller as _Controller)
      ..configure(format, hourInterval, minuteInterval)
      ..update(value, onChange, duration, curve);
  }
}

/// A [FTimePickerManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FTimePickerManagedControl extends FTimePickerControl with Diagnosticable, _$FTimePickerManagedControlMixin {
  /// The controller.
  @override
  final FTimePickerController? controller;

  /// The initial time. Defaults to 00:00.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final FTime? initial;

  /// Called when the time changes.
  @override
  final ValueChanged<FTime>? onChange;

  /// Creates a [FTimePickerControl].
  const FTimePickerManagedControl({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      super._();

  @override
  FTimePickerController createController(DateFormat format, int hourInterval, int minuteInterval) =>
      (controller ?? FTimePickerController(initial: initial ?? const FTime()))
        ..configure(format, hourInterval, minuteInterval);
}
