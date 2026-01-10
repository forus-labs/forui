// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final selectGroup = FSelectGroup<String>(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  children: [
    .checkbox(value: 'apple', label: const Text('Apple')),
    .checkbox(value: 'banana', label: const Text('Banana')),
    .checkbox(value: 'cherry', label: const Text('Cherry')),
  ],
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Select fruits'),
  description: const Text('Choose your favorite fruits'),
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .disabled,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
);

final selectGroupCheckbox = FSelectGroupItemMixin.checkbox<String>(
  // {@category "Core"}
  style: null,
  value: 'apple',
  enabled: true,
  label: const Text('Apple'),
  description: const Text('A red fruit'),
  error: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Apple checkbox',
  // {@endcategory}
);

final selectGroupRadio = FSelectGroupItemMixin.radio<String>(
  // {@category "Core"}
  style: null,
  value: 'apple',
  enabled: true,
  label: const Text('Apple'),
  description: const Text('A red fruit'),
  error: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  semanticsLabel: 'Apple radio',
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the select group's values.
final FMultiValueControl<String> lifted = .lifted(value: {}, onChange: (values) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the select group state internally for multiple selections.
final FMultiValueControl<String> managedInternal = .managed(initial: {}, min: 0, max: null, onChange: (values) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for multiple selections.
final FMultiValueControl<String> managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FMultiValueNotifier<String>(value: {}, min: 0, max: 5),
  onChange: (values) {},
);

// {@category "Control" "`.managedRadio()` with internal controller"}
/// Single selection with internal controller (radio behavior).
final FMultiValueControl<String> managedRadioInternal = .managedRadio(initial: null, onChange: (values) {});

// {@category "Control" "`.managedRadio()` with external controller"}
/// Single selection with external controller (radio behavior).
final FMultiValueControl<String> managedRadioExternal = .managedRadio(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .radio(),
  onChange: (values) {},
);
