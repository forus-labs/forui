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
  String? _pattern;
  bool? _hours24;
  int? _hourInterval;
  int? _minuteInterval;

  /// Creates a [FTimePickerController].
  FTimePickerController({FTime time = const FTime()}) : super(time);

  /// Animates the controller to the given [value].
  Future<void> animateTo(
    FTime value, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (_rawValue != value) {
      await _animateTo(value, duration, curve);
    }
  }

  Future<void> _animateTo(FTime value, Duration duration, Curve curve) async {
    try {
      _mutating = true;
      await _picker?.animateTo(encode(value), duration: duration, curve: curve);
      // The value does not need to be explicitly set as the picker will update it via a listener.
    } finally {
      _mutating = false;
    }
  }

  @override
  set value(FTime value) {
    if (value != _rawValue) {
      try {
        _mutating = true;
        _rawValue = value;
        _picker?.value = encode(value);
      } finally {
        _mutating = false;
      }
    }
  }

  FTime get _rawValue => super.value;

  set _rawValue(FTime value) => super.value = value;

  @override
  void dispose() {
    _picker?.dispose();
    super.dispose();
  }
}

@internal
extension InternalFTimePickerController on FTimePickerController {
  bool configure(DateFormat format, int hourInterval, int minuteInterval) {
    // This behavior isn't ideal since changing the hour/minute interval causes an unintuitive time to be shown.
    // It is difficult to fix without FixedExtentScrollController exposing the keepOffset parameter.
    // See https://github.com/flutter/flutter/issues/162972
    final pattern = format.pattern!;
    final hours24 = !pattern.contains('a');
    if (_pattern == pattern &&
        _hours24 == hours24 &&
        _hourInterval == hourInterval &&
        _minuteInterval == minuteInterval) {
      return false;
    }

    _pattern = pattern;
    _hours24 = hours24;
    _hourInterval = hourInterval;
    _minuteInterval = minuteInterval;

    _picker?.dispose();
    _picker = FPickerController(indexes: encode(value));
    _picker?.addListener(decode);
    return true;
  }

  /// Encodes the given [value] as picker wheels.
  List<int> encode(FTime value) {
    final indexes = [(value.hour / _hourInterval!).round(), (value.minute / _minuteInterval!).round()];

    if (!_hours24!) {
      final period = value.hour < 12 ? 0 : 1;
      _pattern!.startsWith('a') ? indexes.insert(0, period) : indexes.add(period);
    }

    return indexes;
  }

  /// Decodes the current picker wheels as an [FTime].
  void decode() {
    final indexes = _picker!.value;
    final hourIndex = _pattern!.startsWith('a') ? 1 : 0;
    final periodIndex = _pattern!.startsWith('a') ? 0 : 2;

    var hour = (indexes[hourIndex] * _hourInterval!) % (_hours24! ? 24 : 12);
    if (!_hours24! && indexes[periodIndex].isOdd) {
      hour += 12;
    }

    _rawValue = FTime(hour, (indexes[hourIndex + 1] * _minuteInterval!) % 60);
  }

  FPickerController? get picker => _picker;

  set picker(FPickerController? controller) => _picker = controller;

  bool get mutating => _mutating;

  bool get hours24 => _hours24!;

  int get hourInterval => _hourInterval!;

  int get minuteInterval => _minuteInterval!;
}

final class _ProxyController extends FTimePickerController {
  FTime _unsynced;
  ValueChanged<FTime> _onChange;
  Duration _duration;
  Curve _curve;
  int _monotonic = 0;

  _ProxyController(this._unsynced, this._onChange, this._duration, this._curve) : super(time: _unsynced);

  void update(
    FTime newValue,
    ValueChanged<FTime> onChange,
    Duration duration,
    Curve curve,
    DateFormat format,
    int hourInterval,
    int minuteInterval,
  ) {
    _onChange = onChange;
    _duration = duration;
    _curve = curve;
    final current = ++_monotonic;

    if (configure(format, hourInterval, minuteInterval)) {
      return;
    }

    if (super._rawValue != newValue) {
      _unsynced = newValue;
      super._rawValue = newValue;
      _scrollTo(newValue, current);
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      _scrollTo(newValue, current);
    }
  }

  @override
  set _rawValue(FTime value) {
    final current = ++_monotonic;
    if (super._rawValue != value) {
      _unsynced = value;
      _onChange(value);
      _scrollTo(super._rawValue, current);
    }
  }

  void _scrollTo(FTime value, int current) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (current == _monotonic) {
        _animateTo(value, _duration, _curve);
      }
    });
  }
}

/// A [FTimePickerControl] defines how a [FTimePicker] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTimePickerControl with Diagnosticable, _$FTimePickerControlMixin {
  /// Creates a [FTimePickerControl].
  const factory FTimePickerControl.managed({
    FTimePickerController? controller,
    FTime? initial,
    ValueChanged<FTime>? onChange,
  }) = FTimePickerManagedControl;

  /// Creates a [FTimePickerControl] for controlling time picker using lifted state.
  ///
  /// It does not prevent the user from scrolling to invalid indexes. To animate back to the provided [time],
  /// consider passing in `onChange: (_) => setState(() {})`.
  ///
  /// The [time] parameter contains the current selected time.
  /// The [onChange] callback is invoked when the user selects a time.
  /// The [duration] when animating to [time] from an invalid/different time. Defaults to 200 milliseconds.
  /// The [curve] when animating to [time] from an invalid/different time. Defaults to [Curves.easeOutCubic].
  const factory FTimePickerControl.lifted({
    required FTime time,
    required ValueChanged<FTime> onChange,
    Duration duration,
    Curve curve,
  }) = _Lifted;

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
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial time. Pass initial time to the controller instead.',
      ),
      super._();

  @override
  FTimePickerController createController(DateFormat format, int hourInterval, int minuteInterval) =>
      (controller ?? .new(time: initial ?? const .new()))..configure(format, hourInterval, minuteInterval);
}

class _Lifted extends FTimePickerControl with _$_LiftedMixin {
  @override
  final FTime time;
  @override
  final ValueChanged<FTime> onChange;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const _Lifted({
    required this.time,
    required this.onChange,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
  }) : super._();

  @override
  FTimePickerController createController(DateFormat format, int hourInterval, int minuteInterval) =>
      (_ProxyController(time, onChange, duration, curve))..configure(format, hourInterval, minuteInterval);

  @override
  void _updateController(FTimePickerController controller, DateFormat format, int hourInterval, int minuteInterval) {
    (controller as _ProxyController).update(time, onChange, duration, curve, format, hourInterval, minuteInterval);
  }
}
