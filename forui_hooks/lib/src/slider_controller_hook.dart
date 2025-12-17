import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FContinuousSliderController] that represents a continuous value and is automatically disposed.
FContinuousSliderController useFContinuousSliderController({
  required FSliderSelection selection,
  FSliderInteraction allowedInteraction = .tapAndSlideThumb,
  double stepPercentage = 0.05,
  bool minExtendable = false,
  List<Object?>? keys,
}) => use(
  _ContinuousControllerHook(
    selection: selection,
    stepPercentage: stepPercentage,
    allowedInteraction: allowedInteraction,
    minExtendable: minExtendable,
    keys: keys,
  ),
);

class _ContinuousControllerHook extends Hook<FContinuousSliderController> {
  final FSliderSelection selection;
  final double stepPercentage;
  final FSliderInteraction allowedInteraction;
  final bool minExtendable;

  const _ContinuousControllerHook({
    required this.selection,
    required this.stepPercentage,
    required this.allowedInteraction,
    required this.minExtendable,
    super.keys,
  });

  @override
  _ContinuousControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(PercentProperty('stepPercentage', stepPercentage))
      ..add(EnumProperty('allowedInteraction', allowedInteraction))
      ..add(FlagProperty('minExtendable', value: minExtendable, ifTrue: 'min extendable', ifFalse: 'max extendable'));
  }
}

class _ContinuousControllerHookState extends HookState<FContinuousSliderController, _ContinuousControllerHook> {
  late final _controller = FContinuousSliderController(
    selection: hook.selection,
    stepPercentage: hook.stepPercentage,
    allowedInteraction: hook.allowedInteraction,
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
  List<Object?>? keys,
}) => use(
  _ContinuousRangeControllerHook(selection: selection, stepPercentage: stepPercentage, keys: keys),
);

class _ContinuousRangeControllerHook extends Hook<FContinuousSliderController> {
  final FSliderSelection selection;
  final double stepPercentage;

  const _ContinuousRangeControllerHook({
    required this.selection,
    required this.stepPercentage,
    super.keys,
  });

  @override
  _ContinuousRangeControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(DoubleProperty('stepPercentage', stepPercentage));
  }
}

class _ContinuousRangeControllerHookState
    extends HookState<FContinuousSliderController, _ContinuousRangeControllerHook> {
  late final _controller = FContinuousSliderController.range(
    selection: hook.selection,
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
  required FSliderSelection selection,
  FSliderInteraction allowedInteraction = .tapAndSlideThumb,
  bool minExtendable = false,
  List<Object?>? keys,
}) => use(
  _DiscreteControllerHook(
    selection: selection,
    allowedInteraction: allowedInteraction,
    minExtendable: minExtendable,
    keys: keys,
  ),
);

class _DiscreteControllerHook extends Hook<FDiscreteSliderController> {
  final FSliderSelection selection;
  final FSliderInteraction allowedInteraction;
  final bool minExtendable;

  const _DiscreteControllerHook({
    required this.selection,
    required this.allowedInteraction,
    required this.minExtendable,
    super.keys,
  });

  @override
  _DiscreteControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selection', selection))
      ..add(EnumProperty('allowedInteraction', allowedInteraction))
      ..add(FlagProperty('minExtendable', value: minExtendable, ifTrue: 'min extendable', ifFalse: 'max extendable'));
  }
}

class _DiscreteControllerHookState extends HookState<FDiscreteSliderController, _DiscreteControllerHook> {
  late final _controller = FDiscreteSliderController(
    selection: hook.selection,
    allowedInteraction: hook.allowedInteraction,
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
  List<Object?>? keys,
}) => use(_DiscreteRangeControllerHook(selection: selection, keys: keys));

class _DiscreteRangeControllerHook extends Hook<FDiscreteSliderController> {
  final FSliderSelection selection;

  const _DiscreteRangeControllerHook({required this.selection, super.keys});

  @override
  _DiscreteRangeControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('selection', selection));
  }
}

class _DiscreteRangeControllerHookState extends HookState<FDiscreteSliderController, _DiscreteRangeControllerHook> {
  late final _controller = FDiscreteSliderController.range(selection: hook.selection);

  @override
  FDiscreteSliderController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFDiscreteRangeSliderController';
}
