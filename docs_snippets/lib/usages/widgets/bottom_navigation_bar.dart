// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final bottomNavigationBar = FBottomNavigationBar(
  // {@category "Core"}
  style: (style) => style,
  children: const [
    FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
    FBottomNavigationBarItem(icon: Icon(FIcons.libraryBig), label: Text('Library')),
    FBottomNavigationBarItem(icon: Icon(FIcons.search), label: Text('Search')),
  ],
  key: const Key('key'),
  // {@endcategory}
  // {@category "State"}
  index: 0,
  onChange: (index) {},
  // {@endcategory}
  // {@category "Safe Area"}
  safeAreaTop: false,
  safeAreaBottom: false,
  // {@endcategory}
);
