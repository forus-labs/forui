// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final multiSelect = FMultiSelect<String>(
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
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: const Text('Select fruits'),
  keepHint: true,
  sort: null,
  tagBuilder: FMultiSelect.defaultTagBuilder,
  textAlign: .start,
  textDirection: null,
  clearable: false,
  prefixBuilder: null,
  suffixBuilder: FMultiSelect.defaultIconBuilder,
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
  contentEmptyBuilder: FMultiSelect.defaultContentEmptyBuilder,
  contentScrollController: null,
  contentScrollHandles: false,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final multiSelectRich = FMultiSelect<String>.rich(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  format: Text.new,
  children: [
    .item(title: const Text('Apple'), value: 'apple'),
    .item(title: const Text('Banana'), value: 'banana'),
    .section(label: const Text('More'), items: {'Cherry': 'cherry', 'Date': 'date'}),
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
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: const Text('Select fruits'),
  keepHint: true,
  sort: null,
  tagBuilder: FMultiSelect.defaultTagBuilder,
  textAlign: .start,
  textDirection: null,
  clearable: false,
  prefixBuilder: null,
  suffixBuilder: FMultiSelect.defaultIconBuilder,
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
  contentEmptyBuilder: FMultiSelect.defaultContentEmptyBuilder,
  contentScrollController: null,
  contentScrollHandles: false,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final multiSelectSearch = FMultiSelect<String>.search(
  // {@category "Core"}
  const {'Apple': 'apple', 'Banana': 'banana', 'Cherry': 'cherry'},
  style: (style) => style,
  enabled: true,
  filter: (query) => ['apple', 'banana', 'cherry'].where((e) => e.startsWith(query)),
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
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: const Text('Search fruits'),
  keepHint: true,
  sort: null,
  tagBuilder: FMultiSelect.defaultTagBuilder,
  textAlign: .start,
  textDirection: null,
  clearable: false,
  prefixBuilder: null,
  suffixBuilder: FMultiSelect.defaultIconBuilder,
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
  contentEmptyBuilder: FMultiSelect.defaultContentEmptyBuilder,
  contentLoadingBuilder: FMultiSelect.defaultContentLoadingBuilder,
  contentErrorBuilder: null,
  contentScrollController: null,
  contentScrollHandles: false,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

final multiSelectSearchBuilder = FMultiSelect<String>.searchBuilder(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  filter: (query) => ['apple', 'banana', 'cherry'].where((e) => e.startsWith(query)),
  format: Text.new,
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
  onSaved: (values) {},
  onReset: () {},
  autovalidateMode: .onUnfocus,
  forceErrorText: null,
  validator: (values) => null,
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  // {@endcategory}
  // {@category "Field"}
  hint: const Text('Search fruits'),
  keepHint: true,
  sort: null,
  tagBuilder: FMultiSelect.defaultTagBuilder,
  textAlign: .start,
  textDirection: null,
  clearable: false,
  prefixBuilder: null,
  suffixBuilder: FMultiSelect.defaultIconBuilder,
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
  contentEmptyBuilder: FMultiSelect.defaultContentEmptyBuilder,
  contentLoadingBuilder: FMultiSelect.defaultContentLoadingBuilder,
  contentErrorBuilder: null,
  contentScrollController: null,
  contentScrollHandles: false,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the multi-select's values.
final FMultiValueControl<String> lifted = .lifted(value: {}, onChange: (values) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the multi-select state internally.
final FMultiValueControl<String> managedInternal = .managed(initial: {}, min: 0, max: null, onChange: (values) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the multi-select's state.
final FMultiValueControl<String> managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FMultiValueNotifier<String>(value: {}, min: 0, max: 5),
  onChange: (values) {},
);

// {@category "Control" "`.managedRadio()` with internal controller"}
/// Single selection with internal controller.
final FMultiValueControl<String> managedRadioInternal = .managedRadio(initial: null, onChange: (values) {});

// {@category "Control" "`.managedRadio()` with external controller"}
/// Single selection with external controller.
final FMultiValueControl<String> managedRadioExternal = .managedRadio(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .radio(),
  onChange: (values) {},
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
