// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

final timeField = FTimeField(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  hour24: false,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Time'),
  description: const Text('Select a time'),
  onSaved: (time) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  textInputAction: null,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  onEditingComplete: () {},
  onSubmit: (time) {},
  mouseCursor: null,
  canRequestFocus: true,
  builder: (context, style, states, field) => field,
  prefixBuilder: FTimeField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final timeFieldPicker = FTimeField.picker(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  hour24: false,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Time'),
  description: const Text('Select a time'),
  onSaved: (time) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  format: DateFormat.jm(),
  hint: 'Select time',
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  builder: (context, style, states, field) => field,
  prefixBuilder: FTimeField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Picker"}
  hourInterval: 1,
  minuteInterval: 1,
  anchor: .topLeft,
  fieldAnchor: .bottomLeft,
  constraints: const FPortalConstraints(maxWidth: 200, maxHeight: 200),
  spacing: const FPortalSpacing(4),
  overflow: FPortalOverflow.flip,
  offset: .zero,
  hideRegion: .anywhere,
  groupId: null,
  onTapHide: () {},
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the time field value.
final FTimeFieldControl lifted = .lifted(
  time: const FTime(9, 30),
  onChange: (time) {},
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOutCubic,
);

// {@category "Control" "`.managed()` with internal controller"}
/// Manages time field state internally.
final FTimeFieldControl managedInternal = .managed(
  initial: const FTime(9, 30),
  validator: (time) => null,
  onChange: (time) {},
);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for time field management.
final FTimeFieldControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FTimeFieldController(time: const FTime(9, 30)),
  onChange: (time) {},
);

// {@category "Popover Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl popoverLifted = .lifted(shown: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with internal controller"}
/// Manages the popover's visibility internally.
final FPopoverControl popoverInternal = .managed(initial: true, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with external controller"}
/// Uses an external `FPopoverController` to control the popover's visibility.
final FPopoverControl popoverExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: true, motion: const FPopoverMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
