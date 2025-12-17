import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/slider_controller.dart';

part 'slider_control.control.dart';

/// A [FSliderControl] defines how a [FSlider] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FSliderControl with Diagnosticable, _$FSliderControlMixin {
  /// Creates a [FSliderControl] for selecting a single continuous value.
  ///
  /// The [controller], when provided, means all other configuration parameters should not be provided as they
  /// will be ignored. Pass these values to the controller's constructor instead.
  ///
  /// The [initial] value. Defaults to `FSliderValue(max: 0)`.
  ///
  /// The [stepPercentage] is the percentage of the track to move when interacting with the slider using a keyboard.
  /// Defaults to 0.05 (5%).
  ///
  /// The [interaction] is the allowed ways to interact with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  ///
  /// The [thumb] is the active thumb. Defaults to [FSliderActiveThumb.max].
  ///
  /// The [onChange] callback is called when the selected value changes.
  const factory FSliderControl.managedContinuous({
    FContinuousSliderController? controller,
    FSliderValue? initial,
    double? stepPercentage,
    FSliderInteraction? interaction,
    FSliderActiveThumb? thumb,
    ValueChanged<FSliderValue>? onChange,
  }) = _Continuous;

  /// Creates a [FSliderControl] for selecting a continuous range.
  ///
  /// The [controller], when provided, means all other configuration parameters should not be provided as they
  /// will be ignored. Pass these values to the controller's constructor instead.
  ///
  /// The [initial] value. Defaults to `FSliderValue(min: 0, max: 0.25)`.
  ///
  /// The [stepPercentage] is the percentage of the track to move when interacting with the slider using a keyboard.
  /// Defaults to 0.05 (5%).
  ///
  /// The [onChange] callback is called when the selected value changes.
  const factory FSliderControl.managedContinuousRange({
    FContinuousSliderController? controller,
    FSliderValue? initial,
    double? stepPercentage,
    ValueChanged<FSliderValue>? onChange,
  }) = _ContinuousRange;

  /// Creates a [FSliderControl] for selecting a single discrete value.
  ///
  /// The [controller], when provided, means all other configuration parameters should not be provided as they
  /// will be ignored. Pass these values to the controller's constructor instead.
  ///
  /// The [initial] value. Defaults to `FSliderValue(max: 0)`.
  ///
  /// The [interaction] is the allowed ways to interact with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  ///
  /// The [thumb] is the active thumb. Defaults to [FSliderActiveThumb.max].
  ///
  /// The [onChange] callback is called when the selected value changes.
  const factory FSliderControl.managedDiscrete({
    FDiscreteSliderController? controller,
    FSliderValue? initial,
    FSliderInteraction? interaction,
    FSliderActiveThumb? thumb,
    ValueChanged<FSliderValue>? onChange,
  }) = _Discrete;

  /// Creates a [FSliderControl] for selecting a discrete range.
  ///
  /// The [controller], when provided, means all other configuration parameters should not be provided as they
  /// will be ignored. Pass these values to the controller's constructor instead.
  ///
  /// The [initial] value. Defaults to `FSliderValue(min: 0, max: 0)`.
  ///
  /// The [onChange] callback is called when the selected value changes.
  const factory FSliderControl.managedDiscreteRange({
    FDiscreteSliderController? controller,
    FSliderValue? initial,
    ValueChanged<FSliderValue>? onChange,
  }) = _DiscreteRange;

  /// Creates a lifted [FSliderControl] for selecting a single continuous value.
  ///
  /// The [value] is the current value.
  ///
  /// The [onChange] callback is called when the selected value changes.
  ///
  /// The [interaction] is the allowed ways to interact with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  ///
  /// The [thumb] is the active thumb. Defaults to [FSliderActiveThumb.max].
  ///
  /// The [stepPercentage] is the percentage of the track to move when interacting with the slider using a keyboard.
  /// Defaults to 0.05 (5%).
  const factory FSliderControl.liftedContinuous({
    required FSliderValue value,
    required ValueChanged<FSliderValue> onChange,
    FSliderInteraction? interaction,
    FSliderActiveThumb? thumb,
    double? stepPercentage,
  }) = _LiftedContinuous;

  /// Creates a lifted [FSliderControl] for selecting a continuous range.
  ///
  /// The [value] is the current value.
  ///
  /// The [onChange] callback is called when the selected value changes.
  ///
  /// The [stepPercentage] is the percentage of the track to move when interacting with the slider using a keyboard.
  /// Defaults to 0.05 (5%).
  const factory FSliderControl.liftedContinuousRange({
    required FSliderValue value,
    required ValueChanged<FSliderValue> onChange,
    double? stepPercentage,
  }) = _LiftedContinuousRange;

  /// Creates a lifted [FSliderControl] for selecting a single discrete value.
  ///
  /// The [value] is the current value.
  ///
  /// The [onChange] callback is called when the selected value changes.
  ///
  /// The [interaction] is the allowed ways to interact with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  ///
  /// The [thumb] is the active thumb. Defaults to [FSliderActiveThumb.max].
  const factory FSliderControl.liftedDiscrete({
    required FSliderValue value,
    required ValueChanged<FSliderValue> onChange,
    FSliderInteraction? interaction,
    FSliderActiveThumb? thumb,
  }) = _LiftedDiscrete;

  /// Creates a lifted [FSliderControl] for selecting a discrete range.
  ///
  /// The [value] is the current value.
  ///
  /// The [onChange] callback is called when the selected value changes.
  const factory FSliderControl.liftedDiscreteRange({
    required FSliderValue value,
    required ValueChanged<FSliderValue> onChange,
  }) = _LiftedDiscreteRange;

  const FSliderControl._();

  (FSliderController, bool) _update(FSliderControl old, FSliderController controller, VoidCallback callback);
}

