// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final selectMenuTile = FSelectMenuTile<String>(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  autoHide: true,
  divider: .full,
  title: const Text('Select Option'),
  prefix: const Icon(FIcons.list),
  subtitle: const Text('Choose one'),
  detailsBuilder: (context, values, child) => Text(values.join(', ')),
  details: null,
  suffix: const Icon(FIcons.chevronsUpDown),
  menu: const [
    .tile(title: Text('Option 1'), value: 'option1'),
    .tile(title: Text('Option 2'), value: 'option2'),
  ],
  // {@endcategory}
  // {@category "Select Control"}
  selectControl: const .managedRadio(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  onSaved: (values) {},
  onReset: () {},
  validator: (values) => null,
  forceErrorText: null,
  autovalidateMode: .disabled,
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topRight,
  tileAnchor: .bottomRight,
  menuSpacing: const .spacing(4),
  menuOverflow: .flip,
  menuOffset: .zero,
  menuHideRegion: .excludeChild,
  menuOnTapHide: null,
  menuGroupId: null,
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  menuFocusNode: null,
  menuOnFocusChange: (focused) {},
  menuTraversalEdgeBehavior: null,
  menuBarrierSemanticsLabel: null,
  menuBarrierSemanticsDismissible: true,
  semanticsLabel: 'Select menu',
  shortcuts: null,
  actions: null,
  // {@endcategory}
);

final selectMenuTileBuilder = FSelectMenuTile<String>.builder(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  autoHide: true,
  divider: .full,
  title: const Text('Select Option'),
  prefix: const Icon(FIcons.list),
  subtitle: const Text('Choose one'),
  detailsBuilder: (context, values, child) => Text(values.join(', ')),
  details: null,
  suffix: const Icon(FIcons.chevronsUpDown),
  menuBuilder: (context, index) => FSelectTile(title: Text('Option $index'), value: 'option$index'),
  count: 10,
  // {@endcategory}
  // {@category "Select Control"}
  selectControl: const .managedRadio(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  onSaved: (values) {},
  onReset: () {},
  validator: (values) => null,
  forceErrorText: null,
  autovalidateMode: .disabled,
  // {@endcategory}
  // {@category "Layout"}
  menuAnchor: .topRight,
  tileAnchor: .bottomRight,
  menuSpacing: const .spacing(4),
  menuOverflow: .flip,
  menuOffset: .zero,
  menuHideRegion: .excludeChild,
  menuOnTapHide: null,
  menuGroupId: null,
  // {@endcategory}
  // {@category "Scroll"}
  scrollController: null,
  cacheExtent: null,
  maxHeight: .infinity,
  dragStartBehavior: .start,
  physics: const ClampingScrollPhysics(),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  menuFocusNode: null,
  menuOnFocusChange: (focused) {},
  menuTraversalEdgeBehavior: null,
  menuBarrierSemanticsLabel: null,
  menuBarrierSemanticsDismissible: true,
  semanticsLabel: 'Select menu',
  shortcuts: null,
  actions: null,
  // {@endcategory}
);

// {@category "Select Control" "`.lifted()`"}
/// Externally controls the selected values.
final FMultiValueControl<String> lifted = .lifted(value: const {'option1'}, onChange: (values) {});

// {@category "Select Control" "`.managedRadio()` with internal notifier"}
/// Single selection mode with internal notifier.
final FMultiValueControl<String> managedRadioInternal = .managedRadio(initial: 'option1', onChange: (values) {});

// {@category "Select Control" "`.managedRadio()` with external controller"}
/// Single selection mode with external controller.
final FMultiValueControl<String> managedRadioExternal = .managedRadio(
  // For demonstration purposes only. Don't create a notifier inline, store it in a State instead.
  controller: .radio('option1'),
  onChange: (values) {},
);

// {@category "Select Control" "`.managed()` with internal notifier"}
/// Multiple selection mode with internal controller.
final FMultiValueControl<String> managedInternal = .managed(
  initial: const {'option1', 'option2'},
  min: 1,
  max: 3,
  onChange: (values) {},
);

// {@category "Select Control" "`.managed()` with external controller"}
/// Multiple selection mode with external controller.
final FMultiValueControl<String> managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FMultiValueNotifier(value: const {'option1', 'option2'}, min: 1, max: 3),
  onChange: (values) {},
);

// {@category "Popover Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl popoverLifted = .lifted(shown: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with internal controller"}
/// Manages the popover's visibility internally.
final FPopoverControl popoverInternal = .managed(initial: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with external controller"}
/// Uses an external `FPopoverController` to control the popover's visibility.
final FPopoverControl popoverExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: false, motion: const FPopoverMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
