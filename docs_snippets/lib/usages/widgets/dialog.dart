// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final dialog = FDialog(
  // {@category "Core"}
  style: (style) => style,
  title: const Text('Title'),
  body: const Text('Body'),
  actions: [FButton(onPress: () {}, child: const Text('Action'))],
  // {@endcategory}
  // {@category "Layout"}
  direction: .vertical,
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
);

final adaptive = FDialog.adaptive(
  // {@category "Core"}
  style: (style) => style,
  title: const Text('Title'),
  body: const Text('Body'),
  actions: [FButton(onPress: () {}, child: const Text('Action'))],
  // {@endcategory}
  // {@category "Layout"}
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
);

final raw = FDialog.raw(
  // {@category "Core"}
  style: (style) => style,
  builder: (context, style) => const Text('Custom content'),
  // {@endcategory}
  // {@category "Layout"}
  constraints: const BoxConstraints(minWidth: 280, maxWidth: 560),
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Dialog',
  // {@endcategory}
  // {@category "Others"}
  animation: null,
  // {@endcategory}
);

final show = showFDialog(
  // {@category "Core"}
  context: context,
  style: (style) => style,
  routeStyle: (style) => style,
  builder: (context, style, animation) => FDialog(
    style: (_) => style,
    animation: animation,
    title: const Text('Title'),
    body: const Text('Body'),
    actions: [FButton(onPress: () => Navigator.of(context).pop(), child: const Text('Close'))],
  ),
  // {@endcategory}
  // {@category "Barrier"}
  barrierLabel: 'Dismiss',
  barrierDismissible: true,
  // {@endcategory}
  // {@category "Navigation"}
  useRootNavigator: false,
  useSafeArea: false,
  routeSettings: null,
  anchorPoint: null,
  transitionAnimationController: null,
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
