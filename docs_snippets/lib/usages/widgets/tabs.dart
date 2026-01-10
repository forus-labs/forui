// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final tabs = FTabs(
  // {@category "Core"}
  style: (style) => style,
  mouseCursor: .defer,
  onPress: (index) {},
  children: const [
    FTabEntry(label: Text('Tab 1'), child: Text('Content 1')),
    FTabEntry(label: Text('Tab 2'), child: Text('Content 2')),
  ],
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Scroll"}
  scrollable: false,
  physics: null,
  // {@endcategory}
);

const tabEntry = FTabEntry(
  // {@category "Core"}
  label: Text('Tab Label'),
  child: Text('Tab Content'),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the selected tab index.
final FTabControl lifted = .lifted(index: 0, onChange: (index) {}, motion: const FTabMotion());

// {@category "Control" "`.managed()` with internal controller"}
/// Manages tab state internally.
final FTabControl managedInternal = .managed(initial: 0, motion: const FTabMotion(), onChange: (index) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for tab management.
final FTabControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FTabController(length: 3, vsync: vsync),
  onChange: (index) {},
);

TickerProvider get vsync => throw UnimplementedError();
