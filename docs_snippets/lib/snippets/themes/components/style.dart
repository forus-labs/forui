import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final colors = context.theme.colors;
  // {@highlight}
  final style = context.theme.style;
  // {@endhighlight}

  return DecoratedBox(
    decoration: BoxDecoration(
      // {@highlight}
      border: .all(color: colors.border, width: style.borderWidth),
      borderRadius: style.borderRadius,
      color: colors.primary,
      // {@endhighlight}
    ),
    child: const Placeholder(),
  );
}

// {@endsnippet}
