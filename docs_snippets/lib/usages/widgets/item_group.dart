// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final itemGroup = FItemGroup(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  enabled: true,
  divider: .none,
  children: [
    FItem(title: const Text('Item 1'), onPress: () {}),
    FItem(title: const Text('Item 2'), onPress: () {}),
  ],
  // {@endcategory}
  // {@category "Scrollable"}
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
  key: const Key('key'),
  style: (style) => style,
  enabled: true,
  divider: .none,
  itemBuilder: (context, index) => FItem(title: Text('Item $index'), onPress: () {}),
  count: 10,
  // {@endcategory}
  // {@category "Scrollable"}
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
  key: const Key('key'),
  style: (style) => style,
  enabled: true,
  divider: .full,
  children: [
    FItemGroup(children: [FItem(title: const Text('Group 1 Item'), onPress: () {})]),
    FItemGroup(children: [FItem(title: const Text('Group 2 Item'), onPress: () {})]),
  ],
  // {@endcategory}
  // {@category "Scrollable"}
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
