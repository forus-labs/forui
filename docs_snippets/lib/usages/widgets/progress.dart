// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

final progress = FProgress(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgress = FCircularProgress(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  icon: FIcons.loaderCircle,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgressLoader = FCircularProgress.loader(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgressPinwheel = FCircularProgress.pinwheel(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final determinateProgress = FDeterminateProgress(
  // {@category "Core"}
  key: const Key('key'),
  style: (style) => style,
  value: 0.5,
  // {@endcategory}
  // {@category "Accessibility"}
  semanticsLabel: 'Loading 50%',
  // {@endcategory}
);
