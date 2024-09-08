import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/platform.dart';
import 'package:meta/meta.dart';

/// Possible ways for a user to interact with a slider.
enum FSliderInteraction {
  /// Allows the user to interact with the slider by sliding anywhere on the track.
  slide,

  /// Allows the user to interact with the slider by sliding only the slider thumb.
  slideThumb,

  /// Allows the user to interact with the slider by tapping and sliding the slider thumb.
  tapAndSlideThumb,

  /// Allows the user to interact with the slider by tapping anywhere.
  tap,
}

class FSliderController extends ValueNotifier<FSliderValue> {
  static FSliderInteraction get _platform =>
      touchPlatforms.contains(defaultTargetPlatform) ? FSliderInteraction.slide : FSliderInteraction.tapAndSlideThumb;

  /// The slider thumb's tooltip controller.
  final FTooltipController tooltip;

  /// The slider's allowed interaction.
  ///
  /// Defaults to [FSliderInteraction.slide] on Android, Fuchsia and iOS, and [FSliderInteraction.tapAndSlideThumb] on
  /// other platforms.
  final FSliderInteraction allowedInteraction;

  /// Whether the slider is growable/shrinkable at the min and max edges.
  final ({bool min, bool max}) growable;

  /// True if the slider has discrete steps, and false if it is continuous. Defaults to false.
  final bool discrete;

  /// The percentage to move the slider edge by when the user presses the left or right arrow keys. Defaults to 0.01.
  ///
  /// Only used when [discrete] is false. The slider is always moved to the nearest mark when [discrete] is true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not between 0 and 1, inclusive.
  final double traversePercentage;

  /// The slider's marks.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [discrete] is true and [marks] is empty.
  final List<FSliderMark> marks;

  final SplayTreeMap<double, void> _marks;

  /// Creates a [FSliderController] for a slider that is growable at a single edge.
  FSliderController({
    required TickerProvider vsync,
    required FSliderValue value,
    this.discrete = false,
    this.traversePercentage = 0.01,
    this.marks = const [],
    FSliderInteraction? allowedInteraction,
    bool min = false,
  })  : assert(
          0 <= traversePercentage && traversePercentage <= 1,
          'traversePercentage must be between 0 and 1, but is $traversePercentage.',
        ),
        assert(!(discrete && marks.isEmpty), 'Discrete sliders must have at least one mark.'),
        tooltip = FTooltipController(vsync: vsync),
        allowedInteraction = allowedInteraction ?? _platform,
        growable = min ? (min: true, max: false) : (min: false, max: true),
        _marks = SplayTreeMap.fromIterable(marks.map((mark) => mark.offset), value: (_) {}),
        super(value);

  /// Creates a [FSliderController] for a range slider that is growable at both edges.
  FSliderController.range({
    required TickerProvider vsync,
    required FSliderValue value,
    this.discrete = false,
    this.traversePercentage = 0.01,
    this.marks = const [],
  })  : assert(
          0 <= traversePercentage && traversePercentage <= 1,
          'traversePercentage must be between 0 and 1, but is $traversePercentage.',
        ),
        assert(!(discrete && marks.isEmpty), 'Discrete sliders must have at least one mark.'),
        tooltip = FTooltipController(vsync: vsync),
        allowedInteraction = FSliderInteraction.tapAndSlideThumb,
        growable = (min: true, max: true),
        _marks = SplayTreeMap.fromIterable(marks.map((mark) => mark.offset), value: (_) {}),
        super(value);

  /// Called when the slider edge has been grown or shrunk using the arrow keys.
  void traverse({required bool min, required bool grow}) {
    data = discrete ? traverseDiscrete(min: min, grow: grow) : traverseContinuous(min: min, grow: grow);
  }

  /// Called when the slider has been slid by the given [delta] on the [min] side, in logical pixels, along the main
  /// axis.
  ///
  /// The delta is relative to the origin defined by [FSlider.layout].
  void slide(double delta, {required bool min}) {
    if (allowedInteraction == FSliderInteraction.tap) {
      return;
    }

    assert(min ? growable.min : growable.max, 'Slider is not growable at the ${min ? 'min' : 'max'} edge.');

    final current = min ? data.offset.min : data.offset.max;
    final next = current + delta;

    data = adjust(current, next, min: min);
  }

