// ignore_for_file: prefer_function_declarations_over_variables, avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final alert = FAlert(
  // {@category "Style"}
  style: FAlertStyle.primary(),
  // {@endcategory}
  // {@category "Core"}
  icon: const Icon(FIcons.circleAlert),
  title: const Text('Alert Title'),
  subtitle: const Text('Alert subtitle with more details'),
  // {@endcategory}
);

// {@category "Style" "`FAlertStyle.primary()`"}
/// The alert's primary style.
final primary = FAlertStyle.primary();

// {@category "Style" "`FAlertStyle.destructive()`"}
/// The alert's destructive style.
final destructive = FAlertStyle.destructive();

// {@category "Style" "Custom `FAlertStyle`"}
/// A custom alert style.
final FBaseAlertStyle Function(FAlertStyle) custom = (style) => style;
