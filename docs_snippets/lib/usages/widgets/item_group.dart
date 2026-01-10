// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final itemGroup = FItemGroup(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  divider: .none,
  children: [
    .item(title: const Text('Item 1'), onPress: () {}),
    .item(title: const Text('Item 2'), onPress: () {}),
  ],
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item group',
  // {@endcategory}
);

final builder = FItemGroup.builder(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  divider: .none,
  itemBuilder: (context, index) => FItem(title: Text('Item $index'), onPress: () {}),
  count: 10,
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item group',
  // {@endcategory}
);

final merge = FItemGroup.merge(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  divider: .full,
  children: [
    .group(
      children: [.item(title: const Text('Group 1 Item'), onPress: () {})],
    ),
    .group(
      children: [.item(title: const Text('Group 2 Item'), onPress: () {})],
    ),
  ],
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item group',
  // {@endcategory}
);
