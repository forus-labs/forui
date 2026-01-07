// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

final progress = FProgress(
  // {@category "Core"}
  style: (style) => style,
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgress = FCircularProgress(
  // {@category "Core"}
  style: (style) => style,
  icon: FIcons.loaderCircle,
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgressLoader = FCircularProgress.loader(
  // {@category "Core"}
  style: (style) => style,
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final circularProgressPinwheel = FCircularProgress.pinwheel(
  // {@category "Core"}
  style: (style) => style,
  semanticsLabel: 'Loading',
  // {@endcategory}
);

final determinateProgress = FDeterminateProgress(
  // {@category "Core"}
  style: (style) => style,
  semanticsLabel: 'Loading 50%',
  value: 0.5,
  // {@endcategory}
);
