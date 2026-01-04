import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class FocusedOutlinePage extends Example {
  FocusedOutlinePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FFocusedOutline(
    focused: true,
    child: Container(
      decoration: BoxDecoration(color: context.theme.colors.primary, borderRadius: .circular(8)),
      padding: const .symmetric(vertical: 8.0, horizontal: 12),
      child: Text(
        'Focused',
        style: context.theme.typography.base.copyWith(color: context.theme.colors.primaryForeground),
      ),
    ),
  );
}
