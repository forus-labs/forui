import 'package:flutter/animation.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A [FTimePicker]'s controller.
final class FTimePickerController extends FValueNotifier<FTime> {
  FPickerController? _picker;
  bool _mutating = false;
  late bool _hours12;
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
      if (hours12) value.hour < 12 ? 0 : 1,
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
      _picker?.value = encode();
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
  List<int> encode() => [
    (value.hour / hourInterval).round(),
    (value.minute / minuteInterval).round(),
    if (hours12) value.hour < 12 ? 0 : 1,
  ];

  /// Decodes the current picker wheels as an [FTime].
  void decode() {
    if (_mutating) {
      return;
    }

    final indexes = _picker!.value;

    var hour = (indexes[0] * hourInterval) % (hours12 ? 12 : 24);
    if (hours12 && indexes[2].isOdd) {
      hour += 12;
    }

    _value = FTime(hour, (indexes[1] * minuteInterval) % 60);
  }

  FPickerController? get picker => _picker;

  set picker(FPickerController? controller) => _picker = controller;

  bool get mutating => _mutating;

  bool get hours12 => _hours12;

  set hours12(bool value) => _hours12 = value;

  int get hourInterval => _hourInterval;

  set hourInterval(int value) => _hourInterval = value;

  int get minuteInterval => _minuteInterval;

  set minuteInterval(int value) => _minuteInterval = value;
}
