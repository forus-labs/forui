// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final tile = FTile(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  enabled: true,
  selected: false,
  title: const Text('Title'),
  subtitle: const Text('Subtitle'),
  details: const Text('Details'),
  prefix: const Icon(FIcons.house),
  suffix: const Icon(FIcons.chevronRight),
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
  semanticsLabel: 'Tile',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
);

final tileRaw = FTile.raw(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  enabled: true,
  selected: false,
  prefix: const Icon(FIcons.house),
  child: const Text('Custom Content'),
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
  semanticsLabel: 'Tile',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
);
