// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final sidebar = FSidebar(
  // {@category "Core"}
  style: (style) => style,
  header: const Text('Header'),
  children: [
    FSidebarGroup(
      label: const Text('Navigation'),
      children: [
        FSidebarItem(icon: const Icon(FIcons.house), label: const Text('Home'), onPress: () {}),
        FSidebarItem(icon: const Icon(FIcons.settings), label: const Text('Settings'), onPress: () {}),
      ],
    ),
  ],
  footer: const Text('Footer'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: null,
  // {@endcategory}
);

final sidebarBuilder = FSidebar.builder(
  // {@category "Core"}
  style: (style) => style,
  header: const Text('Header'),
  itemBuilder: (context, index) => FSidebarItem(label: Text('Item $index'), onPress: () {}),
  itemCount: 10,
  footer: const Text('Footer'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: null,
  // {@endcategory}
);

final sidebarRaw = FSidebar.raw(
  // {@category "Core"}
  style: (style) => style,
  header: const Text('Header'),
  child: ListView(
    children: [FSidebarItem(label: const Text('Custom Item'), onPress: () {})],
  ),
  footer: const Text('Footer'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  traversalEdgeBehavior: null,
  // {@endcategory}
);

final sidebarGroup = FSidebarGroup(
  // {@category "Core"}
  style: (style) => style,
  label: const Text('Navigation'),
  action: const Icon(FIcons.plus),
  children: [
    FSidebarItem(label: const Text('Home'), onPress: () {}),
    FSidebarItem(label: const Text('Settings'), onPress: () {}),
  ],
  // {@endcategory}
  // {@category "Callbacks"}
  onActionHoverChange: (hovered) {},
  onActionStateChange: (states) {},
  onActionPress: () {},
  onActionLongPress: () {},
  // {@endcategory}
);

final sidebarItem = FSidebarItem(
  // {@category "Core"}
  style: (style) => style,
  selected: false,
  initiallyExpanded: false,
  icon: const Icon(FIcons.house),
  label: const Text('Home'),
  children: [
    FSidebarItem(label: const Text('Nested Item 1'), onPress: () {}),
    FSidebarItem(label: const Text('Nested Item 2'), onPress: () {}),
  ],
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);
