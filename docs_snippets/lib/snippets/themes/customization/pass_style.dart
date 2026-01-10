// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'theme/accordion_style.dart';

// {@snippet}
// {@highlight}
// {@endhighlight}

@override
Widget build(BuildContext context) => FAccordion(
  // Pass the modified style to the widget.
  // {@highlight}
  style: accordionStyle(colors: context.theme.colors, typography: context.theme.typography, style: context.theme.style),
  // {@endhighlight}
  children: const [
    FAccordionItem(title: Text('Is it accessible?'), child: Text('Yes. It adheres to the WAI-ARIA design pattern.')),
  ],
);
// {@endsnippet}
