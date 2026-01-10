// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tappable = FTappable(
  // {@category "Core"}
  style: (style) => style,
  focusedOutlineStyle: (style) => style,
  selected: false,
  behavior: .translucent,
  builder: (context, states, child) => child!,
  child: const Text('Tap me'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tappable button',
  excludeSemantics: false,
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (delta) {},
  // {@endcategory}
);

final tappableStatic = FTappable.static(
  // {@category "Core"}
  style: (style) => style,
  focusedOutlineStyle: (style) => style,
  selected: false,
  behavior: .translucent,
  builder: (context, states, child) => child!,
  child: const Text('Tap me'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Tappable button',
  excludeSemantics: false,
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onPress: () {},
  onLongPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  onHoverChange: (hovered) {},
  onStateChange: (delta) {},
  // {@endcategory}
);
