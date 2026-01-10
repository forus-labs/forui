import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) => FTheme(
  data: FThemeData(
    colors: FThemes.zinc.light.colors,
    // {@highlight}
    typography: FThemes.zinc.light.typography
        .copyWith(xs: const TextStyle(fontSize: 12, height: 1))
        .scale(sizeScalar: 0.8),
    // {@endhighlight}
  ),
  child: const FScaffold(child: Placeholder()),
);
// {@endsnippet}
