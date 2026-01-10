// ignore_for_file: always_use_package_imports, unused_import
// {@snippet}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'accordion_style.dart';

// {@highlight}
// {@endhighlight}

// {@endsnippet}

FAccordionStyle accordionStyle({required FColors colors, required FTypography typography, required FStyle style}) =>
    throw UnimplementedError();

// {@snippet}
FThemeData get zincLight {
  final colors = FThemes.zinc.light.colors;

  final typography = _typography(colors: colors);
  final style = _style(colors: colors, typography: typography);

  return FThemeData(
    colors: colors,
    typography: typography,
    style: style,
    // Add your generated styles here.
    // {@highlight}
    accordionStyle: accordionStyle(colors: colors, typography: typography, style: style),
    // {@endhighlight}
  );
}

FTypography _typography({required FColors colors, String defaultFontFamily = 'packages/forui/Inter'}) => FTypography(
  xs: TextStyle(color: colors.foreground, fontFamily: defaultFontFamily, fontSize: 12, height: 1),
  sm: TextStyle(color: colors.foreground, fontFamily: defaultFontFamily, fontSize: 14, height: 1.25),
);

FStyle _style({required FColors colors, required FTypography typography}) => FStyle(
  formFieldStyle: .inherit(colors: colors, typography: typography),
  focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: const .all(.circular(8))),
  iconStyle: IconThemeData(color: colors.primary, size: 20),
  tappableStyle: FTappableStyle(),
);
// {@endsnippet}
