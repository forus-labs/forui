import 'dart:collection';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/slider_selection.dart';

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

/// A controller that manages a slider's active track.
///
/// This class should be extended to customize selection. By default, the following controllers are provided:
/// * [FContinuousSliderController.new] for selecting a single continuous value.
/// * [FContinuousSliderController.range] for selecting continuous range.
/// * [FDiscreteSliderController.new] for selecting a discrete value.
/// * [FDiscreteSliderController.range] for selecting a discrete range.
abstract class FSliderController extends FChangeNotifier {
  /// True if the registered tooltip(s) should be shown when the user interacts with the slider. Defaults to true.
  final FSliderTooltipsController tooltips;

  /// The allowed ways to interaction with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  final FSliderInteraction allowedInteraction;

  /// Whether the active track is extendable at its min and max edges.
  final ({bool min, bool max}) extendable;

  final FSliderSelection _initialSelection;
  FSliderSelection? _selection;

  /// Creates a [FSliderController] for selecting a single value.
  FSliderController({
    required FSliderSelection selection,
    this.allowedInteraction = FSliderInteraction.tapAndSlideThumb,
    bool tooltips = true,
    bool minExtendable = false,
  }) : tooltips = FSliderTooltipsController(enabled: tooltips),
       extendable = (min: minExtendable, max: !minExtendable),
       _initialSelection = selection;

  /// Creates a [FSliderController] for selecting a range.
  FSliderController.range({required FSliderSelection selection, bool tooltips = true})
    : tooltips = FSliderTooltipsController(enabled: tooltips),
      allowedInteraction = FSliderInteraction.tapAndSlideThumb,
      extendable = (min: true, max: true),
      _initialSelection = selection;

  /// Registers the controller to a slider with the given extent and marks.
  ///
  /// A controller can only be attached to a single slider at a time.
  void attach(double extent, List<FSliderMark> marks);

  /// Moves the active track on the [min] edge to the previous/next step.
  void step({required bool min, required bool extend}) {
    if (_selection case final selection?) {
      this.selection = selection.step(min: min, extend: extend);
    }
  }

  /// Slides the active track to the given [offset] on the [min] edge, in logical pixels.
  ///
  /// The delta is relative to the origin defined by [FSlider.layout].
  void slide(double offset, {required bool min}) {
    if (allowedInteraction == FSliderInteraction.tap) {
      return;
    }

    assert(min ? extendable.min : extendable.max, 'Slider is not extendable at the ${min ? 'min' : 'max'} edge.');

    if (_selection case final selection?) {
      this.selection = selection.move(min: min, to: offset);
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
    if (allowedInteraction == FSliderInteraction.slide || allowedInteraction == FSliderInteraction.slideThumb) {
      return null;
    }

    if (_selection case final selection?) {
      final min = switch (extendable) {
        (min: true, max: true) when offset < selection.rawOffset.min => true,
        (min: true, max: true) when selection.rawOffset.max < offset => false,
        (min: true, max: false) => true,
        (min: false, max: true) => false,
        _ => null,
      };

      if (min != null) {
        this.selection = selection.move(min: min, to: offset);
      }

      return min;
    }

    return null;
  }

  /// Resets the controller to its initial state.
  void reset();

  /// The slider's active track/selection.
  FSliderSelection get selection => _selection ?? _initialSelection;

  set selection(FSliderSelection? selection) {
    if (selection == null || _selection == selection) {
      return;
    }

    _selection = selection;
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
    required super.selection,
    this.stepPercentage = 0.05,
    super.tooltips = true,
    super.allowedInteraction,
    super.minExtendable,
  }) : assert(
         0 <= stepPercentage && stepPercentage <= 1,
         'stepPercentage ($stepPercentage) must be between 0 and 1, inclusive.',
       );

  /// Creates a [FContinuousSliderController] for selecting a range.
  FContinuousSliderController.range({required super.selection, this.stepPercentage = 0.05, super.tooltips = true})
    : assert(
        0 <= stepPercentage && stepPercentage <= 1,
        'stepPercentage ($stepPercentage) must be between 0 and 1, inclusive.',
      ),
      super.range();

  @override
  @internal
  void attach(double extent, List<FSliderMark> _) {
    final proposed = ContinuousSelection(
      step: stepPercentage,
      mainAxisExtent: extent,
      extent: selection.extent,
      offset: selection.offset,
    );

    if (_selection == null) {
      _selection = proposed; // We don't want to notify listeners when performing initialization.
    } else {
      selection = proposed;
    }
  }

  @override
  void reset() {
    if (_selection case final selection?) {
      this.selection = ContinuousSelection(
        step: stepPercentage,
        mainAxisExtent: selection.rawExtent.total,
        extent: _initialSelection.extent,
        offset: _initialSelection.offset,
      );
    }
  }
}

/// A controller that manages a slider's active track which represents a discrete range/value.
class FDiscreteSliderController extends FSliderController {
  /// Creates a [FDiscreteSliderController] for selecting a single value.
  FDiscreteSliderController({
    required super.selection,
    super.allowedInteraction,
    super.tooltips = true,
    super.minExtendable,
  });

  /// Creates a [FDiscreteSliderController] for selecting a range.
  FDiscreteSliderController.range({required super.selection, super.tooltips = true}) : super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    assert(marks.isNotEmpty, 'At least one mark is required.');

    final proposed = DiscreteSelection(
      mainAxisExtent: extent,
      extent: selection.extent,
      offset: selection.offset,
      ticks: SplayTreeMap.fromIterable(marks.map((mark) => mark.value), value: (_) {}),
    );

    if (_selection == null) {
      _selection = proposed; // We don't want to notify listeners when performing initialization.
    } else {
      selection = proposed;
    }
  }

  @override
  void reset() {
    if (_selection case final DiscreteSelection discrete?) {
      selection = DiscreteSelection(
        ticks: discrete.ticks,
        mainAxisExtent: discrete.rawExtent.total,
        extent: _initialSelection.extent,
        offset: _initialSelection.offset,
      );
    }
  }
}
