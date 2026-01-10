// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final accordion = FAccordion(
  // {@category "Core"}
  style: (style) => style,
  children: const [FAccordionItem(title: Text('Title'), child: SizedBox())],
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(min: 1, max: 2),
  // {@endcategory}
);

final accordionItem = FAccordionItem(
  // {@category "Core"}
  style: null,
  title: const Text('Title'),
  icon: const Icon(FIcons.chevronDown),
  initiallyExpanded: false,
  child: const Text('Content'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  // {@endcategory}
  // {@category "Callbacks"}
  onHoverChange: (hovered) {},
  onStateChange: (delta) {},
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the accordion items' expanded state.
final FAccordionControl lifted = .lifted(expanded: (index) => true, onChange: (index, expanded) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the expanded state of the accordion items internally.
final FAccordionControl internal = .managed(min: 1, max: 2, onChange: (items) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external `FAccordionController` to control the accordion items' expanded state.
final FAccordionControl external = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FAccordionController(min: 1, max: 2),
  onChange: (items) {},
);
