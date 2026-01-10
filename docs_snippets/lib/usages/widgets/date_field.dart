// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final dateField = FDateField(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  onSaved: (date) {},
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
  onSubmit: (date) {},
  mouseCursor: null,
  canRequestFocus: true,
  clearable: false,
  baselineInputYear: 2025,
  builder: (context, style, states, child) => child,
  prefixBuilder: FDateField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Calendar"}
  calendar: const FDateFieldCalendarProperties(),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final calendar = FDateField.calendar(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  onSaved: (date) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  format: null,
  hint: null,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  clearable: false,
  builder: (context, style, states, child) => child,
  prefixBuilder: FDateField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Calendar"}
  dayBuilder: FCalendar.defaultDayBuilder,
  start: null,
  end: null,
  today: null,
  initialType: .day,
  autoHide: true,
  anchor: .topLeft,
  fieldAnchor: .bottomLeft,
  groupId: null,
  spacing: const .spacing(4),
  overflow: .flip,
  offset: .zero,
  hideRegion: .excludeChild,
  onTapHide: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final input = FDateField.input(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  onSaved: (date) {},
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
  onSubmit: (date) {},
  mouseCursor: null,
  canRequestFocus: true,
  clearable: false,
  baselineInputYear: 2025,
  builder: (context, style, states, child) => child,
  prefixBuilder: FDateField.defaultIconBuilder,
  suffixBuilder: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the date field's date.
final FDateFieldControl lifted = .lifted(date: .utc(2026), validator: (date) => null, onChange: (date) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the date field state internally.
final FDateFieldControl managedInternal = .managed(initial: .utc(2026), validator: (date) => null, onChange: (date) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external `FDateFieldController` to control the date field's state.
final FDateFieldControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FDateFieldController(date: .utc(2026), validator: (date) => null),
  onChange: (date) {},
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
