import 'package:forui/forui.dart';

final colors = FThemes.zinc.light.colors;
final typography = FThemes.zinc.light.typography;
final style = FThemes.zinc.light.style;

final a =
    // {@snippet constructor}
    // Long-form
    FAccordion(
      style: (s) => FAccordionStyle.inherit(colors: colors, typography: typography, style: style),
      children: const [],
    );
// {@endsnippet}

final b =
    // {@snippet constructor}
    // Short-form
    FAccordion(
      style: FAccordionStyle.inherit(colors: colors, typography: typography, style: style),
      children: const [],
    );
// {@endsnippet}
