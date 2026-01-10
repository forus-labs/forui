// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final popover = FPopover(
  // {@category "Core"}
  style: (style) => style,
  popoverBuilder: (context, controller) => const Padding(padding: .all(8), child: Text('Popover content')),
  builder: (context, controller, child) => child!,
  child: FButton(onPress: () {}, child: const Text('Show Popover')),
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  constraints: const FPortalConstraints(),
  popoverAnchor: .topCenter,
  childAnchor: .bottomCenter,
  spacing: const .spacing(4),
  overflow: .flip,
  offset: .zero,
  // {@endcategory}
  // {@category "Tap Region"}
  groupId: null,
  hideRegion: .excludeChild,
  onTapHide: () {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: null,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Popover',
  traversalEdgeBehavior: null,
  barrierSemanticsLabel: null,
  barrierSemanticsDismissible: true,
  shortcuts: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl lifted = .lifted(shown: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the popover state internally.
final FPopoverControl managedInternal = .managed(initial: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the popover's state.
final FPopoverControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: false, motion: const FPopoverMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
