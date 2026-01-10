// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final show = showFPersistentSheet(
  // {@category "Core"}
  context: context,
  style: (style) => style,
  side: .btt,
  builder: (context, controller) => Padding(
    padding: const .all(16),
    child: Column(
      mainAxisSize: .min,
      children: [
        const Text('Sheet content'),
        FButton(onPress: controller.hide, child: const Text('Close')),
      ],
    ),
  ),
  // {@endcategory}
  // {@category "Layout"}
  mainAxisMaxRatio: 9 / 16,
  constraints: const BoxConstraints(),
  useSafeArea: false,
  resizeToAvoidBottomInset: true,
  anchorPoint: null,
  // {@endcategory}
  // {@category "Behavior"}
  draggable: true,
  keepAliveOffstage: false,
  onClosing: () {},
  // {@endcategory}
);

const sheets = FSheets(
  // {@category "Core"}
  child: Placeholder(),
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
