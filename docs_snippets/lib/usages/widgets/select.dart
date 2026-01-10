// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final select = FSelect<String>(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  items: const {'Apple': 'apple', 'Banana': 'banana', 'Cherry': 'cherry'},
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
  onSaved: (value) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (value) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: 'Select a fruit',
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  clearable: false,
  builder: (context, style, states, child) => child,
  prefixBuilder: null,
  suffixBuilder: FSelect.defaultIconBuilder,
  // {@endcategory}
  // {@category "Content"}
  contentAnchor: AlignmentDirectional.topStart,
  fieldAnchor: AlignmentDirectional.bottomStart,
  contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 300),
  contentSpacing: const .spacing(4),
  contentOverflow: .flip,
  contentOffset: .zero,
  contentHideRegion: .excludeChild,
  contentGroupId: null,
  autoHide: true,
  contentEmptyBuilder: FSelect.defaultContentEmptyBuilder,
  contentScrollController: null,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final selectRich = FSelect<String>.rich(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  format: (value) => value,
  children: [
    .item(title: const Text('Apple'), value: 'apple'),
    .item(title: const Text('Banana'), value: 'banana'),
    .section(label: const Text('More'), items: {'Cherry': 'cherry', 'Date': 'date', 'Elderberry': 'elderberry'}),
  ],
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
  onSaved: (value) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (value) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: 'Select a fruit',
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  clearable: false,
  builder: (context, style, states, child) => child,
  prefixBuilder: null,
  suffixBuilder: FSelect.defaultIconBuilder,
  // {@endcategory}
  // {@category "Content"}
  contentAnchor: AlignmentDirectional.topStart,
  fieldAnchor: AlignmentDirectional.bottomStart,
  contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 300),
  contentSpacing: const .spacing(4),
  contentOverflow: .flip,
  contentOffset: .zero,
  contentHideRegion: .excludeChild,
  contentGroupId: null,
  autoHide: true,
  contentEmptyBuilder: FSelect.defaultContentEmptyBuilder,
  contentScrollController: null,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final selectSearch = FSelect<String>.search(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  filter: (query) => ['apple', 'banana', 'cherry'].where((e) => e.startsWith(query)),
  items: const {'Apple': 'apple', 'Banana': 'banana', 'Cherry': 'cherry'},
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
  onSaved: (value) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (value) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: 'Search fruits',
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  clearable: false,
  builder: (context, style, states, child) => child,
  prefixBuilder: null,
  suffixBuilder: FSelect.defaultIconBuilder,
  // {@endcategory}
  // {@category "Content"}
  searchFieldProperties: const FSelectSearchFieldProperties(),
  contentAnchor: AlignmentDirectional.topStart,
  fieldAnchor: AlignmentDirectional.bottomStart,
  contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 300),
  contentSpacing: const .spacing(4),
  contentOverflow: .flip,
  contentOffset: .zero,
  contentHideRegion: .excludeChild,
  contentGroupId: null,
  autoHide: true,
  contentEmptyBuilder: FSelect.defaultContentEmptyBuilder,
  contentLoadingBuilder: FSelect.defaultContentLoadingBuilder,
  contentErrorBuilder: null,
  contentScrollController: null,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final selectSearchBuilder = FSelect<String>.searchBuilder(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  format: (value) => value,
  filter: (query) => ['apple', 'banana', 'cherry'].where((e) => e.startsWith(query)),
  contentBuilder: (context, style, values) => [for (final value in values) .item(title: Text(value), value: value)],
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
  onSaved: (value) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (value) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: 'Search fruits',
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  expands: false,
  mouseCursor: .defer,
  canRequestFocus: true,
  clearable: false,
  builder: (context, style, states, child) => child,
  prefixBuilder: null,
  suffixBuilder: FSelect.defaultIconBuilder,
  // {@endcategory}
  // {@category "Content"}
  searchFieldProperties: const FSelectSearchFieldProperties(),
  contentAnchor: AlignmentDirectional.topStart,
  fieldAnchor: AlignmentDirectional.bottomStart,
  contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 300),
  contentSpacing: const .spacing(4),
  contentOverflow: .flip,
  contentOffset: .zero,
  contentHideRegion: .excludeChild,
  contentGroupId: null,
  autoHide: true,
  contentLoadingBuilder: FSelect.defaultContentLoadingBuilder,
  contentEmptyBuilder: FSelect.defaultContentEmptyBuilder,
  contentErrorBuilder: null,
  contentScrollController: null,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the select's value.
final FSelectControl<String> lifted = .lifted(value: null, onChange: (value) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the select state internally.
final FSelectControl<String> managedInternal = .managed(initial: null, toggleable: false, onChange: (value) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the select's state.
final FSelectControl<String> managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FSelectController<String>(value: null, toggleable: false),
  onChange: (value) {},
);

// {@category "Popover Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl popoverLifted = .lifted(shown: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with internal controller"}
/// Manages the popover's visibility internally.
final FPopoverControl popoverInternal = .managed(initial: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with external controller"}
/// Uses an external controller to control the popover's visibility.
final FPopoverControl popoverExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: false, motion: const FPopoverMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