  /// Called when the slider is tapped at given offset, in logical pixels, along the main axis.
  ///
  /// The offset is relative to the origin defined by [FSlider.layout].
  void tap(double offset) {
    if (allowedInteraction == FSliderInteraction.slide || allowedInteraction == FSliderInteraction.slideThumb) {
      return;
    }

    switch ((growable.min, growable.max)) {
      case (true, true) when offset < data.offset.min:
        data = adjust(data.offset.min, offset, min: true);

      case (true, true) when data.offset.max < offset:
        data = adjust(data.offset.max, offset, min: false);

      case (true, false):
        data = adjust(data.offset.min, offset, min: true);

      case (false, true):
        data = adjust(data.offset.max, offset, min: false);

      default:
        break;
    }
  }

  /// Returns the slider's min or max edge adjusted to the given [next] offset, in logical pixels, along the main axis.
  @useResult
  FSliderData adjust(double current, double next, {required bool min}) =>
      discrete ? adjustDiscrete(current, next, min: min) : adjustContinuous(current, next, min: min);

  /// The slider's data.
  FSliderData get data => _data!;

  set data(FSliderData value) {
    if (_data == value) {
      return;
    }

    final previous = _data;
    _data = value;

    if (previous != null) {
      notifyListeners();
    }
  }
}

@internal
extension KeyboardAdjustment on FSliderController {
  @useResult
  FSliderData traverseDiscrete({required bool min, required bool grow}) {
    final current = min ? data.offset.min : data.offset.max;
    final mark = (min ^ grow) ? _marks.firstKeyAfter(current) : _marks.lastKeyBefore(current);
    if (mark == null) {
      return data;
    }

    var adjusted = mark * data.rawExtent.total;
    // Prevents min and max from becoming reversed.
    if (min ? data.offset.max < adjusted : adjusted < data.offset.min) {
      adjusted = current;
    }

    return data.copyWith(
      minOffset: min ? adjusted : null,
      maxOffset: min ? null : adjusted,
    );
  }

  @useResult
  FSliderData traverseContinuous({required bool min, required bool grow}) {
    final current = min ? data.offset.min : data.offset.max;
    final traverse = data.rawExtent.total * traversePercentage;

    return adjustContinuous(current, current + ((min ^ grow) ? traverse : -traverse), min: min);
  }
}

/// Provides methods for adjusting the slider's min and max edges through gestures.
@internal
extension GestureAdjustment on FSliderController {
  @useResult
  FSliderData adjustDiscrete(double current, double next, {required bool min}) {
    final before = _marks.lastKeyBefore(next);
    final after = _marks.firstKeyAfter(next);

    var adjusted = switch (min ^ (current < next)) {
      // Min edge is growing/max edge is shrinking, and current < after. Prevents counter-intuitive behavior where
      // the edge moves in the opposite direction of the user's gesture.
      true when after == null || current < after => before ?? current,
      // Min edge is shrinking/max edge is growing, and before < current. Prevents counter-intuitive behavior where
      // the edge moves in the opposite direction of the user's gesture.
      false when before == null || before < current => after ?? current,
      _ => _closer(next, before, after),
    };

    // Prevents min and max from becoming reversed.
    if (min ? data.offset.max < adjusted : adjusted < data.offset.min) {
      adjusted = current;
    }

    return data.copyWith(
      minOffset: min ? adjusted : null,
      maxOffset: min ? null : adjusted,
    );
  }

  double _closer(double offset, double? before, double? after) {
    switch ((before, after)) {
      case (final before?, null):
        return before;

      case (null, final after?):
        return after;

      case (final before?, final after?):
        final diffBefore = (offset - before).abs();
        final diffAfter = (offset - after).abs();

        return diffBefore <= diffAfter ? before : after;

      default:
        return offset;
    }
  }

  @useResult
  FSliderData adjustContinuous(double current, double next, {required bool min}) {
    if (min && data.offset.max - next < data.extent.min) {
      next = data.offset.max - data.extent.min;
    } else if (!min && next - data.offset.min < data.extent.min) {
      next = data.offset.min + data.extent.min;
    }

    return data.copyWith(
      minOffset: min ? math.max(next, 0) : null,
      maxOffset: min ? null : math.min(next, data.extent.max),
    );
  }
}
