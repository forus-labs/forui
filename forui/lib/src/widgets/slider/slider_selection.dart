import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

/// A [FSlider]'s active track/selection.
sealed class FSliderSelection with Diagnosticable {
  /// The selection's minimum and maximum extent along the slider's track, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  /// * 1 < max
  final ({double min, double max}) extent;

  /// The selection's current minimum and maximum offset along the slider's track, in percentage.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * min <= 0
  /// * max <= min
  /// * 1 <= max
  /// * total percentage is less than `extent.min`.
  /// * total percentage is greater than `extent.max`.
  final ({double min, double max}) offset;

  /// The selection's minimum and maximum extent along the slider's track, in logical pixels.
  final ({double min, double max, double total}) rawExtent;

  /// The selection's current minimum and maximum offset along the slider's track, in logical pixels.
  final ({double min, double max}) rawOffset;

  /// Creates a [FSliderSelection].
  factory FSliderSelection({
    required ({double min, double max}) offset,
    ({double min, double max}) extent,
  }) = _Selection;

  FSliderSelection._({
    required double mainAxisExtent,
    required ({double min, double max}) extent,
    required ({double min, double max}) offset,
  }) : this._copy(
          extent: extent,
          offset: offset,
          rawExtent: (min: extent.min * mainAxisExtent, max: extent.max * mainAxisExtent, total: mainAxisExtent),
          rawOffset: (min: offset.min * mainAxisExtent, max: offset.max * mainAxisExtent),
        );

  FSliderSelection._copy({
    required this.extent,
    required this.offset,
    required this.rawExtent,
    required this.rawOffset,
  })  : assert(extent.min >= 0, 'Min extent must be >= 0, but is ${extent.min}.'),
        assert(extent.max >= extent.min, 'Max extent must be > min extent, but is ${extent.max}.'),
        assert(extent.max <= 1, 'Max extent must be <= 1, but is ${extent.max}.'),
        assert(offset.min >= 0, 'Min offset must be >= 0, but is ${offset.min}.'),
        assert(offset.max >= offset.min, 'Max offset must be > min offset, but is ${offset.max}.'),
        assert(offset.max <= 1, 'Max offset must be <=> 1, but is ${offset.max}.');

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
      ..add(DoubleProperty('extent.min', extent.min))
      ..add(DoubleProperty('extent.max', extent.max))
      ..add(DoubleProperty('offset.min', offset.min))
      ..add(DoubleProperty('offset.max', offset.max))
      ..add(DoubleProperty('rawExtent.min', rawExtent.min))
      ..add(DoubleProperty('rawExtent.max', rawExtent.max))
      ..add(DoubleProperty('rawExtent.total', rawExtent.total))
      ..add(DoubleProperty('rawOffset.min', rawOffset.min))
      ..add(DoubleProperty('rawOffset.max', rawOffset.max));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderSelection &&
          runtimeType == other.runtimeType &&
          extent == other.extent &&
          offset == other.offset &&
          rawExtent == other.rawExtent &&
          rawOffset == other.rawOffset;

  @override
  int get hashCode => extent.hashCode ^ offset.hashCode ^ rawExtent.hashCode ^ rawOffset.hashCode;
}

final class _Selection extends FSliderSelection {
  _Selection({
    required super.offset,
    super.extent = (min: 0, max: 1),
  }) : super._copy(rawExtent: (min: 0, max: 0, total: 0), rawOffset: (min: 0, max: 0));

  @override
  FSliderSelection step({required bool min, required bool extend}) => this;

  @override
  FSliderSelection move({required bool min, required double to}) => this;
}

@internal
final class ContinuousSelection extends FSliderSelection {
  final double _step;

  ContinuousSelection({
    required double step,
    required super.mainAxisExtent,
    required super.extent,
    required super.offset,
  })  : assert(0 < step && step <= 1, 'step must be > 0 and <= 1, but is $step.'),
        _step = step,
        super._();

  ContinuousSelection._({
    required double step,
    required super.extent,
    required super.rawExtent,
    required super.rawOffset,
  })  : _step = step,
        super._copy(offset: (min: rawOffset.min / rawExtent.total, max: rawOffset.max / rawExtent.total));

  @override
  ContinuousSelection step({required bool min, required bool extend}) {
    final edge = min ? rawOffset.min : rawOffset.max;
    final step = rawExtent.total * _step;

    return move(min: min, to: edge + ((min ^ extend) ? step : -step));
  }

