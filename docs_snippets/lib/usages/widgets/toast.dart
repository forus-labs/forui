// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

const toast = FToast(
  // {@category "Core"}
  style: null,
  icon: Icon(FIcons.info),
  title: Text('Title'),
  description: Text('Description'),
  suffix: Icon(FIcons.x),
  // {@endcategory}
);

final toaster = FToaster(
  // {@category "Core"}
  style: (style) => style,
  child: const Placeholder(),
  // {@endcategory}
);

final showToast = showFToast(
  // {@category "Core"}
  context: context,
  style: (style) => style,
  icon: const Icon(FIcons.info),
  title: const Text('Title'),
  description: const Text('Description'),
  suffixBuilder: (context, entry) => GestureDetector(onTap: entry.dismiss, child: const Icon(FIcons.x)),
  // {@category "Behavior"}
  alignment: .bottomEnd,
  swipeToDismiss: const [.right],
  duration: const Duration(seconds: 5),
  onDismiss: () {},
  // {@endcategory}
);

final showRawToast = showRawFToast(
  // {@category "Core"}
  context: context,
  style: (style) => style,
  builder: (context, entry) => const Text('Custom toast content'),
  // {@endcategory}
  // {@category "Behavior"}
  alignment: .bottomEnd,
  swipeToDismiss: const [.right],
  duration: const Duration(seconds: 5),
  onDismiss: () {},
  // {@endcategory}
);

BuildContext get context => throw UnimplementedError();
