import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
@override
Widget build(BuildContext context) {
  final typography = context.theme.typography;

  return Text(
    'Hello World!',
    // {@highlight}
    style: typography.xs.copyWith(color: context.theme.colors.primaryForeground, fontWeight: .bold),
    // {@endhighlight}
  );
}

// {@endsnippet}
