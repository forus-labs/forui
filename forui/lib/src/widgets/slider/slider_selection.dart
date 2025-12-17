import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FSlider]'s active track/selection.
sealed class FSliderSelection with Diagnosticable {
  /// The selection's minimum and maximum constraints along the slider's track, in logical pixels.
  final ({double min, double max, double total}) pixelConstraints;

  /// The selection's minimum and maximum constraints along the slider's track, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  /// * 1 < max
  final ({double min, double max}) constraints;

  /// The selection's current minimum and maximum offset along the slider's track, in logical pixels.
  final ({double min, double max}) pixels;

  /// The selection's current minimum value along the slider's track, in percentage.
  ///
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * total percentage is less than `constraints.min`.
  /// * total percentage is greater than `constraints.max`.
  final double min;

  /// The selection's current maximum value along the slider's track, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * max <= min
  /// * 1 <= max
  /// * total percentage is less than `constraints.min`.
  /// * total percentage is greater than `constraints.max`.
  final double max;

  /// Creates a [FSliderSelection].
  factory FSliderSelection({required double max, double min, ({double min, double max}) constraints}) = _Selection;

  FSliderSelection._({
    required double mainAxisExtent,
    required ({double min, double max}) constraints,
    required double min,
    required double max,
  }) : this._copy(
         pixelConstraints: (
           min: constraints.min * mainAxisExtent,
           max: constraints.max * mainAxisExtent,
           total: mainAxisExtent,
         ),
         constraints: constraints,
         pixels: (min: min * mainAxisExtent, max: max * mainAxisExtent),
         min: min,
         max: max,
       );

  FSliderSelection._copy({
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

  /// Returns a [FSliderSelection] which [min] edge is extended/shrunk to the previous/next step.
  @useResult
  FSliderSelection step({required bool min, required bool extend});

  /// Returns a [FSliderSelection] which [min] edge is extended/shrunk to the given offset.
  @useResult
  FSliderSelection move({required bool min, required double to});

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

final class _Selection extends FSliderSelection {
  _Selection({required super.max, super.min = 0, super.constraints = (min: 0, max: 1)})
    : super._copy(pixelConstraints: (min: 0, max: 0, total: 0), pixels: (min: 0, max: 0));

  @override
  FSliderSelection step({required bool min, required bool extend}) => this;

  @override
  FSliderSelection move({required bool min, required double to}) => this;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderSelection &&
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
final class ContinuousSelection extends FSliderSelection {
  final double _step;

  ContinuousSelection({
    required double step,
    required super.mainAxisExtent,
    required super.constraints,
    required super.min,
    required super.max,
  }) : assert(0 < step && step <= 1, 'step must be > 0 and <= 1, but is $step.'),
       _step = step,
       super._();

  ContinuousSelection._({
    required double step,
    required super.pixelConstraints,
    required super.constraints,
    required super.pixels,
  }) : _step = step,
       super._copy(min: pixels.min / pixelConstraints.total, max: pixels.max / pixelConstraints.total);

  @override
  ContinuousSelection step({required bool min, required bool extend}) {
    final edge = min ? pixels.min : pixels.max;
    final step = pixelConstraints.total * _step;
    return move(min: min, to: edge + ((min ^ extend) ? step : -step));
  }

  @override
  ContinuousSelection move({required bool min, required double to}) {
    if (to < 0) {
      to = 0;
    } else if (pixelConstraints.total < to) {
      to = pixelConstraints.total;
    }

    return ContinuousSelection._(
      step: _step,
      pixelConstraints: (min: pixelConstraints.min, max: pixelConstraints.max, total: pixelConstraints.total),
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
      other is ContinuousSelection &&
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
final class DiscreteSelection extends FSliderSelection {
  final SplayTreeMap<double, void> ticks;

  DiscreteSelection({
    required this.ticks,
    required double min,
    required double max,
    required super.mainAxisExtent,
    required super.constraints,
  }) : assert(ticks.isNotEmpty, 'ticks must not be empty.'),
       assert(ticks.keys.every((tick) => 0 <= tick && tick <= 1), 'Every tick must be >= 0 and <= 1.'),
       super._(min: ticks.round(min), max: ticks.round(max));

  DiscreteSelection._({
    required this.ticks,
    required ({double min, double max, double total}) pixelConstraints,
    required super.constraints,
    required double min,
    required double max,
  }) : super._copy(
         min: min,
         max: max,
         pixelConstraints: pixelConstraints,
         pixels: (min: min * pixelConstraints.total, max: max * pixelConstraints.total),
       );

  @override
  DiscreteSelection step({required bool min, required bool extend}) => _move(
    min: min,
    to: switch ((min, extend)) {
      (true, true) => ticks.lastKeyBefore(this.min) ?? this.min,
      (true, false) => ticks.firstKeyAfter(this.min) ?? this.min,
      (false, true) => ticks.firstKeyAfter(max) ?? max,
      (false, false) => ticks.lastKeyBefore(max) ?? max,
    },
  );

  @override
  DiscreteSelection move({required bool min, required double to}) => _move(min: min, to: to / pixelConstraints.total);

  DiscreteSelection _move({required bool min, required double to}) {
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

    return DiscreteSelection._(
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
      other is DiscreteSelection &&
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
