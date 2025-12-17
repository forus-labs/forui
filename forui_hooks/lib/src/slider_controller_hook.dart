import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FContinuousSliderController] that represents a continuous value and is automatically disposed.
FContinuousSliderController useFContinuousSliderController({
  required FSliderValue value,
  FSliderInteraction interaction = .tapAndSlideThumb,
  double stepPercentage = 0.05,
  FSliderActiveThumb activeThumb = .max,
  List<Object?>? keys,
}) => use(
  _ContinuousControllerHook(
    value: value,
    stepPercentage: stepPercentage,
    interaction: interaction,
    activeThumb: activeThumb,
    keys: keys,
  ),
);

class _ContinuousControllerHook extends Hook<FContinuousSliderController> {
  final FSliderValue value;
  final double stepPercentage;
  final FSliderInteraction interaction;
  final FSliderActiveThumb activeThumb;

  const _ContinuousControllerHook({
    required this.value,
    required this.stepPercentage,
    required this.interaction,
    required this.activeThumb,
    super.keys,
  });

  @override
  _ContinuousControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(PercentProperty('stepPercentage', stepPercentage))
      ..add(EnumProperty('interaction', interaction))
      ..add(EnumProperty('activeThumb', activeThumb));
  }
}

class _ContinuousControllerHookState extends HookState<FContinuousSliderController, _ContinuousControllerHook> {
  late final _controller = FContinuousSliderController(
    value: hook.value,
    stepPercentage: hook.stepPercentage,
    interaction: hook.interaction,
    thumb: hook.activeThumb,
  );

  @override
  FContinuousSliderController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFContinuousSliderController';
}

/// Creates a [FContinuousSliderController] that represents a continuous range and is automatically disposed.
FContinuousSliderController useFContinuousRangeSliderController({
  required FSliderValue value,
  double stepPercentage = 0.05,
  List<Object?>? keys,
}) => use(
  _ContinuousRangeControllerHook(value: value, stepPercentage: stepPercentage, keys: keys),
);

class _ContinuousRangeControllerHook extends Hook<FContinuousSliderController> {
  final FSliderValue value;
  final double stepPercentage;

  const _ContinuousRangeControllerHook({
    required this.value,
    required this.stepPercentage,
    super.keys,
  });

  @override
  _ContinuousRangeControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(DoubleProperty('stepPercentage', stepPercentage));
  }
}

class _ContinuousRangeControllerHookState
    extends HookState<FContinuousSliderController, _ContinuousRangeControllerHook> {
  late final _controller = FContinuousSliderController.range(
    value: hook.value,
    stepPercentage: hook.stepPercentage,
  );

  @override
  FContinuousSliderController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFContinuousRangeSliderController';
}

/// Creates a [FDiscreteSliderController] that represents a discrete value and is automatically disposed.
FDiscreteSliderController useFDiscreteSliderController({
  required FSliderValue value,
  FSliderInteraction interaction = .tapAndSlideThumb,
  FSliderActiveThumb activeThumb = .max,
  List<Object?>? keys,
}) => use(
  _DiscreteControllerHook(
    value: value,
    interaction: interaction,
    activeThumb: activeThumb,
    keys: keys,
  ),
);

class _DiscreteControllerHook extends Hook<FDiscreteSliderController> {
  final FSliderValue value;
  final FSliderInteraction interaction;
  final FSliderActiveThumb activeThumb;

  const _DiscreteControllerHook({
    required this.value,
    required this.interaction,
    required this.activeThumb,
    super.keys,
  });

  @override
  _DiscreteControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(EnumProperty('interaction', interaction))
      ..add(EnumProperty('activeThumb', activeThumb));
  }
}

class _DiscreteControllerHookState extends HookState<FDiscreteSliderController, _DiscreteControllerHook> {
  late final _controller = FDiscreteSliderController(
    value: hook.value,
    interaction: hook.interaction,
    thumb: hook.activeThumb,
  );

  @override
  FDiscreteSliderController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFDiscreteSliderController';
}

/// Creates a [FDiscreteSliderController] that represents a discrete range and is automatically disposed.
FDiscreteSliderController useFDiscreteRangeSliderController({
  required FSliderValue value,
  List<Object?>? keys,
}) => use(_DiscreteRangeControllerHook(value: value, keys: keys));

class _DiscreteRangeControllerHook extends Hook<FDiscreteSliderController> {
  final FSliderValue value;

  const _DiscreteRangeControllerHook({required this.value, super.keys});

  @override
  _DiscreteRangeControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('value', value));
  }
}

class _DiscreteRangeControllerHookState extends HookState<FDiscreteSliderController, _DiscreteRangeControllerHook> {
  late final _controller = FDiscreteSliderController.range(value: hook.value);

  @override
  FDiscreteSliderController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFDiscreteRangeSliderController';
}
