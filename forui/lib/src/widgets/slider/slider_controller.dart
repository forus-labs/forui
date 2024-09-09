import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/platform.dart';
import 'package:forui/src/widgets/slider/slider_selection.dart';
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

  /// The slider thumb's tooltip controller.
  final FTooltipController tooltip;

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
    required this.tooltip,
    required this.allowedInteraction,
    required FSliderSelection selection,
    bool minExtendable = false,
  })  : extendable = (min: minExtendable, max: !minExtendable),
        _initialSelection = selection;

  /// Creates a [FSliderController] for selecting a range.
  FSliderController.range({
    required this.tooltip,
    required FSliderSelection selection,
  })  : allowedInteraction = FSliderInteraction.tapAndSlideThumb,
        extendable = (min: true, max: true),
        _initialSelection = selection;

  /// Attaches the controller to a slider with the given extent and marks.
  void attach(double extent, List<FSliderMark> marks);

  /// Moves the active track on the [min] edge to the previous/next step.
  void step({required bool min, required bool extend}) {
    if (_selection case final selection?) {
      _set(selection.step(min: min, extend: extend));
    }
  }

  /// Slides the active track by the given [delta] on the [min] edge, in logical pixels.
  ///
  /// The delta is relative to the origin defined by [FSlider.layout].
  void slide(double delta, {required bool min}) {
    if (allowedInteraction == FSliderInteraction.tap) {
      return;
    }

    assert(min ? extendable.min : extendable.max, 'Slider is not extendable at the ${min ? 'min' : 'max'} edge.');

    if (_selection case final selection?) {
      final current = min ? selection.rawOffset.min : selection.rawOffset.max;
      _set(selection.move(min: min, to: current + delta));
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
  /// The percentage of the track that represents a single step.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not between 0 and 1, inclusive.
  final double stepPercentage;

  /// Creates a [FContinuousSliderController] for selecting a single value.
  FContinuousSliderController({
    required TickerProvider vsync,
    required super.selection,
    required this.stepPercentage,
    FSliderInteraction? allowedInteraction,
    super.minExtendable,
  })  : assert(0 <= stepPercentage && stepPercentage <= 1, 'stepPercentage must be between 0 and 1, inclusive.'),
        super(
          tooltip: FTooltipController(vsync: vsync),
          allowedInteraction: allowedInteraction ?? FSliderController._platform,
        );

  /// Creates a [FContinuousSliderController] for selecting a range.
  FContinuousSliderController.range({
    required TickerProvider vsync,
    required super.selection,
    required this.stepPercentage,
  })  : assert(0 <= stepPercentage && stepPercentage <= 1, 'stepPercentage must be between 0 and 1, inclusive.'),
        super.range(tooltip: FTooltipController(vsync: vsync));

  @override
  void attach(double extent, List<FSliderMark> _) {
    if (_selection == null) {
      _selection = ContinuousSelection(
        step: stepPercentage,
        mainAxisExtent: extent,
        extent: _initialSelection.extent,
        offset: _initialSelection.offset,
      );
      return;
    }

    if (_selection case final selection? when selection.rawExtent.total != extent) {
      _selection = ContinuousSelection(
        step: stepPercentage,
        mainAxisExtent: extent,
        extent: selection.extent,
        offset: selection.offset,
      );
      notifyListeners();
    }
  }
}

/// A controller that manages a slider's active track which represents a discrete range/value.
class FDiscreteSliderController extends FSliderController {
  /// Creates a [FDiscreteSliderController] for selecting a single value.
  FDiscreteSliderController({
    required TickerProvider vsync,
    required super.selection,
    FSliderInteraction? allowedInteraction,
    super.minExtendable,
  }) : super(
          tooltip: FTooltipController(vsync: vsync),
          allowedInteraction: allowedInteraction ?? FSliderController._platform,
        );

  /// Creates a [FDiscreteSliderController] for selecting a range.
  FDiscreteSliderController.range({
    required TickerProvider vsync,
    required super.selection,
  }) : super.range(tooltip: FTooltipController(vsync: vsync));

  @override
  void attach(double extent, List<FSliderMark> marks) {
    if (_selection == null) {
      _selection = DiscreteSelection(
        mainAxisExtent: extent,
        extent: _initialSelection.extent,
        offset: _initialSelection.offset,
        ticks: SplayTreeMap.fromIterable(marks.map((mark) => mark.offset), value: (_) {}),
      );
      return;
    }

    if (_selection case final selection? when selection.rawExtent.total != extent) {
      _selection = DiscreteSelection(
        mainAxisExtent: extent,
        extent: selection.extent,
        offset: selection.offset,
        ticks: SplayTreeMap.fromIterable(marks.map((mark) => mark.offset), value: (_) {}),
      );
      notifyListeners();
    }
  }
}
