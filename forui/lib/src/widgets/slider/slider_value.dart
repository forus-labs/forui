import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FSlider]'s active track/value.
sealed class FSliderValue with Diagnosticable {
  /// The value's minimum and maximum constraints along the slider's track, in logical pixels.
  final ({double min, double max, double extent}) pixelConstraints;

  /// The value's minimum and maximum constraints along the slider's track, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  /// * 1 < max
  final ({double min, double max}) constraints;

  /// The value's current minimum and maximum offset along the slider's track, in logical pixels.
  final ({double min, double max}) pixels;

  /// The value's current minimum value along the slider's track, in percentage.
  ///
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * total percentage is less than `constraints.min`.
  /// * total percentage is greater than `constraints.max`.
  final double min;

  /// The value's current maximum value along the slider's track, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * max <= min
  /// * 1 <= max
  /// * total percentage is less than `constraints.min`.
  /// * total percentage is greater than `constraints.max`.
  final double max;

  /// Creates a [FSliderValue].
  factory FSliderValue({required double max, double min, ({double min, double max}) constraints}) = _Value;

  FSliderValue._({
    required double extent,
    required ({double min, double max}) constraints,
    required double min,
    required double max,
  }) : this._copy(
         pixelConstraints: (min: constraints.min * extent, max: constraints.max * extent, extent: extent),
         constraints: constraints,
         pixels: (min: min * extent, max: max * extent),
         min: min,
         max: max,
       );

  FSliderValue._copy({
    required this.pixelConstraints,
    required this.constraints,
    required this.pixels,
    required this.min,
    required this.max,
  }) : assert(constraints.min >= 0, 'extent.min (${constraints.min}) must be >= 0'),
       assert(
         constraints.max >= constraints.min,
         'extent.min (${constraints.min}) must be <= extent.max (${constraints.max})',
       ),
       assert(constraints.max <= 1, 'extent.max (${constraints.max}) must be <= 1'),
       assert(min >= 0, 'min ($min) must be >= 0'),
       assert(max >= min, 'min ($min) must be <= max ($max)'),
       assert(max <= 1, 'max ($max) must be <= 1');

  /// Returns a [FSliderValue] which [min] edge is increased/decreased to the next/previous step.
  @useResult
  FSliderValue step({required bool min, required bool expand});

  /// Returns a [FSliderValue] which [min] edge is moved to [to].
  @useResult
  FSliderValue move({required bool min, required double to});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('pixelConstraints', pixelConstraints.toString()))
      ..add(StringProperty('constraints', constraints.toString()))
      ..add(StringProperty('pixels', pixels.toString()))
      ..add(PercentProperty('min', min))
      ..add(PercentProperty('max', max));
  }
}

final class _Value extends FSliderValue {
  _Value({required super.max, super.min = 0, super.constraints = (min: 0, max: 1)})
    : super._copy(pixelConstraints: (min: 0, max: 0, extent: 0), pixels: (min: 0, max: 0));

  @override
  FSliderValue step({required bool min, required bool expand}) => this;

  @override
  FSliderValue move({required bool min, required double to}) => this;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderValue &&
          runtimeType == other.runtimeType &&
          pixelConstraints == other.pixelConstraints &&
          constraints == other.constraints &&
          pixels == other.pixels &&
          min == other.min &&
          max == other.max;

  @override
  int get hashCode => pixelConstraints.hashCode ^ constraints.hashCode ^ pixels.hashCode ^ min.hashCode ^ max.hashCode;
}

@internal
final class ContinuousValue extends FSliderValue {
  final double _step;

  ContinuousValue({
    required double step,
    required super.extent,
    required super.constraints,
    required super.min,
    required super.max,
  }) : assert(0 < step && step <= 1, 'step must be > 0 and <= 1, but is $step.'),
       _step = step,
       super._();

  ContinuousValue._({
    required double step,
    required super.pixelConstraints,
    required super.constraints,
    required super.pixels,
  }) : _step = step,
       super._copy(min: pixels.min / pixelConstraints.extent, max: pixels.max / pixelConstraints.extent);

  @override
  ContinuousValue step({required bool min, required bool expand}) {
    final edge = min ? pixels.min : pixels.max;
    final step = pixelConstraints.extent * _step;
    return move(min: min, to: edge + ((min ^ expand) ? step : -step));
  }

