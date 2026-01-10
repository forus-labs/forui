import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:docs_snippets/snippets/themes/custom_properties/brand_color.dart';

// {@snippet}
final theme = FThemes.zinc.light.copyWith(extensions: [const BrandColor(color: Color(0xFF6366F1))]);
// {@endsnippet}
