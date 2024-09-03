import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/src/foundation/platform.dart';
import 'package:forui/src/widgets/slider/slider_mark.dart';
import 'package:forui/widgets/slider.dart';
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

class FSliderController extends ChangeNotifier {
  static FSliderInteraction get _platform =>
      touchPlatforms.contains(defaultTargetPlatform) ? FSliderInteraction.slide : FSliderInteraction.tapAndSlideThumb;

  /// The slider's allowed interaction.
  ///
  /// Defaults to [FSliderInteraction.slide] on Android, Fuchsia and iOS, and [FSliderInteraction.tapAndSlideThumb] on
  /// other platforms.
  final FSliderInteraction allowedInteraction;

  /// Whether the slider is growable at the min and max edges.
  final ({bool min, bool max}) growable;

  /// True if the slider has discrete steps, and false if it is continuous. Defaults to false.
  final bool discrete;

  /// The slider's marks.
  ///
  /// ## Contract
  /// Modifying the regions outside of [attach] will result in undefined behaviour.
  ///
  /// Throws [AssertionError] if [discrete] is true and [marks] is empty.
  final List<FSliderMark> marks;

  final SplayTreeMap<double, void> _marks;
  late FSliderData _data;

  /// Creates a [FSliderController].
  FSliderController({
    FSliderInteraction? allowedInteraction,
    this.growable = (min: false, max: true),
    this.discrete = false,
  })  : allowedInteraction = allowedInteraction ?? _platform,
        marks = [],
        _marks = SplayTreeMap();

  /// Attaches the slider's [FSliderData] and [FSliderMark]s to the controller.
  ///
  /// The other methods in this controller will throw an error until this method is called.
  void attach(FSliderData data, List<FSliderMark> marks) {
    assert(!(discrete && marks.isEmpty), 'Discrete sliders must have at least one mark.');

    this.marks.clear();
    this.marks.addAll(marks);

    _marks.clear();
    for (final mark in this.marks) {
      _marks[mark.percentage] = null;
    }
  }

  // TODO: tooltip?

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

  /// Returns the slider's [min] edge adjusted from the [current] offset to the [next] offset.
  @useResult
  FSliderData adjust(double current, double next, {required bool min}) =>
      discrete ? adjustDiscrete(current, next, min: min) : adjustContinuous(current, next, min: min);

  /// The slider's data.
  FSliderData get data => _data;

  set data(FSliderData value) {
    if (_data == value) {
      return;
    }

    _data = value;
    notifyListeners();
  }
}

@internal
extension Adjustment on FSliderController {
  @useResult
  FSliderData adjustDiscrete(double current, double next, {required bool min}) {
    final before = _marks.lastKeyBefore(next);
    final after = _marks.firstKeyAfter(next);

    var adjusted = switch (min ^ (current < next)) {
      // Assuming LTR and points between current, handle leftward movement.
      true when after == null || current < after => before ?? current,
      // Assuming LTR and points between current, handle rightward movement.
      false when before == null || before < current => after ?? current,
      _ => _closer(next, before, after),
    };

    // Prevent the reversing of min & max.
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
