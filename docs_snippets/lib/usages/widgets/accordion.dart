// ignore_for_file: sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final accordion = FAccordion(
  // {@category "core"}
  key: const Key('key'),
  style: FThemes.zinc.light.accordionStyle,
  children: const [FAccordionItem(title: Text('Title'), child: SizedBox())],
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(min: 1, max: 2),
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
