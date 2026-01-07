// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final item = FItem(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  title: const Text('Title'),
  prefix: const Icon(FIcons.user),
  subtitle: const Text('Subtitle'),
  details: const Text('Details'),
  suffix: const Icon(FIcons.chevronRight),
  // {@endcategory}
  // {@category "State"}
  enabled: true,
  selected: false,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
);

final raw = FItem.raw(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  child: const Text('Content'),
  prefix: const Icon(FIcons.user),
  // {@endcategory}
  // {@category "State"}
  enabled: true,
  selected: false,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Item',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
);
