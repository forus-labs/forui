// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final label = FLabel(
  // {@category "Core"}
  style: (style) => style,
  axis: .vertical,
  expands: false,
  states: const {},
  label: const Text('Label'),
  description: const Text('Description'),
  error: const Text('Error message'),
  child: const Placeholder(),
  // {@endcategory}
);
