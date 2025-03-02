import 'package:flutter/animation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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
    Duration duration = const Duration(milliseconds: 100),
    Curve curve = Curves.decelerate,
  }) async {
    if (value == super.value) {
      return;
    }

    final values = [
      (value.hour / hourInterval).round(),
      (value.minute / minuteInterval).round(),
      if (!hours24) value.hour < 12 ? 0 : 1,
    ];

    try {
      _mutating = true;
      await Future.wait([
        for (final (index, wheel) in (_picker?.wheels ?? []).indexed)
          wheel.animateToItem(values[index], duration: duration, curve: curve),
      ]);
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
  /// Encodes the given [value] as picker wheels.
  List<int> encode(FTime value) {
    final indexes = [(value.hour / hourInterval).round(), (value.minute / minuteInterval).round()];

    if (!hours24) {
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

    var hour = (indexes[hourIndex] * hourInterval) % (hours24 ? 24 : 12);
    if (!hours24 && indexes[periodIndex].isOdd) {
      hour += 12;
    }

    _value = FTime(hour, (indexes[hourIndex + 1] * minuteInterval) % 60);
  }

  FPickerController? get picker => _picker;

  set picker(FPickerController? controller) => _picker = controller;

  bool get mutating => _mutating;

  String get pattern => _pattern;

  set pattern(String value) => _pattern = value;

  bool get hours24 => _hours24;

  set hours24(bool value) => _hours24 = value;

  int get hourInterval => _hourInterval;

  set hourInterval(int value) => _hourInterval = value;

  int get minuteInterval => _minuteInterval;

  set minuteInterval(int value) => _minuteInterval = value;
}
