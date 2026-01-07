// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final breadcrumb = FBreadcrumb(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  divider: const Icon(FIcons.chevronRight),
  children: const [
    FBreadcrumbItem(child: Text('Home'), onPress: null),
    FBreadcrumbItem(child: Text('Products'), onPress: null),
    FBreadcrumbItem(child: Text('Details'), current: true),
  ],
  // {@endcategory}
);

final breadcrumbItem = FBreadcrumbItem(
  // {@category "Core"}
  key: const Key('key'),
  current: false,
  onPress: () {},
  child: const Text('Home'),
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
);

final breadcrumbItemCollapsed = FBreadcrumbItem.collapsed(
  // {@category "Core"}
  key: const Key('key'),
  menu: [
    FItemGroup(children: [
      FItem(title: const Text('Page 1'), onPress: () {}),
      FItem(title: const Text('Page 2'), onPress: () {}),
    ]),
  ],
  popoverMenuStyle: (style) => style,
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Menu"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: double.infinity,
  dragStartBehavior: .start,
  divider: .full,
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
  // {@category "Callbacks"}
  onFocusChange: (focused) {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: .closedLoop,
  semanticsLabel: 'More pages',
  // {@endcategory}
);

final breadcrumbItemCollapsedTiles = FBreadcrumbItem.collapsedTiles(
  // {@category "Core"}
  key: const Key('key'),
  menu: [
    FTileGroup(children: [
      FTile(title: const Text('Page 1'), onPress: () {}),
      FTile(title: const Text('Page 2'), onPress: () {}),
    ]),
  ],
  popoverMenuStyle: (style) => style,
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Menu"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  divider: .full,
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topLeft,
  childAnchor: .bottomLeft,
  spacing: const .spacing(4),
  overflow: .flip,
  offset: .zero,
  hideRegion: .excludeChild,
  // {@endcategory}
  // {@category "Callbacks"}
  onFocusChange: (focused) {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: .closedLoop,
  semanticsLabel: 'More pages',
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
