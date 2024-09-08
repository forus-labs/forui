import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

/// A [FSlider]'s value.
final class FSliderValue with Diagnosticable {
  /// The value's minimum and maximum extent along the main axis, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  /// * 1 < max
  final ({double min, double max}) extent;

  /// The value current minimum and maximum offset along the main axis, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  /// * 1 <= max
  /// * total percentage is less than `extent.min`.
  /// * total percentage is greater than `extent.max`.
  final ({double min, double max}) offset;

  /// Creates a [FSliderValue].
  FSliderValue({
    required this.offset,
    this.extent = (min: 0, max: 1),
  })  : assert(extent.min >= 0, 'Min extent must be >= 0, but is ${extent.min}.'),
        assert(extent.max > extent.min, 'Max extent must be > min extent, but is ${extent.max}.'),
        assert(extent.max <= 1, 'Max extent must be <= 1, but is ${extent.max}.'),
        assert(offset.min >= 0, 'Min offset must be >= 0, but is ${offset.min}.'),
        assert(offset.max > offset.min, 'Max offset must be > min offset, but is ${offset.max}.'),
        assert(offset.max <= 1, 'Max offset must be <=> 1, but is ${offset.max}.'),
        assert(offset.min >= extent.min, 'Min offset must be >= min extent, but is ${offset.min}.'),
        assert(offset.max <= extent.max, 'Max offset must be <= max extent, but is ${offset.max}.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('extent.min', extent.min))
      ..add(DoubleProperty('extent.max', extent.max))
      ..add(DoubleProperty('offset.min', offset.min))
      ..add(DoubleProperty('offset.max', offset.max));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderValue && runtimeType == other.runtimeType && extent == other.extent && offset == other.offset;

  @override
  int get hashCode => extent.hashCode ^ offset.hashCode;
}

@internal
sealed class Value extends FSliderValue {
  final ({double min, double max, double total}) rawExtent;
  final ({double min, double max}) rawOffset;

  Value({
    required double mainAxisExtent,
    required super.extent,
    required super.offset,
  })  : rawExtent = (min: extent.min * mainAxisExtent, max: extent.max * mainAxisExtent, total: mainAxisExtent),
        rawOffset = (min: offset.min * mainAxisExtent, max: offset.max * mainAxisExtent);

  Value._({
    required super.extent,
    required super.offset,
    required this.rawExtent,
    required this.rawOffset,
  });

  Value step({required bool min, required bool grow});

  Value move({required bool min, required double to});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('rawExtent.min', rawExtent.min))
      ..add(DoubleProperty('rawExtent.max', rawExtent.max))
      ..add(DoubleProperty('rawExtent.total', rawExtent.total))
      ..add(DoubleProperty('rawOffset.min', rawOffset.min))
      ..add(DoubleProperty('rawOffset.max', rawOffset.max));
  }
}

@internal
final class ContinuousValue extends Value {
  final double _step;

  ContinuousValue({
    required double step,
    required super.mainAxisExtent,
    required super.extent,
    required super.offset,
  })  : assert(0 < step && step <= 1, 'step must be > 0 and <= 1, but is $step.'),
        _step = step;

  ContinuousValue._({
    required double step,
    required super.extent,
    required super.rawExtent,
    required super.rawOffset,
  })  : _step = step,
        super._(
          offset: (min: rawOffset.min / rawExtent.total, max: rawOffset.max / rawExtent.total),
        );

  @override
  ContinuousValue step({required bool min, required bool grow}) {
    final edge = min ? rawOffset.max : rawOffset.min;
    final step = rawExtent.total * _step;

    return move(min: min, to: edge + ((min ^ grow) ? step : -step));
  }

  @override
  ContinuousValue move({required bool min, required double to}) {
    final (minOffset, maxOffset) = switch (min) {
      true when rawExtent.max - to < rawExtent.min => (rawOffset.max - rawExtent.min, rawOffset.max),
      true when rawExtent.max - to > rawExtent.max => (rawOffset.max - rawExtent.min, rawOffset.max),
      true => (to, rawOffset.max),
      false when to - rawExtent.min < rawExtent.min => (rawOffset.min, rawOffset.min + rawExtent.min),
      false when to - rawExtent.min > rawExtent.max => (rawOffset.min, rawOffset.min + rawExtent.min),
      false => (rawOffset.min, to),
    };

    return ContinuousValue._(
      step: _step,
      extent: extent,
      rawExtent: rawExtent,
      rawOffset: (min: minOffset, max: maxOffset),
    );
  }
}

