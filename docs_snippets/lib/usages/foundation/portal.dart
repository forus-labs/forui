// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final portal = FPortal(
  // {@category "Core"}
  controller: null,
  portalBuilder: (context, controller) => const Text('Portal content'),
  builder: (context, controller, child) => child!,
  child: const Text('Child'),
  barrier: null,
  // {@endcategory}
  // {@category "Layout"}
  constraints: const FPortalConstraints(),
  portalAnchor: .topCenter,
  childAnchor: .bottomCenter,
  spacing: .zero,
  overflow: .flip,
  offset: .zero,
  viewInsets: null,
  // {@endcategory}
);
