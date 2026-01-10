// ignore_for_file: avoid_redundant_argument_values, prefer_function_declarations_over_variables, sort_child_properties_last

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final button = FButton(
  // {@category "Style"}
  style: FButtonStyle.primary(),
  // {@endcategory}
  // {@category "Core"}
  selected: false,
  onPress: () {},
  child: const Text('Button'),
  // {@endcategory}
  // {@category "Content"}
  prefix: const Icon(FIcons.mail),
  suffix: null,
  mainAxisSize: .max,
  mainAxisAlignment: .center,
  crossAxisAlignment: .center,
  textBaseline: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

final icon = FButton.icon(
  // {@category "Style"}
  style: FButtonStyle.outline(),
  // {@endcategory}
  // {@category "Core"}
  selected: false,
  onPress: () {},
  child: const Icon(FIcons.mail),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

final raw = FButton.raw(
  // {@category "Style"}
  style: FButtonStyle.primary(),
  // {@endcategory}
  // {@category "Core"}
  selected: false,
  onPress: () {},
  child: const Text('Button'),
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  onFocusChange: (focused) {},
  shortcuts: null,
  actions: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onLongPress: null,
  onSecondaryPress: null,
  onSecondaryLongPress: null,
  onHoverChange: (hovered) {},
  onStateChange: (states) {},
  // {@endcategory}
);

// {@category "Style" "`FButtonStyle.primary()`"}
/// The button's primary style.
final primary = FButtonStyle.primary();

// {@category "Style" "`FButtonStyle.secondary()`"}
/// The button's secondary style.
final secondary = FButtonStyle.secondary();

// {@category "Style" "`FButtonStyle.destructive()`"}
/// The button's destructive style.
final destructive = FButtonStyle.destructive();

// {@category "Style" "`FButtonStyle.outline()`"}
/// The button's outline style.
final outline = FButtonStyle.outline();

// {@category "Style" "`FButtonStyle.ghost()`"}
/// The button's ghost style.
final ghost = FButtonStyle.ghost();

// {@category "Style" "Custom `FButtonStyle`"}
/// A custom button style.
final FButtonStyle Function(FButtonStyle) custom = (style) => style;