@internal
final class DiscreteValue extends Value {
  final SplayTreeMap<double, void> _marks;

  DiscreteValue({
    required SplayTreeMap<double, void> marks,
    required ({double min, double max}) offset,
    required super.mainAxisExtent,
    required super.extent,
  })  : assert(marks.isNotEmpty, 'marks must not be empty.'),
        assert(marks.keys.every((mark) => 0 <= mark && mark <= 1), 'Every mark must be >= 0 and <= 1.'),
        _marks = marks,
        super(offset: (min: marks.round(offset.min), max: marks.round(offset.max)));

  DiscreteValue._({
    required SplayTreeMap<double, void> marks,
    required super.offset,
    required super.extent,
    required super.rawExtent,
  })  : _marks = marks,
        super._(rawOffset: (min: offset.min * rawExtent.total, max: offset.max * rawExtent.total));

  @override
  DiscreteValue step({required bool min, required bool grow}) => _move(
        min: min,
        to: switch ((min, grow)) {
          (true, true) => _marks.lastKeyBefore(offset.min) ?? offset.min,
          (true, false) => _marks.firstKeyAfter(offset.min) ?? offset.min,
          (false, true) => _marks.lastKeyBefore(offset.max) ?? offset.max,
          (false, false) => _marks.lastKeyBefore(offset.max) ?? offset.max,
        },
      );

  @override
  DiscreteValue move({required bool min, required double to}) => _move(min: min, to: to / rawExtent.total);

  DiscreteValue _move({required bool min, required double to}) {
    if ((min ? offset.min : offset.max) == to) {
      return this;
    }

    to = _marks.round(to);
    final (minOffset, maxOffset) = switch (min) {
      true when extent.max - to < extent.min => (
          _marks
              .lastKeysBefore(to)
              .takeWhile((mark) => offset.min < mark)
              .firstWhere((mark) => extent.min <= extent.max - mark, orElse: () => offset.min),
          offset.max,
        ),
      true when extent.max < extent.max - to => (
          _marks
              .firstKeysAfter(to)
              .takeWhile((mark) => mark < offset.min)
              .firstWhere((mark) => extent.max - mark <= extent.max, orElse: () => offset.min),
          offset.max,
        ),
      true => (to, offset.max),
      false when to - extent.min < extent.min => (
          offset.min,
          _marks
              .firstKeysAfter(to)
              .takeWhile((mark) => mark < offset.max)
              .firstWhere((mark) => extent.min <= extent.min + mark, orElse: () => offset.max),
        ),
      false when extent.max < to - extent.min => (
          offset.min,
          _marks
              .lastKeysBefore(to)
              .takeWhile((mark) => offset.max < mark)
              .firstWhere((mark) => extent.min + mark <= extent.max, orElse: () => offset.max),
        ),
      false => (offset.min, to),
    };

    return DiscreteValue._(
      marks: _marks,
      offset: (min: minOffset, max: maxOffset),
      extent: extent,
      rawExtent: rawExtent,
    );
  }
}

extension on SplayTreeMap<double, void> {
  Iterable<double> firstKeysAfter(double value) sync* {
    var current = value;
    while (true) {
      final after = firstKeyAfter(current);
      if (after == null) {
        return;
      }

      yield current = after;
    }
  }

  Iterable<double> lastKeysBefore(double value) sync* {
    var current = value;
    while (true) {
      final before = lastKeyBefore(current);
      if (before == null) {
        return;
      }

      yield current = before;
    }
  }

  double round(double value) {
    if (containsKey(value)) {
      return value;
    }

    switch ((lastKeyBefore(value), firstKeyAfter(value))) {
      case (final before?, null):
        return before;

      case (null, final after?):
        return after;

      case (final before?, final after?):
        final diffBefore = (value - before).abs();
        final diffAfter = (value - after).abs();

        return diffBefore <= diffAfter ? before : after;

      default:
        throw ArgumentError('before and after must not be null.');
    }
  }
}
