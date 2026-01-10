// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final badge = FBadge(
  // {@category "Style"}
  style: FBadgeStyle.primary(),
  // {@endcategory}
  // {@category "Core"}
  child: const Text('Badge'),
  // {@endcategory}
);

final raw = FBadge.raw(
  // {@category "Style"}
  style: FBadgeStyle.primary(),
  // {@endcategory}
  // {@category "Core"}
  builder: (context, style) => const Text('Badge'),
  // {@endcategory}
);

// {@category "Style" "`FBadgeStyle.primary()`"}
/// The badge's primary style.
final primary = FBadgeStyle.primary();

// {@category "Style" "`FBadgeStyle.secondary()`"}
/// The badge's secondary style.
final secondary = FBadgeStyle.secondary();

// {@category "Style" "`FBadgeStyle.outline()`"}
/// The badge's outline style.
final outline = FBadgeStyle.outline();

// {@category "Style" "`FBadgeStyle.destructive()`"}
/// The badge's destructive style.
final destructive = FBadgeStyle.destructive();

// {@category "Style" "Custom `FBadgeStyle`"}
/// A custom badge style.
final FBaseBadgeStyle Function(FBadgeStyle) custom = (style) => style;
