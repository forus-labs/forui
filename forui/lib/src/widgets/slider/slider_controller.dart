import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/slider_value.dart';

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

/// The active thumb in a single-value slider.
enum FSliderActiveThumb {
  /// The thumb at the min edge is active.
  min,

  /// The thumb at the max edge is active.
  max,
}

/// A controller that manages a slider's active track.
///
/// This class should be extended to customize value. By default, the following controllers are provided:
/// * [FContinuousSliderController.new] for selecting a single continuous value.
/// * [FContinuousSliderController.range] for selecting continuous range.
/// * [FDiscreteSliderController.new] for selecting a discrete value.
/// * [FDiscreteSliderController.range] for selecting a discrete range.
abstract class FSliderController extends FChangeNotifier {
  /// The allowed ways to interaction with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  final FSliderInteraction interaction;

  /// Whether the active track is expandable at the min and max edges.
  final ({bool min, bool max}) active;

  final FSliderValue _initial;
  FSliderValue? _value;

  /// Creates a [FSliderController] for selecting a single value.
  FSliderController({
    required FSliderValue value,
    this.interaction = .tapAndSlideThumb,
    FSliderActiveThumb thumb = .max,
  }) : active = (min: thumb == .min, max: thumb == .max),
       _initial = value;

  /// Creates a [FSliderController] for selecting a range.
  FSliderController.range({required FSliderValue value})
    : interaction = .tapAndSlideThumb,
      active = (min: true, max: true),
      _initial = value;

  /// Registers the controller to a slider with the given extent and marks.
  ///
  /// A controller can only be attached to a single slider at a time.
  void attach(double extent, List<FSliderMark> marks);

  /// Moves the active track on the [min] edge to the previous/next step.
  void step({required bool min, required bool expand}) {
    if (_value case final value?) {
      this.value = value.step(min: min, expand: expand);
    }
  }

  /// Slides the active track to the given [offset] on the [min] edge, in logical pixels.
  ///
  /// The delta is relative to the origin defined by [FSlider.layout].
  void slide(double offset, {required bool min}) {
    if (interaction == .tap) {
      return;
    }

    assert(min ? active.min : active.max, 'Slider is not extendable at the ${min ? 'min' : 'max'} edge.');

    if (_value case final value?) {
      this.value = value.move(min: min, to: offset);
    }
  }

  /// Taps the slider at given offset, in logical pixels, along the track.
  ///
  /// Returns:
  /// * true if the offset moves the min edge
  /// * false if the offset moves the max edge
  /// * null if the offset did not move either edge
  ///
  /// The offset is relative to the origin defined by [FSlider.layout].
  bool? tap(double offset) {
    if (interaction == .slide || interaction == .slideThumb) {
      return null;
    }

    if (_value case final value?) {
      final min = switch (active) {
        (min: true, max: true) when offset < value.pixels.min => true,
        (min: true, max: true) when value.pixels.max < offset => false,
        (min: true, max: false) => true,
        (min: false, max: true) => false,
        _ => null,
      };

      if (min != null) {
        this.value = value.move(min: min, to: offset);
      }

      return min;
    }

    return null;
  }

  /// Resets the controller to its initial state.
  void reset();

  /// The slider's active track/value.
  FSliderValue get value => _value ?? _initial;

  set value(FSliderValue? value) {
    if (value == null || _value == value) {
      return;
    }

    _value = value;
    notifyListeners();
  }
}

/// A controller that manages a slider's active track which represents a continuous range/value.
class FContinuousSliderController extends FSliderController {
  /// The percentage of the track that represents a single step. Defaults to 0.05.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not between 0 and 1, inclusive.
  final double stepPercentage;

  /// Creates a [FContinuousSliderController] for selecting a single value.
  FContinuousSliderController({
    required super.value,
    this.stepPercentage = 0.05,
    super.interaction,
    super.thumb,
  }) : assert(
         0 <= stepPercentage && stepPercentage <= 1,
         'stepPercentage ($stepPercentage) must be between 0 and 1, inclusive.',
       );

  /// Creates a [FContinuousSliderController] for selecting a range.
  FContinuousSliderController.range({required super.value, this.stepPercentage = 0.05})
    : assert(
        0 <= stepPercentage && stepPercentage <= 1,
        'stepPercentage ($stepPercentage) must be between 0 and 1, inclusive.',
      ),
      super.range();

