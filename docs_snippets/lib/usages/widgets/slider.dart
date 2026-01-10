// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final slider = FSlider(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  layout: .ltr,
  marks: const [FSliderMark(value: 0), FSliderMark(value: 0.5), FSliderMark(value: 1)],
  // {@endcategory}
  // {@category "Control"}
  control: const .managedContinuous(),
  // {@endcategory}
  // {@category "Tooltip Controls"}
  tooltipControls: const FSliderTooltipControls(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Volume'),
  description: const Text('Adjust the volume level'),
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  onSaved: (value) {},
  onReset: () {},
  validator: (value) => null,
  autovalidateMode: .disabled,
  forceErrorText: null,
  // {@endcategory}
  // {@category "Appearance"}
  trackMainAxisExtent: 200,
  trackHitRegionCrossExtent: 24,
  tooltipBuilder: (controller, value) => Text('${(value * 100).toStringAsFixed(0)}%'),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticValueFormatterCallback: (value) => '${(value * 100).toStringAsFixed(0)}%',
  semanticFormatterCallback: (value) =>
      '${(value.min * 100).toStringAsFixed(0)}% - ${(value.max * 100).toStringAsFixed(0)}%',
  // {@endcategory}
  // {@category "Callbacks"}
  onEnd: (value) {},
  // {@endcategory}
);

const sliderMark = FSliderMark(
  // {@category "Core"}
  style: null,
  value: 0.5,
  tick: true,
  label: Text('50%'),
  // {@endcategory}
);

// {@category "Control" "`.liftedContinuous()`"}
/// Externally controls a single continuous value.
final FSliderControl liftedContinuous = .liftedContinuous(
  value: FSliderValue(max: 0.5),
  onChange: (value) {},
  stepPercentage: 0.05,
  interaction: .tapAndSlideThumb,
  thumb: .max,
);

// {@category "Control" "`.liftedContinuousRange()`"}
/// Externally controls a continuous range.
final FSliderControl liftedContinuousRange = .liftedContinuousRange(
  value: FSliderValue(min: 0.25, max: 0.75),
  onChange: (value) {},
  stepPercentage: 0.05,
);

// {@category "Control" "`.liftedDiscrete()`"}
/// Externally controls a single discrete value.
final FSliderControl liftedDiscrete = .liftedDiscrete(
  value: FSliderValue(max: 0.5),
  onChange: (value) {},
  interaction: .tapAndSlideThumb,
  thumb: .max,
);

// {@category "Control" "`.liftedDiscreteRange()`"}
/// Externally controls a discrete range.
final FSliderControl liftedDiscreteRange = .liftedDiscreteRange(
  value: FSliderValue(min: 0.25, max: 0.75),
  onChange: (value) {},
);

// {@category "Control" "`.managedContinuous()` with internal controller"}
/// Manages a single continuous value internally.
final FSliderControl managedContinuousInternal = .managedContinuous(
  initial: FSliderValue(max: 0.5),
  stepPercentage: 0.05,
  interaction: .tapAndSlideThumb,
  thumb: .max,
  onChange: (value) {},
);

// {@category "Control" "`.managedContinuous()` with external controller"}
/// Uses an external controller for a single continuous value.
final FSliderControl managedContinuousExternal = .managedContinuous(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FContinuousSliderController(
    value: FSliderValue(max: 0.5),
    stepPercentage: 0.05,
    interaction: .tapAndSlideThumb,
    thumb: .max,
  ),
  onChange: (value) {},
);

// {@category "Control" "`.managedContinuousRange()` with internal controller"}
/// Manages a continuous range internally.
final FSliderControl managedContinuousRangeInternal = .managedContinuousRange(
  initial: FSliderValue(min: 0.25, max: 0.75),
  stepPercentage: 0.05,
  onChange: (value) {},
);

// {@category "Control" "`.managedContinuousRange()` with external controller"}
/// Uses an external controller for a continuous range.
final FSliderControl managedContinuousRangeExternal = .managedContinuousRange(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .range(value: FSliderValue(min: 0.25, max: 0.75), stepPercentage: 0.05),
  onChange: (value) {},
);

// {@category "Control" "`.managedDiscrete()` with internal controller"}
/// Manages a single discrete value internally.
final FSliderControl managedDiscreteInternal = .managedDiscrete(
  initial: FSliderValue(max: 0.5),
  interaction: .tapAndSlideThumb,
  thumb: .max,
  onChange: (value) {},
);

// {@category "Control" "`.managedDiscrete()` with external controller"}
/// Uses an external controller for a single discrete value.
final FSliderControl managedDiscreteExternal = .managedDiscrete(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FDiscreteSliderController(value: FSliderValue(max: 0.5), interaction: .tapAndSlideThumb, thumb: .max),
  onChange: (value) {},
);

// {@category "Control" "`.managedDiscreteRange()` with internal controller"}
/// Manages a discrete range internally.
final FSliderControl managedDiscreteRangeInternal = .managedDiscreteRange(
  initial: FSliderValue(min: 0.25, max: 0.75),
  onChange: (value) {},
);

// {@category "Control" "`.managedDiscreteRange()` with external controller"}
/// Uses an external controller for a discrete range.
final FSliderControl managedDiscreteRangeExternal = .managedDiscreteRange(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .range(value: FSliderValue(min: 0.25, max: 0.75)),
  onChange: (value) {},
);

// {@category "Tooltip Controls" "`.lifted()`"}
/// Externally controls the tooltip visibility.
final FSliderTooltipControls tooltipControlsLifted = FSliderTooltipControls(
  min: .lifted(shown: false, onChange: (shown) {}, motion: const FTooltipMotion()),
  max: .lifted(shown: false, onChange: (shown) {}, motion: const FTooltipMotion()),
);

// {@category "Tooltip Controls" "`.managed()` with internal controller"}
/// Manages tooltip state internally with configurable parameters.
final FSliderTooltipControls tooltipControlsManagedInternal = FSliderTooltipControls(
  min: .managed(initial: false, motion: const FTooltipMotion(), onChange: (shown) {}),
  max: .managed(initial: false, motion: const FTooltipMotion(), onChange: (shown) {}),
);

// {@category "Tooltip Controls" "`.managed()` with external controller"}
/// Uses external controllers for tooltip management.
final FSliderTooltipControls tooltipControlsManagedExternal = FSliderTooltipControls(
  // For demonstration purposes only. Don't create controllers inline, store them in a State instead.
  min: .managed(
    controller: FTooltipController(vsync: vsync, shown: false, motion: const FTooltipMotion()),
    onChange: (shown) {},
  ),
  max: .managed(
    controller: FTooltipController(vsync: vsync, shown: false, motion: const FTooltipMotion()),
    onChange: (shown) {},
  ),
);

// {@category "Tooltip Controls" "`.disabled()`"}
/// Disables tooltips on both thumbs.
const FSliderTooltipControls tooltipControlsDisabled = .disabled();

TickerProvider get vsync => throw UnimplementedError();
