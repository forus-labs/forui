// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final switchWidget = FSwitch(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  enabled: true,
  value: false,
  onChange: (value) {},
  label: const Text('Enable notifications'),
  description: const Text('Receive push notifications'),
  error: null,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Enable notifications switch',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Others"}
  dragStartBehavior: .start,
  // {@endcategory}
);
