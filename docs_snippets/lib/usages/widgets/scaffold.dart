// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final scaffold = FScaffold(
  // {@category "Core"}
  key: const Key('key'),
  scaffoldStyle: (style) => style,
  header: const Text('Header'),
  sidebar: const Text('Sidebar'),
  footer: const Text('Footer'),
  child: const Text('Content'),
  // {@endcategory}
  // {@category "Layout"}
  childPad: true,
  resizeToAvoidBottomInset: true,
  // {@endcategory}
);
