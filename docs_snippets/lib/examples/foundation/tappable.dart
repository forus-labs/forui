import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TappablePage extends Example {
  TappablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FTappable(
    builder: (context, states, child) => Container(
      decoration: BoxDecoration(
        color: (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed))
            ? context.theme.colors.secondary
            : context.theme.colors.background,
        borderRadius: .circular(8),
        border: .all(color: context.theme.colors.border),
      ),
      padding: const .symmetric(vertical: 8.0, horizontal: 12),
      child: child!,
    ),
    child: const Text('Tappable'),
    onPress: () {},
  );
}
