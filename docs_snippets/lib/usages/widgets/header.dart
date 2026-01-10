// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final header = FHeader(
  // {@category "Core"}
  style: (style) => style,
  title: const Text('Title'),
  suffixes: [FHeaderAction(icon: const Icon(FIcons.settings), onPress: () {})],
  // {@endcategory}
);

final nested = FHeader.nested(
  // {@category "Core"}
  style: (style) => style,
  title: const Text('Title'),
  titleAlignment: .center,
  prefixes: [FHeaderAction.back(onPress: () {})],
  suffixes: [FHeaderAction.x(onPress: () {})],
  // {@endcategory}
);
