// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final item = FItem(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  selected: false,
  onPress: () {},
  title: const Text('Title'),
  prefix: const Icon(FIcons.user),
  subtitle: const Text('Subtitle'),
  details: const Text('Details'),
  suffix: const Icon(FIcons.chevronRight),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Item',
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

final raw = FItem.raw(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  selected: false,
  onPress: () {},
  child: const Text('Content'),
  prefix: const Icon(FIcons.user),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Item',
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);
