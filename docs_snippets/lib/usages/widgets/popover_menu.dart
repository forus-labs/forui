// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final popoverMenu = FPopoverMenu(
  // {@category "Core"}
  style: (style) => style,
  divider: .full,
  menu: [
    .group(
      children: [
        .item(title: const Text('Edit'), onPress: () {}),
        .item(title: const Text('Delete'), onPress: () {}),
      ],
    ),
  ],
  menuBuilder: (context, controller, menu) => menu!,
  builder: (context, controller, child) => child!,
  child: FButton(onPress: () {}, child: const Text('Menu')),
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topCenter,
  childAnchor: .bottomCenter,
  maxHeight: .infinity,
  spacing: const .spacing(4),
  overflow: .flip,
  offset: .zero,
  // {@endcategory}
  // {@category "Tap Region"}
  groupId: null,
  hideRegion: .excludeChild,
  onTapHide: () {},
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: null,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Menu',
  traversalEdgeBehavior: null,
  barrierSemanticsLabel: null,
  barrierSemanticsDismissible: true,
  // {@endcategory}
);

final popoverMenuTiles = FPopoverMenu.tiles(
  // {@category "Core"}
  style: (style) => style,
  divider: .full,
  menu: [
    .group(
      children: [
        .tile(title: const Text('Edit'), onPress: () {}),
        .tile(title: const Text('Delete'), onPress: () {}),
      ],
    ),
  ],
  menuBuilder: (context, controller, menu) => menu!,
  builder: (context, controller, child) => child!,
  child: FButton(onPress: () {}, child: const Text('Menu')),
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  maxHeight: .infinity,
  menuAnchor: .topCenter,
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
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: null,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Menu',
  traversalEdgeBehavior: null,
  barrierSemanticsLabel: null,
  barrierSemanticsDismissible: true,
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