  @override
  ContinuousSelection move({required bool min, required double to}) {
    final (minOffset, maxOffset) = switch (min) {
      true when rawExtent.max - to < rawExtent.min => (rawOffset.max - rawExtent.min, rawOffset.max),
      true when rawExtent.max - to > rawExtent.max => (rawOffset.max - rawExtent.max, rawOffset.max),
      true => (to, rawOffset.max),
      false when to - rawExtent.min < rawExtent.min => (rawOffset.min, rawOffset.min + rawExtent.min),
      false when to - rawExtent.min > rawExtent.max => (rawOffset.min, rawOffset.min + rawExtent.max),
      false => (rawOffset.min, to),
    };

    return ContinuousSelection._(
      step: _step,
      extent: extent,
      rawExtent: (min: rawExtent.min, max: rawExtent.max, total: rawExtent.total),
      rawOffset: (min: minOffset, max: maxOffset),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContinuousSelection &&
          runtimeType == other.runtimeType &&
          extent == other.extent &&
          offset == other.offset &&
          rawExtent == other.rawExtent &&
          rawOffset == other.rawOffset &&
          _step == other._step;

  @override
  int get hashCode => extent.hashCode ^ offset.hashCode ^ rawExtent.hashCode ^ rawOffset.hashCode ^ _step.hashCode;
}

@internal
final class DiscreteSelection extends FSliderSelection {
  final SplayTreeMap<double, void> _ticks;

  DiscreteSelection({
    required SplayTreeMap<double, void> ticks,
    required ({double min, double max}) offset,
    required super.mainAxisExtent,
    required super.extent,
  })  : assert(ticks.isNotEmpty, 'ticks must not be empty.'),
        assert(ticks.keys.every((tick) => 0 <= tick && tick <= 1), 'Every tick must be >= 0 and <= 1.'),
        _ticks = ticks,
        super._(offset: (min: ticks.round(offset.min), max: ticks.round(offset.max)));

  DiscreteSelection._({
    required SplayTreeMap<double, void> ticks,
    required super.offset,
    required super.extent,
    required super.rawExtent,
  })  : _ticks = ticks,
        super._copy(rawOffset: (min: offset.min * rawExtent.total, max: offset.max * rawExtent.total));

  @override
  DiscreteSelection step({required bool min, required bool extend}) => _move(
        min: min,
        to: switch ((min, extend)) {
          (true, true) => _ticks.lastKeyBefore(offset.min) ?? offset.min,
          (true, false) => _ticks.firstKeyAfter(offset.min) ?? offset.min,
          (false, true) => _ticks.firstKeyAfter(offset.max) ?? offset.max,
          (false, false) => _ticks.lastKeyBefore(offset.max) ?? offset.max,
        },
      );

  @override
  DiscreteSelection move({required bool min, required double to}) => _move(min: min, to: to / rawExtent.total);

  DiscreteSelection _move({required bool min, required double to}) {
    if ((min ? offset.min : offset.max) == to) {
      return this;
    }

    // Round to the nearest tick that satisfy the extent constraints.
    to = _ticks.round(to);
    final (minOffset, maxOffset) = switch (min) {
      true when extent.max - to < extent.min => (
          _ticks
              .lastKeysBefore(to)
              .takeWhile((tick) => offset.min < tick)
              .firstWhere((tick) => extent.min <= extent.max - tick, orElse: () => offset.min),
          offset.max,
        ),
      true when extent.max < extent.max - to => (
          _ticks
              .firstKeysAfter(to)
              .takeWhile((tick) => tick < offset.min)
              .firstWhere((tick) => extent.max - tick <= extent.max, orElse: () => offset.min),
          offset.max,
        ),
      true => (to, offset.max),
      false when to - extent.min < extent.min => (
          offset.min,
          _ticks
              .firstKeysAfter(to)
              .takeWhile((tick) => tick < offset.max)
              .firstWhere((tick) => extent.min <= extent.min + tick, orElse: () => offset.max),
        ),
      false when extent.max < to - extent.min => (
          offset.min,
          _ticks
              .lastKeysBefore(to)
              .takeWhile((tick) => offset.max < tick)
              .firstWhere((tick) => extent.min + tick <= extent.max, orElse: () => offset.max),
        ),
      false => (offset.min, to),
    };

    return DiscreteSelection._(
      ticks: _ticks,
      offset: (min: minOffset, max: maxOffset),
      extent: extent,
      rawExtent: rawExtent,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('ticks', _ticks));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscreteSelection &&
          runtimeType == other.runtimeType &&
          extent == other.extent &&
          offset == other.offset &&
          rawExtent == other.rawExtent &&
          rawOffset == other.rawOffset &&
          _ticks.equals(other._ticks);

  @override
  int get hashCode => extent.hashCode ^ offset.hashCode ^ rawExtent.hashCode ^ rawOffset.hashCode ^ _ticks.hashCode;
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