/// A [FSliderManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
abstract class FSliderManagedControl extends FSliderControl with _$FSliderManagedControlMixin {
  /// The controller.
  @override
  final FSliderController? controller;

  /// The initial value. Defaults to `FSliderValue(max: 0)`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final FSliderValue? initial;

  /// The allowed ways to interact with the slider. Defaults to [FSliderInteraction.tapAndSlideThumb].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [interaction] is provided and [controller] is also provided.
  @override
  final FSliderInteraction? interaction;

  /// Called when the selected value changes.
  @override
  final ValueChanged<FSliderValue>? onChange;

  /// Creates a [FSliderManagedControl].
  const FSliderManagedControl({this.controller, this.initial, this.interaction, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Pass initial value to the controller instead.',
      ),
      assert(
        controller == null || interaction == null,
        'Cannot provide both controller and interaction. Pass interaction to the controller instead.',
      ),
      super._();
}

class _Continuous extends FSliderManagedControl {
  final double? stepPercentage;
  final FSliderActiveThumb? thumb;

  const _Continuous({
    this.stepPercentage,
    this.thumb,
    super.controller,
    super.initial,
    super.interaction,
    super.onChange,
  }) : assert(
         controller == null || stepPercentage == null,
         'Cannot provide both controller and stepPercentage. Pass stepPercentage to the controller instead.',
       ),
       assert(
         controller == null || thumb == null,
         'Cannot provide both controller and thumb. Pass thumb to the controller instead.',
       );

  @override
  FSliderController createController() =>
      controller ??
      FContinuousSliderController(
        value: initial ?? .new(max: 0),
        stepPercentage: stepPercentage ?? 0.05,
        interaction: interaction ?? .tapAndSlideThumb,
        thumb: thumb ?? .max,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(PercentProperty('stepPercentage', stepPercentage))
      ..add(EnumProperty('thumb', thumb));
  }
}

class _ContinuousRange extends FSliderManagedControl {
  final double? stepPercentage;

  const _ContinuousRange({this.stepPercentage, super.controller, super.initial, super.onChange})
    : assert(
        controller == null || stepPercentage == null,
        'Cannot provide both controller and stepPercentage. Pass stepPercentage to the controller instead.',
      );

  @override
  FSliderController createController() =>
      controller ??
      FContinuousSliderController.range(
        value: initial ?? .new(min: 0, max: 0.25),
        stepPercentage: stepPercentage ?? 0.05,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('stepPercentage', stepPercentage));
  }
}

