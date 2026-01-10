// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final scaffold = FScaffold(
  // {@category "Core"}
  scaffoldStyle: (style) => style,
  childPad: true,
  resizeToAvoidBottomInset: true,
  header: const Text('Header'),
  sidebar: const Text('Sidebar'),
  footer: const Text('Footer'),
  child: const Text('Content'),
  // {@endcategory}
);
