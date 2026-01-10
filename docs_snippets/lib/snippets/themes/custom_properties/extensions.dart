// ignore_for_file: always_use_package_imports

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'brand_color.dart';

// {@snippet}

// {@endsnippet}

final theme =
    // {@snippet constructor}
    FThemeData(
      colors: FThemes.zinc.light.colors,
      // ... other theme properties
      extensions: [const BrandColor(color: Color(0xFF6366F1))],
    );
// {@endsnippet}