class _Discrete extends FSliderManagedControl {
  final FSliderActiveThumb? thumb;

  const _Discrete({this.thumb, super.controller, super.initial, super.interaction, super.onChange})
    : assert(
        controller == null || thumb == null,
        'Cannot provide both controller and thumb. Pass thumb to the controller instead.',
      );

  @override
  FSliderController createController() =>
      controller ??
      FDiscreteSliderController(
        value: initial ?? .new(max: 0),
        interaction: interaction ?? .tapAndSlideThumb,
        thumb: thumb ?? .max,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('thumb', thumb));
  }
}

class _DiscreteRange extends FSliderManagedControl {
  const _DiscreteRange({super.controller, super.initial, super.onChange});

  @override
  FSliderController createController() =>
      controller ?? FDiscreteSliderController.range(value: initial ?? .new(min: 0, max: 0));
}

abstract class _Lifted extends FSliderControl with _$_LiftedMixin {
  @override
  final FSliderValue value;
  @override
  final ValueChanged<FSliderValue> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();
}

class _LiftedContinuous extends _Lifted with _$_LiftedContinuousMixin {
  @override
  final double? stepPercentage;
  @override
  final FSliderInteraction? interaction;
  @override
  final FSliderActiveThumb? thumb;

  const _LiftedContinuous({
    required super.value,
    required super.onChange,
    this.stepPercentage,
    this.interaction,
    this.thumb,
  });

  @override
  FSliderController createController() => ProxyContinuousSliderController(
    value: value,
    onChange: onChange,
    stepPercentage: stepPercentage ?? 0.05,
    interaction: interaction ?? .tapAndSlideThumb,
    thumb: thumb ?? .max,
  );

  @override
  void _updateController(FSliderController controller) =>
      (controller as ProxyContinuousSliderController).update(value: value, onChange: onChange);
}

class _LiftedContinuousRange extends _Lifted with _$_LiftedContinuousRangeMixin {
  @override
  final double? stepPercentage;

  const _LiftedContinuousRange({required super.value, required super.onChange, this.stepPercentage});

  @override
  FSliderController createController() =>
      ProxyContinuousSliderController.range(value: value, onChange: onChange, stepPercentage: stepPercentage ?? 0.05);

  @override
  void _updateController(FSliderController controller) =>
      (controller as ProxyContinuousSliderController).update(value: value, onChange: onChange);
}

class _LiftedDiscrete extends _Lifted with _$_LiftedDiscreteMixin {
  @override
  final FSliderInteraction? interaction;
  @override
  final FSliderActiveThumb? thumb;

  const _LiftedDiscrete({required super.value, required super.onChange, this.interaction, this.thumb});

  @override
  FSliderController createController() => ProxyDiscreteSliderController(
    value: value,
    onChange: onChange,
    interaction: interaction ?? .tapAndSlideThumb,
    thumb: thumb ?? .max,
  );

  @override
  void _updateController(FSliderController controller) =>
      (controller as ProxyDiscreteSliderController).update(value: value, onChange: onChange);
}

class _LiftedDiscreteRange extends _Lifted with _$_LiftedDiscreteRangeMixin {
  const _LiftedDiscreteRange({required super.value, required super.onChange});

  @override
  FSliderController createController() => ProxyDiscreteSliderController.range(value: value, onChange: onChange);

  @override
  void _updateController(FSliderController controller) =>
      (controller as ProxyDiscreteSliderController).update(value: value, onChange: onChange);
}

/// A slider's tooltip controllers.
class FSliderTooltipControls with Diagnosticable {
  /// The tooltip controller for the min thumb.
  final FTooltipControl min;

  /// The tooltip controller for the max thumb.
  final FTooltipControl max;

  /// Whether tooltips are enabled. Defaults to true.
  final bool enabled;

  /// Creates a [FSliderTooltipControls] with the given tooltip controllers.
  const FSliderTooltipControls({this.min = const .managed(), this.max = const .managed()}) : enabled = true;

  /// Creates a [FSliderTooltipControls] with both tooltips disabled.
  const FSliderTooltipControls.disabled() : min = const .managed(), max = const .managed(), enabled = false;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('min', min))
      ..add(DiagnosticsProperty('max', max))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}
