import 'package:docs_snippets/snippets/themes/custom_properties/brand_color.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final brand = context.theme.extension<BrandColor>();
  return ColoredBox(color: brand.color);
}

// {@endsnippet}
