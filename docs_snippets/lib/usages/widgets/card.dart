// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final card = FCard(
  // {@category "Core"}
  style: (style) => style,
  mainAxisSize: .min,
  image: const Placeholder(),
  title: const Text('Title'),
  subtitle: const Text('Subtitle'),
  child: const Text('Content'),
  // {@endcategory}
);

final raw = FCard.raw(
  // {@category "Core"}
  style: (style) => style,
  child: const Text('Content'),
  // {@endcategory}
);
