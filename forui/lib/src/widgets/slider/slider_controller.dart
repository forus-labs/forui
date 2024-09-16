import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/platform.dart';
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
abstract class FSliderController extends ChangeNotifier {
  static FSliderInteraction get _platform =>
      touchPlatforms.contains(defaultTargetPlatform) ? FSliderInteraction.slide : FSliderInteraction.tapAndSlideThumb;

  /// True if the registered tooltip(s) should be shown when the user interacts with the slider. Defaults to true.
  final FSliderTooltipsController tooltips;

  /// The allowed ways to interaction with the slider.
  ///
  /// Single-value sliders default to [FSliderInteraction.slide] on Android, Fuchsia and iOS, and
  /// [FSliderInteraction.tapAndSlideThumb] on other platforms.
  ///
  /// Range sliders always default to [FSliderInteraction.tapAndSlideThumb].
  final FSliderInteraction allowedInteraction;

  /// Whether the active track is extendable at its min and max edges.
  final ({bool min, bool max}) extendable;

  final FSliderSelection _initialSelection;
  FSliderSelection? _selection;

  /// Creates a [FSliderController] for selecting a single value.
  FSliderController({
    required this.allowedInteraction,
    required FSliderSelection selection,
    bool tooltips = true,
    bool minExtendable = false,
  })  : tooltips = FSliderTooltipsController(enabled: tooltips),
        extendable = (min: minExtendable, max: !minExtendable),
        _initialSelection = selection;

  /// Creates a [FSliderController] for selecting a range.
  FSliderController.range({
    required FSliderSelection selection,
    bool tooltips = true,
  })  : tooltips = FSliderTooltipsController(enabled: tooltips),
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
      _set(selection.step(min: min, extend: extend));
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
      _set(selection.move(min: min, to: offset));
    }
  }

  /// Taps the slider at given offset, in logical pixels, along the track.
  ///
  /// The offset is relative to the origin defined by [FSlider.layout].
  void tap(double offset) {
    if (allowedInteraction == FSliderInteraction.slide || allowedInteraction == FSliderInteraction.slideThumb) {
      return;
    }

    if (_selection case final selection?) {
      _set(
        switch (extendable) {
          (min: true, max: true) when offset < selection.rawOffset.min => selection.move(min: true, to: offset),
          (min: true, max: true) when selection.rawOffset.max < offset => selection.move(min: false, to: offset),
          (min: true, max: false) => selection.move(min: true, to: offset),
          (min: false, max: true) => selection.move(min: false, to: offset),
          _ => null,
        },
      );
    }
  }

  void _set(FSliderSelection? selection) {
    if (selection == null || _selection == selection) {
      return;
    }

    _selection = selection;
    notifyListeners();
  }

  /// The slider's active track/selection.
  FSliderSelection get selection => _selection ?? _initialSelection;
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
    FSliderInteraction? allowedInteraction,
    super.minExtendable,
  })  : assert(0 <= stepPercentage && stepPercentage <= 1, 'stepPercentage must be between 0 and 1, inclusive.'),
        super(allowedInteraction: allowedInteraction ?? FSliderController._platform);

  /// Creates a [FContinuousSliderController] for selecting a range.
  FContinuousSliderController.range({
    required super.selection,
    this.stepPercentage = 0.05,
    super.tooltips = true,
  })  : assert(0 <= stepPercentage && stepPercentage <= 1, 'stepPercentage must be between 0 and 1, inclusive.'),
        super.range();

  @override
  void attach(double extent, List<FSliderMark> _) {
    final proposed = ContinuousSelection(
      step: stepPercentage,
      mainAxisExtent: extent,
      extent: selection.extent,
      offset: selection.offset,
    );

    if (_selection == null) {
      _selection = proposed;
    } else {
      _set(proposed);
    }
  }
}

/// A controller that manages a slider's active track which represents a discrete range/value.
class FDiscreteSliderController extends FSliderController {
  /// Creates a [FDiscreteSliderController] for selecting a single value.
  FDiscreteSliderController({
    required super.selection,
    FSliderInteraction? allowedInteraction,
    super.tooltips = true,
    super.minExtendable,
  }) : super(allowedInteraction: allowedInteraction ?? FSliderController._platform);

  /// Creates a [FDiscreteSliderController] for selecting a range.
  FDiscreteSliderController.range({
    required super.selection,
    super.tooltips = true,
  }) : super.range();

  @override
  void attach(double extent, List<FSliderMark> marks) {
    assert(marks.isNotEmpty, 'At least one mark is required.');

    final proposed = DiscreteSelection(
      mainAxisExtent: extent,
      extent: selection.extent,
      offset: selection.offset,
      ticks: SplayTreeMap.fromIterable(marks.map((mark) => mark.offset), value: (_) {}),
    );

    if (_selection == null) {
      _selection = proposed;
    } else {
      _set(proposed);
    }
  }
}