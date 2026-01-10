// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final bottomNavigationBar = FBottomNavigationBar(
  // {@category "Core"}
  style: (style) => style,
  index: 0,
  onChange: (index) {},
  children: const [FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home'))],
  // {@endcategory}
  // {@category "Safe Area"}
  safeAreaTop: false,
  safeAreaBottom: false,
  // {@endcategory}
);

final bottomNavigationBarItem = FBottomNavigationBarItem(
  // {@category "Core"}
  style: (style) => style,
  icon: const Icon(FIcons.house),
  label: const Text('Home'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onStateChange: (delta) {},
  // {@endcategory}
);