  @override
  ContinuousValue move({required bool min, required double to}) {
    if (to < 0) {
      to = 0;
    } else if (pixelConstraints.extent < to) {
      to = pixelConstraints.extent;
    }

    return ContinuousValue._(
      step: _step,
      pixelConstraints: (min: pixelConstraints.min, max: pixelConstraints.max, extent: pixelConstraints.extent),
      constraints: constraints,
      pixels: switch (min) {
        true when pixels.max - to < pixelConstraints.min => (min: pixels.max - pixelConstraints.min, max: pixels.max),
        true when pixels.max - to > pixelConstraints.max => (min: pixels.max - pixelConstraints.max, max: pixels.max),
        true => (min: to, max: pixels.max),
        false when to - pixels.min < pixelConstraints.min => (min: pixels.min, max: pixels.min + pixelConstraints.min),
        false when to - pixels.min > pixelConstraints.max => (min: pixels.min, max: pixels.min + pixelConstraints.max),
        false => (min: pixels.min, max: to),
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContinuousValue &&
          runtimeType == other.runtimeType &&
          pixelConstraints == other.pixelConstraints &&
          constraints == other.constraints &&
          pixels == other.pixels &&
          min == other.min &&
          max == other.max &&
          _step == other._step;

  @override
  int get hashCode =>
      pixelConstraints.hashCode ^ constraints.hashCode ^ pixels.hashCode ^ min.hashCode ^ max.hashCode ^ _step.hashCode;
}

@internal
final class DiscreteValue extends FSliderValue {
  final SplayTreeMap<double, void> ticks;

  DiscreteValue({
    required this.ticks,
    required double min,
    required double max,
    required super.extent,
    required super.constraints,
  }) : assert(ticks.isNotEmpty, 'ticks must not be empty.'),
       assert(ticks.keys.every((tick) => 0 <= tick && tick <= 1), 'Every tick must be >= 0 and <= 1.'),
       super._(min: ticks.round(min), max: ticks.round(max));

  DiscreteValue._({
    required this.ticks,
    required super.pixelConstraints,
    required super.constraints,
    required super.min,
    required super.max,
  }) : super._copy(pixels: (min: min * pixelConstraints.extent, max: max * pixelConstraints.extent));

  @override
  DiscreteValue step({required bool min, required bool expand}) => _move(
    min: min,
    to: switch ((min, expand)) {
      (true, true) => ticks.lastKeyBefore(this.min) ?? this.min,
      (true, false) => ticks.firstKeyAfter(this.min) ?? this.min,
      (false, true) => ticks.firstKeyAfter(max) ?? max,
      (false, false) => ticks.lastKeyBefore(max) ?? max,
    },
  );

  @override
  DiscreteValue move({required bool min, required double to}) => _move(min: min, to: to / pixelConstraints.extent);

  DiscreteValue _move({required bool min, required double to}) {
    if ((min ? this.min : max) == to) {
      return this;
    }

    // Round to the nearest tick that satisfy the extent constraints.
    to = ticks.round(to);
    final (minValue, maxValue) = switch (min) {
      true when max - to < constraints.min => (
        ticks
            .lastKeysBefore(to)
            .takeWhile((tick) => this.min < tick)
            .firstWhere((tick) => constraints.min <= max - tick, orElse: () => this.min),
        max,
      ),
      true when constraints.max < max - to => (
        ticks
            .firstKeysAfter(to)
            .takeWhile((tick) => tick < this.min)
            .firstWhere((tick) => max - tick <= constraints.max, orElse: () => this.min),
        max,
      ),
      true => (to, max),
      false when to - this.min < constraints.min => (
        this.min,
        ticks
            .firstKeysAfter(to)
            .takeWhile((tick) => tick < max)
            .firstWhere((tick) => constraints.min <= tick - this.min, orElse: () => max),
      ),
      false when constraints.max < to - this.min => (
        this.min,
        ticks
            .lastKeysBefore(to)
            .takeWhile((tick) => max < tick)
            .firstWhere((tick) => tick - this.min <= constraints.max, orElse: () => max),
      ),
      false => (this.min, to),
    };

    return DiscreteValue._(
      ticks: ticks,
      pixelConstraints: pixelConstraints,
      constraints: constraints,
      min: minValue,
      max: maxValue,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('ticks', ticks));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscreteValue &&
          runtimeType == other.runtimeType &&
          pixelConstraints == other.pixelConstraints &&
          constraints == other.constraints &&
          pixels == other.pixels &&
          min == other.min &&
          max == other.max &&
          mapEquals(ticks, other.ticks);

  @override
  int get hashCode =>
      pixelConstraints.hashCode ^ constraints.hashCode ^ pixels.hashCode ^ min.hashCode ^ max.hashCode ^ ticks.hashCode;
}

@internal
extension SplayTreeMaps on SplayTreeMap<double, void> {
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
