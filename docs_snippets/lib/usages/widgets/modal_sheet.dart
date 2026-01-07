// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final show = showFSheet(
  // {@category "Core"}
  context: context,
  builder: (context) => const Padding(padding: .all(16), child: Text('Sheet content')),
  side: .btt,
  style: (style) => style,
  // {@endcategory}
  // {@category "Layout"}
  mainAxisMaxRatio: 9 / 16,
  constraints: const BoxConstraints(),
  useSafeArea: false,
  resizeToAvoidBottomInset: true,
  // {@endcategory}
  // {@category "Behavior"}
  draggable: true,
  onClosing: () {},
  // {@endcategory}
  // {@category "Barrier"}
  barrierLabel: 'Dismiss',
  barrierDismissible: true,
  // {@endcategory}
  // {@category "Navigation"}
  useRootNavigator: false,
  routeSettings: null,
  anchorPoint: null,
  transitionAnimationController: null,
  // {@endcategory}
);

final route = FModalSheetRoute<void>(
  // {@category "Core"}
  style: const FModalSheetStyle(),
  builder: (context) => const Padding(padding: .all(16), child: Text('Sheet content')),
  side: .btt,
  // {@endcategory}
  // {@category "Layout"}
  mainAxisMaxRatio: 9 / 16,
  constraints: const BoxConstraints(),
  useSafeArea: false,
  resizeToAvoidBottomInset: true,
  // {@endcategory}
  // {@category "Behavior"}
  draggable: true,
  onClosing: () {},
  // {@endcategory}
  // {@category "Barrier"}
  barrierLabel: 'Dismiss',
  barrierDismissible: true,
  barrierOnTapHint: null,
  // {@endcategory}
  // {@category "Navigation"}
  capturedThemes: null,
  settings: null,
  anchorPoint: null,
  transitionAnimationController: null,
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
