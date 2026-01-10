// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final breadcrumb = FBreadcrumb(
  // {@category "Core"}
  style: (style) => style,
  divider: const Icon(FIcons.chevronRight),
  children: const [
    FBreadcrumbItem(child: Text('Home'), onPress: null),
    FBreadcrumbItem(child: Text('Products'), onPress: null),
  ],
  // {@endcategory}
);

final breadcrumbItem = FBreadcrumbItem(
  // {@category "Core"}
  current: false,
  onPress: () {},
  child: const Text('Home'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

final breadcrumbItemCollapsed = FBreadcrumbItem.collapsed(
  // {@category "Core"}
  divider: .full,
  menu: [
    FItemGroup(
      children: [
        FItem(title: const Text('Page 1'), onPress: () {}),
        FItem(title: const Text('Page 2'), onPress: () {}),
      ],
    ),
  ],
  popoverMenuStyle: (style) => style,
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topLeft,
  childAnchor: .bottomLeft,
  spacing: const .spacing(4),
  overflow: .flip,
  offset: .zero,
  hideRegion: .excludeChild,
  onTapHide: () {},
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  traversalEdgeBehavior: .closedLoop,
  semanticsLabel: 'More pages',
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

final breadcrumbItemCollapsedTiles = FBreadcrumbItem.collapsedTiles(
  // {@category "Core"}
  divider: .full,
  menu: [
    FTileGroup(
      children: [
        FTile(title: const Text('Page 1'), onPress: () {}),
        FTile(title: const Text('Page 2'), onPress: () {}),
      ],
    ),
  ],
  popoverMenuStyle: (style) => style,
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topLeft,
  childAnchor: .bottomLeft,
  spacing: const .spacing(4),
  overflow: .flip,
  offset: .zero,
  hideRegion: .excludeChild,
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  traversalEdgeBehavior: .closedLoop,
  semanticsLabel: 'More pages',
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

// {@category "Popover Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl popoverLifted = .lifted(shown: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with internal controller"}
/// Manages the popover's visibility internally.
final FPopoverControl popoverInternal = .managed(initial: true, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with external controller"}
/// Uses an external `FPopoverController` to control the popover's visibility.
final FPopoverControl popoverExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: true, motion: const FPopoverMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
