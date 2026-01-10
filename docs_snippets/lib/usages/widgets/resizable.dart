// ignore_for_file: avoid_redundant_argument_values, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final resizable = FResizable(
  // {@category "Core"}
  style: (style) => style,
  axis: .vertical,
  divider: .dividerWithThumb,
  children: [
    FResizableRegion(initialExtent: 200, builder: (context, data, child) => child!),
    FResizableRegion(initialExtent: 200, minExtent: 100, builder: (context, data, child) => child!),
  ],
  // {@endcategory}
  // {@category "Control"}
  control: const .managedCascade(),
  // {@endcategory}
  // {@category "Layout"}
  crossAxisExtent: null,
  hitRegionExtent: 10,
  resizePercentage: 0.005,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticFormatterCallback: (first, second) => '${first.extent.current}, ${second.extent.current}',
  // {@endcategory}
);

final resizableRegion = FResizableRegion(
  // {@category "Core"}
  initialExtent: 200,
  minExtent: 100,
  builder: (context, data, child) => child!,
  child: const Placeholder(),
  // {@endcategory}
);

// {@category "Control" "`.managed()` with internal controller"}
/// Non-cascading resize with internal controller.
final FResizableControl managedInternal = .managed(onResizeUpdate: (resized) {}, onResizeEnd: (resized) {});

// {@category "Control" "`.managed()` with external controller"}
/// Non-cascading resize with external controller.
final FResizableControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FResizableController(onResizeUpdate: (resized) {}, onResizeEnd: (resized) {}),
);

// {@category "Control" "`.managedCascade()` with internal controller"}
/// Cascading resize with internal controller.
final FResizableControl managedCascadeInternal = .managedCascade(onResizeUpdate: (resized) {}, onResizeEnd: (all) {});

// {@category "Control" "`.managedCascade()` with external controller"}
/// Cascading resize with external controller.
final FResizableControl managedCascadeExternal = .managedCascade(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FResizableController.cascade(onResizeUpdate: (resized) {}, onResizeEnd: (all) {}),
);