  @override
  @internal
  void attach(double extent, List<FSliderMark> _) {
    final proposed = ContinuousValue(
      step: stepPercentage,
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
    );

    if (_value == null) {
      _value = proposed; // We don't want to notify listeners when performing initialization.
    } else {
      value = proposed;
    }
  }

  @override
  void reset() {
    if (_value case FSliderValue(:final pixelConstraints)) {
      value = ContinuousValue(
        step: stepPercentage,
        extent: pixelConstraints.extent,
        constraints: _initial.constraints,
        min: _initial.min,
        max: _initial.max,
      );
    }
  }
}

/// A controller that manages a slider's active track which represents a discrete range/value.
class FDiscreteSliderController extends FSliderController {
  /// Creates a [FDiscreteSliderController] for selecting a single value.
  FDiscreteSliderController({required super.value, super.interaction, super.thumb});

  /// Creates a [FDiscreteSliderController] for selecting a range.
  FDiscreteSliderController.range({required super.value}) : super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    assert(marks.isNotEmpty, 'At least one mark is required.');

    final proposed = DiscreteValue(
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
      ticks: .fromIterable(marks.map((mark) => mark.value), value: (_) {}),
    );

    if (_value == null) {
      _value = proposed; // We don't want to notify listeners when performing initialization.
    } else {
      value = proposed;
    }
  }

  @override
  void reset() {
    if (_value case DiscreteValue(:final ticks, :final pixelConstraints)) {
      value = DiscreteValue(
        ticks: ticks,
        extent: pixelConstraints.extent,
        constraints: _initial.constraints,
        min: _initial.min,
        max: _initial.max,
      );
    }
  }
}

/// A proxy controller for lifted mode that forwards all changes to the parent's onSelect callback.
@internal
class ProxyContinuousSliderController extends FContinuousSliderController {
  ValueChanged<FSliderValue> _onChange;

  ProxyContinuousSliderController({
    required super.value,
    required ValueChanged<FSliderValue> onChange,
    required super.stepPercentage,
    required super.interaction,
    required super.thumb,
  }) : _onChange = onChange,
       super();

  ProxyContinuousSliderController.range({
    required super.value,
    required ValueChanged<FSliderValue> onChange,
    required super.stepPercentage,
  }) : _onChange = onChange,
       super.range();

  @override
  void attach(double extent, List<FSliderMark> _) {
    // Directly set _value without triggering _onChange - attach is internal, not user-initiated
    _value = ContinuousValue(
      step: stepPercentage,
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
    );
  }

  void update({
    required FSliderValue value,
    required ValueChanged<FSliderValue> onChange,
  }) {
    _onChange = onChange;
    // Update the value from parent without notifying (parent owns state)
    if (_value?.min != value.min || _value?.max != value.max) {
      _value = value;
      notifyListeners();
    }
  }
  @override
  set value(FSliderValue? value) {
    if (value == null || _value == value) {
      return;
    }

    _onChange(value);
  }
}

/// A proxy controller for lifted mode that forwards all changes to the parent's onSelect callback.
@internal
class ProxyDiscreteSliderController extends FDiscreteSliderController {
  ValueChanged<FSliderValue> _onChange;

  ProxyDiscreteSliderController({
    required super.value,
    required ValueChanged<FSliderValue> onChange,
    required super.interaction,
    required super.thumb,
  }) : _onChange = onChange,
       super();

  ProxyDiscreteSliderController.range({
    required super.value,
    required ValueChanged<FSliderValue> onChange,
  }) : _onChange = onChange,
       super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    assert(marks.isNotEmpty, 'At least one mark is required.');

    // Directly set _value without triggering _onChange - attach is internal, not user-initiated
    _value = DiscreteValue(
      extent: extent,
      constraints: value.constraints,
      min: value.min,
      max: value.max,
      ticks: .fromIterable(marks.map((mark) => mark.value), value: (_) {}),
    );
  }

  void update({
    required FSliderValue value,
    required ValueChanged<FSliderValue> onChange,
  }) {
    _onChange = onChange;
    // Update the value from parent without notifying (parent owns state)
    if (_value?.min != value.min || _value?.max != value.max) {
      _value = value;
      notifyListeners();
    }
  }

  @override
  set value(FSliderValue? value) {
    if (value == null || _value == value) {
      return;
    }

    _onChange(value);
  }
}
