// ignore_for_file: sort_child_properties_last

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final accordion = FAccordion(
  // {@category "core"}
  style: FThemes.zinc.light.accordionStyle,
  children: const [FAccordionItem(title: Text('Title'), child: SizedBox())],
  key: const Key('key'),
  // {@endcategory}
  // {@category "control"}
  control: const .managed(min: 1, max: 2),
  // {@endcategory}
);

// {@category "control" ".lifted()"}
/// Externally controls the accordion items' expanded state.
final FAccordionControl lifted = .lifted(expanded: (index) => true, onChange: (index, expanded) {});

// {@category "control" ".managed() with internal controller"}
/// Manages the expanded state of the accordion items internally.
final FAccordionControl internal = .managed(min: 1, max: 2, onChange: (items) {});

// {@category "control" ".managed() with external controller"}
/// Uses an external `FAccordionController` to control the accordion items' expanded state.
final FAccordionControl external = .managed(
  // For demonstration purposes only. Don't create a controller inline, store in a State instead.
  controller: FAccordionController(min: 1, max: 2),
  onChange: (items) {},
);
