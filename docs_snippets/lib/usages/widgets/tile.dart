// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tile = FTile(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  selected: false,
  onPress: () {},
  title: const Text('Title'),
  subtitle: const Text('Subtitle'),
  details: const Text('Details'),
  prefix: const Icon(FIcons.house),
  suffix: const Icon(FIcons.chevronRight),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tile',
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

final tileRaw = FTile.raw(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  selected: false,
  onPress: () {},
  prefix: const Icon(FIcons.house),
  child: const Text('Custom Content'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tile',
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
