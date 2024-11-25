// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FContinuousSliderController] that represents a continuous value and is automatically disposed.
FContinuousSliderController useFContinuousSliderController({
  required FSliderSelection selection,
  FSliderInteraction allowedInteraction = FSliderInteraction.tapAndSlideThumb,
  double stepPercentage = 0.05,
  bool tooltips = true,
  bool minExtendable = false,
  List<Object?>? keys,
}) =>
    use(_ContinuousControllerHook(
      selection: selection,
      stepPercentage: stepPercentage,
      tooltips: tooltips,
      allowedInteraction: allowedInteraction,
      minExtendable: minExtendable,
      keys: keys,
    ));

class _ContinuousControllerHook extends Hook<FContinuousSliderController> {
  final FSliderSelection selection;
  final double stepPercentage;
  final bool tooltips;
  final FSliderInteraction allowedInteraction;
  final bool minExtendable;

  const _ContinuousControllerHook({
    required this.selection,
    required this.stepPercentage,
    required this.tooltips,
    required this.allowedInteraction,
    required this.minExtendable,
    super.keys,
  });

  @override
  _ContinuousControllerHookState createState() => _ContinuousControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(DoubleProperty('stepPercentage', stepPercentage))
      ..add(FlagProperty('tooltips', value: tooltips, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('allowedInteraction', allowedInteraction))
      ..add(FlagProperty('minExtendable', value: minExtendable, ifTrue: 'min extendable', ifFalse: 'max extendable'));
  }
}

class _ContinuousControllerHookState extends HookState<FContinuousSliderController, _ContinuousControllerHook> {
  late final FContinuousSliderController _controller = FContinuousSliderController(
    selection: hook.selection,
    stepPercentage: hook.stepPercentage,
    allowedInteraction: hook.allowedInteraction,
    tooltips: hook.tooltips,
    minExtendable: hook.minExtendable,
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
  required FSliderSelection selection,
  double stepPercentage = 0.05,
  bool tooltips = true,
  List<Object?>? keys,
}) =>
    use(_ContinuousRangeControllerHook(
      selection: selection,
      stepPercentage: stepPercentage,
      tooltips: tooltips,
      keys: keys,
    ));

class _ContinuousRangeControllerHook extends Hook<FContinuousSliderController> {
  final FSliderSelection selection;
  final double stepPercentage;
  final bool tooltips;

  const _ContinuousRangeControllerHook({
    required this.selection,
    required this.stepPercentage,
    required this.tooltips,
    super.keys,
  });

  @override
  _ContinuousRangeControllerHookState createState() => _ContinuousRangeControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(DoubleProperty('stepPercentage', stepPercentage))
      ..add(FlagProperty('tooltips', value: tooltips, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

class _ContinuousRangeControllerHookState
    extends HookState<FContinuousSliderController, _ContinuousRangeControllerHook> {
  late final FContinuousSliderController _controller = FContinuousSliderController.range(
    selection: hook.selection,
    stepPercentage: hook.stepPercentage,
    tooltips: hook.tooltips,
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
  required FSliderSelection selection,
  FSliderInteraction allowedInteraction = FSliderInteraction.tapAndSlideThumb,
  bool tooltips = true,
  bool minExtendable = false,
  List<Object?>? keys,
}) =>
    use(_DiscreteControllerHook(
      selection: selection,
      tooltips: tooltips,
      allowedInteraction: allowedInteraction,
      minExtendable: minExtendable,
      keys: keys,
    ));

class _DiscreteControllerHook extends Hook<FDiscreteSliderController> {
  final FSliderSelection selection;
  final bool tooltips;
  final FSliderInteraction allowedInteraction;
  final bool minExtendable;

  const _DiscreteControllerHook({
    required this.selection,
    required this.tooltips,
    required this.allowedInteraction,
    required this.minExtendable,
    super.keys,
  });

  @override
  _DiscreteControllerHookState createState() => _DiscreteControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(FlagProperty('tooltips', value: tooltips, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('allowedInteraction', allowedInteraction))
      ..add(FlagProperty('minExtendable', value: minExtendable, ifTrue: 'min extendable', ifFalse: 'max extendable'));
  }
}

class _DiscreteControllerHookState extends HookState<FDiscreteSliderController, _DiscreteControllerHook> {
  late final FDiscreteSliderController _controller = FDiscreteSliderController(
    selection: hook.selection,
    allowedInteraction: hook.allowedInteraction,
    tooltips: hook.tooltips,
    minExtendable: hook.minExtendable,
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
  required FSliderSelection selection,
  bool tooltips = true,
  List<Object?>? keys,
}) =>
    use(_DiscreteRangeControllerHook(
      selection: selection,
      tooltips: tooltips,
      keys: keys,
    ));

class _DiscreteRangeControllerHook extends Hook<FDiscreteSliderController> {
  final FSliderSelection selection;
  final bool tooltips;

  const _DiscreteRangeControllerHook({
    required this.selection,
    required this.tooltips,
    super.keys,
  });

  @override
  _DiscreteRangeControllerHookState createState() => _DiscreteRangeControllerHookState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(FlagProperty('tooltips', value: tooltips, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

class _DiscreteRangeControllerHookState extends HookState<FDiscreteSliderController, _DiscreteRangeControllerHook> {
  late final FDiscreteSliderController _controller = FDiscreteSliderController.range(
    selection: hook.selection,
    tooltips: hook.tooltips,
  );

  @override
  FDiscreteSliderController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFDiscreteRangeSliderController';
}
