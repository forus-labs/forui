// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final pagination = FPagination(
  // {@category "Core"}
  style: (style) => style,
  previous: const Icon(FIcons.chevronLeft),
  next: const Icon(FIcons.chevronRight),
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the pagination's page.
final FPaginationControl lifted = .lifted(page: 0, pages: 10, siblings: 1, showEdges: true, onChange: (page) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the pagination state internally.
final FPaginationControl managedInternal = .managed(
  initial: 0,
  pages: 10,
  siblings: 1,
  showEdges: true,
  onChange: (page) {},
);

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller to control the pagination's state.
final FPaginationControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPaginationController(page: 0, pages: 10, siblings: 1, showEdges: true),
  onChange: (page) {},
);
