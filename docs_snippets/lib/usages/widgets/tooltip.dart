// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tooltip = FTooltip(
  // {@category "Core"}
  style: (style) => style,
  tipBuilder: (context, controller) => const Text('Tooltip content'),
  builder: (context, controller, child) => child!,
  child: const Text('Hover me'),
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  tipAnchor: .bottomCenter,
  childAnchor: .topCenter,
  spacing: const .spacing(4),
  overflow: .flip,
  // {@endcategory}
  // {@category "Behavior"}
  hover: true,
  hoverEnterDuration: const Duration(milliseconds: 500),
  hoverExitDuration: .zero,
  longPress: true,
  longPressExitDuration: const Duration(milliseconds: 1500),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the tooltip visibility.
final FTooltipControl lifted = .lifted(shown: false, onChange: (shown) {}, motion: const FTooltipMotion());

// {@category "Control" "`.managed()` with internal controller"}
/// Manages tooltip state internally.
final FTooltipControl managedInternal = .managed(initial: false, onChange: (shown) {}, motion: const FTooltipMotion());

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for tooltip management.
final FTooltipControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FTooltipController(vsync: vsync, shown: false, motion: const FTooltipMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
