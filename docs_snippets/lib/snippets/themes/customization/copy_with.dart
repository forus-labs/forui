import 'package:flutter/cupertino.dart';

import 'package:forui/forui.dart';

late BuildContext context;

final accordion =
    // {@snippet constructor}
    FAccordion(
      style: (style) =>
          style.copyWith(focusedOutlineStyle: (style) => style.copyWith(color: context.theme.colors.background)),
      children: const [],
    );
// {@endsnippet}
