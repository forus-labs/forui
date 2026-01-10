// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final checkbox = FCheckbox(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  value: false,
  onChange: (value) {},
  label: const Text('Accept terms'),
  description: const Text('You agree to our terms of service'),
  error: null,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Accept terms checkbox',
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
);
